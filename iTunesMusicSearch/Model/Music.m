//
//  Music.m
//  iTunesMusicSearch
//
//  Created by Durgesh Gupta on 8/15/15.
//  Copyright (c) 2015 Durgesh Gupta. All rights reserved.
//

#import "Music.h"

#define TRACK_NAME             @"trackName"
#define ARTIST_NAME            @"artistName"
#define IMAGE_URL              @"artworkUrl100"
#define ALBUM_NAME             @"collectionName"




@implementation Music

-(instancetype)initWithDict:(NSDictionary *)dict{
    
    self = [super init];
    if (self) {
        self.trackName = (![dict[TRACK_NAME] isKindOfClass:[NSNull class]] ? dict[TRACK_NAME] : [NSNull null]);
        self.artistName = (![dict[ARTIST_NAME] isKindOfClass:[NSNull class]] ? dict[ARTIST_NAME] : [NSNull null]);
        self.albumName = (![dict[ALBUM_NAME] isKindOfClass:[NSNull class]] ? dict[ALBUM_NAME] : [NSNull null]);
        self.imageURL = (![dict[IMAGE_URL] isKindOfClass:[NSNull class]]? dict[IMAGE_URL] : [NSNull null]);
        self.uniqueNumber = [NSString stringWithFormat:@"%d",arc4random() % 16];
        
    }
    return self;
}


@end
