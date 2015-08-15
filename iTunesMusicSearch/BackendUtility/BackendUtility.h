//
//  BackendUtility.h
//  iTunesMusicSearch
//
//  Created by Durgesh Gupta on 8/15/15.
//  Copyright (c) 2015 Durgesh Gupta. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void(^receivedData)(id receivedData);

@interface BackendUtility : NSObject

+ (void)requestWithURL:(NSString *)url andCompletionBlock:(receivedData)compblock;
@end
