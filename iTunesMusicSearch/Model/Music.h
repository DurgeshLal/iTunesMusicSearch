//
//  Music.h
//  iTunesMusicSearch
//
//  Created by Durgesh Gupta on 8/15/15.
//  Copyright (c) 2015 Durgesh Gupta. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Music : NSObject

@property (strong, nonatomic) NSString *trackName;
@property (strong, nonatomic) NSString *artistName;
@property (strong, nonatomic) NSString *albumName;
@property (strong, nonatomic) NSString *imageURL;
@property (strong, nonatomic) NSString *uniqueNumber; // This unique ID is used to match with the cell once image is fetched and put on proper cell

-(instancetype)initWithDict:(NSDictionary *)dict;

@end
