//
//  MusicDataManager.h
//  iTunesMusicSearch
//
//  Created by Durgesh Gupta on 8/15/15.
//  Copyright (c) 2015 Durgesh Gupta. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^CompletionHandler)(id responseData);
@interface MusicDataManager : NSObject

+(instancetype)sharedManager;
-(void)fetchMusicListWithSearchString:(NSString *)searchString CompletionHandler:(CompletionHandler)iHandler;
@end
