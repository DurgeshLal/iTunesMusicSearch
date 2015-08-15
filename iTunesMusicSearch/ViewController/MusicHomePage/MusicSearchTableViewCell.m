//
//  MusicSearchTableViewCell.m
//  iTunesMusicSearch
//
//  Created by Durgesh Gupta on 8/15/15.
//  Copyright (c) 2015 Durgesh Gupta. All rights reserved.
//


#import "MusicSearchTableViewCell.h"
#import "ImageDownloader.h"

@implementation MusicSearchTableViewCell

-(void)setDataWithMusic:(Music *)iObject{
  
    self.lblAlbum.text = [NSString stringWithFormat:@"Album : %@",iObject.albumName];
    self.lblArtist.text = [NSString stringWithFormat:@"Artist : %@",iObject.artistName];;
    self.lblTrack.text = [NSString stringWithFormat:@"Track : %@",iObject.trackName];;
    __weak MusicSearchTableViewCell *weakSelf = self;
    [ImageDownloader imageWithURL:iObject.imageURL uniqueID:iObject.uniqueNumber andCompletionBlock:^(UIImage *image, NSString *uniqueID) {
        if (image) {
            if (![uniqueID isEqualToString:iObject.uniqueNumber]) {
                return;
            }
            dispatch_async(dispatch_get_main_queue(), ^{
                weakSelf.imgCover.image = image;
            });
            
        }
    }];
    [self setNeedsLayout];
}

-(void)prepareForReuse{
    self.lblAlbum.text = @"";
    self.lblArtist.text = @"";
    self.lblTrack.text = @"";
    self.imgCover.image = nil;
}
@end
