//
//  KJFileHandleManager.m
//  KJPlayerDemo
//
//  Created by 杨科军 on 2021/2/10.
//  Copyright © 2021 杨科军. All rights reserved.
//  https://github.com/yangKJ/KJPlayerDemo

#import "KJFileHandleManager.h"

static NSInteger const kPackageLength = 204800;
@interface KJFileHandleManager ()
@property (nonatomic,strong) KJFileHandleInfo *cacheInfo;
@property (nonatomic,strong) NSFileHandle *readHandle;
@property (nonatomic,strong) NSFileHandle *writeHandle;
@property (nonatomic,strong) NSDate *startDate;

@end

@implementation KJFileHandleManager
- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [self kj_writeSave];
    [_readHandle closeFile];
    [_writeHandle closeFile];
}
- (instancetype)initWithURL:(NSURL*)url{
    if (self = [super init]){
        NSString *filePath = [KJCacheManager kj_createVideoCachedPath:url];
        [KJCacheManager kj_createFilePath:filePath];
        if (![[NSFileManager defaultManager] fileExistsAtPath:filePath]){
            [[NSFileManager defaultManager] createFileAtPath:filePath contents:nil attributes:nil];
        }
        NSURL *fileURL = [NSURL fileURLWithPath:filePath];
        self.readHandle = [NSFileHandle fileHandleForReadingFromURL:fileURL error:nil];
        self.writeHandle = [NSFileHandle fileHandleForWritingToURL:fileURL error:nil];
        self.cacheInfo = [KJFileHandleInfo kj_createFileHandleInfoWithURL:url];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(applicationDidEnterBackground:) name:UIApplicationDidEnterBackgroundNotification object:nil];
    }
    return self;
}
/* 进入后台 */
- (void)applicationDidEnterBackground:(NSNotification*)notification{
    [self kj_writeSave];
}
- (void)kj_setWriteHandleContentLenght:(NSUInteger)contentLength{
    [self.writeHandle truncateFileAtOffset:contentLength];
    [self.writeHandle synchronizeFile];
}
/* 获取指定区间已经缓存的碎片 */
- (NSArray*)kj_getCachedFragmentsWithRange:(NSRange)range{
    if (range.location == NSNotFound) return [NSMutableArray array].mutableCopy;
    NSInteger endOffset = range.location + range.length;
    NSMutableArray *fragments = [NSMutableArray array];
    [self.cacheInfo.cacheFragments enumerateObjectsUsingBlock:^(NSValue *obj, NSUInteger idx, BOOL *stop){
        NSRange inRange = NSIntersectionRange(range, obj.rangeValue);
        if (inRange.length > 0){
            NSInteger package = inRange.length / kPackageLength;
            for (NSInteger i = 0; i <= package; i++){
                KJCacheFragment fragment;
                fragment.type = 0;
                NSInteger offset = inRange.location + i * kPackageLength;
                NSInteger maxLocation = inRange.location + inRange.length;
                NSInteger length = (offset + kPackageLength) > maxLocation ? (maxLocation - offset) : kPackageLength;
                fragment.range = NSMakeRange(offset, length);
                [fragments addObject:[DBPlayerDataInfo kj_cacheFragment:fragment]];
            }
        }else if (obj.rangeValue.location >= endOffset){
            *stop = YES;
        }
    }];
    if (fragments.count == 0){
        [fragments addObject:[DBPlayerDataInfo kj_cacheFragment:(KJCacheFragment){1,range}]];
    }else{//远端服务器碎片
        NSMutableArray *remoteFragments = [NSMutableArray array];
        [fragments enumerateObjectsUsingBlock:^(NSValue *obj, NSUInteger idx, BOOL *stop){
            KJCacheFragment fragment = [DBPlayerDataInfo kj_getCacheFragment:obj];
            if (idx == 0){
                if (range.location < fragment.range.location){
                    KJCacheFragment action = {1,NSMakeRange(range.location, fragment.range.location - range.location)};
                    [remoteFragments addObject:[DBPlayerDataInfo kj_cacheFragment:action]];
                }
                [remoteFragments addObject:[DBPlayerDataInfo kj_cacheFragment:fragment]];
            }else{
                KJCacheFragment lastFragment = [DBPlayerDataInfo kj_getCacheFragment:remoteFragments.lastObject];
                NSInteger lastOffset = lastFragment.range.location + lastFragment.range.length;
                if (fragment.range.location > lastOffset){
                    [remoteFragments addObject:[DBPlayerDataInfo kj_cacheFragment:(KJCacheFragment){1,NSMakeRange(lastOffset, fragment.range.location - lastOffset)}]];
                }
                [remoteFragments addObject:[DBPlayerDataInfo kj_cacheFragment:fragment]];
            }
            if (idx == fragments.count - 1){
                NSInteger localEndOffset = fragment.range.location + fragment.range.length;
                if (endOffset > localEndOffset){
                    [remoteFragments addObject:[DBPlayerDataInfo kj_cacheFragment:(KJCacheFragment){1,NSMakeRange(localEndOffset, endOffset - localEndOffset)}]];
                }
            }
        }];
        fragments = remoteFragments;
    }
    return [fragments copy];
}
/* 写入已下载分片数据 */
- (void)kj_writeCacheData:(NSData*)data Range:(NSRange)range error:(NSError **)error{
    @synchronized(self.writeHandle) {
        @try {
            [self.writeHandle seekToFileOffset:range.location];
            [self.writeHandle writeData:data];
            [self.cacheInfo kj_continueCacheFragmentRange:range];
        }@catch (NSException *exception) {
            *error = [NSError errorWithDomain:exception.name code:KJPlayerCustomCodeWriteFileFailed userInfo:nil];
        }@finally { }
    }
}
/* 读取已下载分片缓存数据 */
- (NSData*)kj_readCachedDataWithRange:(NSRange)range{
    @synchronized(self.readHandle) {
        [self.readHandle seekToFileOffset:range.location];
        return [self.readHandle readDataOfLength:range.length];
    }
}
- (void)kj_writeSave{
    @synchronized (self.writeHandle){
        [self.writeHandle synchronizeFile];
        [self.cacheInfo kj_keyedArchiverSave];
    }
}

- (void)kj_startWritting{
    self.startDate = [NSDate date];
}

- (void)kj_finishWritting{
    self.cacheInfo.downloadTime = [[NSDate date] timeIntervalSinceDate:self.startDate];
}

@end
