//
//  MusicSearchTableViewCell.h
//  iTunesMusicSearch
//
//  Created by Durgesh Gupta on 8/15/15.
//  Copyright (c) 2015 Durgesh Gupta. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Music.h"

@interface MusicSearchTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *lblTrack;
@property (weak, nonatomic) IBOutlet UILabel *lblAlbum;
@property (weak, nonatomic) IBOutlet UILabel *lblArtist;
@property (weak, nonatomic) IBOutlet UIImageView *imgCover;

-(void)setDataWithMusic:(Music *)iObject;

@end
