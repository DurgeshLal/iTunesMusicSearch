//
//  LyricsViewController.m
//  iTunesMusicSearch
//
//  Created by Durgesh Gupta on 8/15/15.
//  Copyright (c) 2015 Durgesh Gupta. All rights reserved.
//

#import "LyricsViewController.h"
#import "ImageDownloader.h"

@interface LyricsViewController ()

@end

@implementation LyricsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self displayContent];
}

-(void)displayContent{
    
    self.lblAlbum.text = [NSString stringWithFormat:@"Album : %@",self.musicObject.albumName];
    self.lblArtist.text = [NSString stringWithFormat:@"Artist : %@",self.musicObject.artistName];;
    self.lblTrack.text = [NSString stringWithFormat:@"Track : %@",self.musicObject.trackName];;
    __weak LyricsViewController *weakSelf = self;
    [ImageDownloader imageWithURL:self.musicObject.imageURL uniqueID:self.musicObject.uniqueNumber andCompletionBlock:^(UIImage *image, NSString *uniqueID) {
        if (image) {
            if (![uniqueID isEqualToString:self.musicObject.uniqueNumber]) {
                return;
            }
            dispatch_async(dispatch_get_main_queue(), ^{
                weakSelf.imgCover.image = image;
            });
            
        }
    }];

}



@end
