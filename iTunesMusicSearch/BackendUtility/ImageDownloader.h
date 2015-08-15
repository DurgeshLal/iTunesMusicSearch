//
//  ImageDownloader.h
//  iTunesMusicSearch
//
//  Created by Durgesh Gupta on 8/15/15.
//  Copyright (c) 2015 Durgesh Gupta. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef void(^receivedData)(UIImage *image, NSString *uniqueID);

@interface ImageDownloader : NSObject

+ (void)imageWithURL:(NSString *)url uniqueID:(NSString *)uniqueID andCompletionBlock:(receivedData)compblock;
@end
