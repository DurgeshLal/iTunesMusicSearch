//
//  ImageDownloader.m
//  iTunesMusicSearch
//
//  Created by Durgesh Gupta on 8/15/15.
//  Copyright (c) 2015 Durgesh Gupta. All rights reserved.
//

#import "ImageDownloader.h"

@implementation ImageDownloader

+ (void)imageWithURL:(NSString *)url uniqueID:(NSString *)uniqueID andCompletionBlock:(receivedData)compblock{
    
    NSString *urlString =[NSString stringWithFormat:@"%@",url];
    
    urlString = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSURLSession *session = [NSURLSession sharedSession];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:urlString]];
    
    [request setHTTPMethod:@"GET"];
    
    [request addValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    
    [[session dataTaskWithRequest:request completionHandler:^(NSData *data,NSURLResponse *response,NSError *error) {
        // handle response
        
        if (data) {
            UIImage *image = [UIImage imageWithData:data];
            compblock(image,uniqueID);
        }
      
    }] resume];

}
@end
