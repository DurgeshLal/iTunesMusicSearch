//
//  MusicDataManager.m
//  iTunesMusicSearch
//
//  Created by Durgesh Gupta on 8/15/15.
//  Copyright (c) 2015 Durgesh Gupta. All rights reserved.
//

#define GET_MUSIC_API @"https://itunes.apple.com/search?term="

#import "MusicDataManager.h"
#import "BackendUtility.h"
#import "Music.h"

@implementation MusicDataManager

+ (instancetype)allocWithZone:(NSZone *)zone
{
    static dispatch_once_t onceQueue;
    static MusicDataManager *sharedManager = nil;
    dispatch_once(&onceQueue, ^{
        
        if (sharedManager == nil) {
            sharedManager = [super allocWithZone:zone];
        }
    });
    
    return sharedManager;
}

+(instancetype)sharedManager{
    
    static dispatch_once_t once = 0;
    static MusicDataManager *sharedManager;
    
    if (sharedManager) {
        return sharedManager;
    }
    
    dispatch_once(&once, ^{
        
        if (!sharedManager) {
            sharedManager = [[MusicDataManager alloc]init];
        }
    });
    
    return sharedManager;
}

#pragma Mark Public method
-(void)fetchMusicListWithSearchString:(NSString *)searchString CompletionHandler:(CompletionHandler)iHandler
{
   // __weak MusicDataManager *weakSelf = self;
    NSString *urlString = [GET_MUSIC_API stringByAppendingString:searchString];
    __block NSMutableArray *dataSourceArray = [[NSMutableArray alloc] init];
    [BackendUtility requestWithURL:urlString andCompletionBlock:^(id receivedData) {
        NSArray *dataArray = (NSArray *)receivedData[@"results"];
       
        for (NSDictionary *modelDict in dataArray)
        {
            Music *iObject = [[Music alloc] initWithDict:modelDict];
            [dataSourceArray addObject:iObject];
        }

        iHandler(dataSourceArray);
    }];

}


@end
