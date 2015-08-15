//
//  MusicSearchTableViewController.m
//  iTunesMusicSearch
//
//  Created by Durgesh Gupta on 8/15/15.
//  Copyright (c) 2015 Durgesh Gupta. All rights reserved.
//

#import "MusicSearchTableViewController.h"
#import "MusicSearchTableViewCell.h"
#import "LyricsViewController.h"
#import "MusicDataManager.h"
#import "Music.h"


@interface MusicSearchTableViewController ()

@property (nonatomic, strong) NSMutableArray *dataSourceArray;
@property (nonatomic, strong) UIActivityIndicatorView *indicator;
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;

@end

@implementation MusicSearchTableViewController


#pragma mark Lazy Instantiation

-(UIActivityIndicatorView *)indicator
{
    if (!_indicator)
    {
        _indicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        [_indicator setFrame:self.view.frame];
        [_indicator setHidesWhenStopped:YES];
        
    }
    return _indicator;
}

-(NSMutableArray *)dataSourceArray
{
    if (!_dataSourceArray)
    {
        _dataSourceArray = [[NSMutableArray alloc] init];
    }
    return _dataSourceArray;
}
- (void)InternalSetUP
{
    // Implement RefreshControl
    
    UIRefreshControl *refreshControl = [[UIRefreshControl alloc] init];
    [refreshControl setTintColor:[UIColor magentaColor]];
    [refreshControl addTarget:self action:@selector(updateTable) forControlEvents:UIControlEventValueChanged];
    [self setRefreshControl:refreshControl];
}

- (void)apiCall
{
    __weak MusicSearchTableViewController *weakSelf = self;
    [[MusicDataManager sharedManager] fetchMusicListWithSearchString:@"Tom" CompletionHandler:^(id responseData) {
        weakSelf.dataSourceArray = [(NSArray *)responseData mutableCopy];
        dispatch_sync(dispatch_get_main_queue(), ^{
            [weakSelf.tableView reloadData];
            [weakSelf.indicator stopAnimating];
        });
        
    }];
   
}

-(void)awakeFromNib
{
    [self InternalSetUP];
    [self apiCall];
    
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Initialize AppDelegate
    [self.view addSubview:self.indicator];
    [self.indicator startAnimating];
    
    
    [self.tableView setEstimatedRowHeight:70.0];
    [self.tableView setRowHeight:UITableViewAutomaticDimension];
}


#pragma mark - Table view data source


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    
    return  self.dataSourceArray.count;

}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"reuseID";
    
    MusicSearchTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
    Music *iObject = (Music *)self.dataSourceArray[indexPath.row];
    [cell setDataWithMusic:iObject];
    
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [self.dataSourceArray removeObjectAtIndex:indexPath.row];
        [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        
    }
}

#pragma mark - UISearchBarDelegate

- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar
{
    return YES;
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    if (searchText.length == 0) {
        // Reload table view and hide
        self.dataSourceArray = nil;
        [self.tableView reloadData];
    }
  
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [searchBar resignFirstResponder];
    [self.indicator startAnimating];
    
    // Call search with text
    [self searchWithText:(searchBar.text)];
}

- (void)searchWithText:(NSString *)text
{
    __weak MusicSearchTableViewController *weakSelf = self;
    [[MusicDataManager sharedManager] fetchMusicListWithSearchString:text CompletionHandler:^(id responseData) {
        weakSelf.dataSourceArray = [(NSArray *)responseData mutableCopy];
        dispatch_sync(dispatch_get_main_queue(), ^{
            [weakSelf.tableView reloadData];
            [weakSelf.indicator stopAnimating];
        });

    }];
}


#pragma mark Private Method

-(void)updateTable
{
    // update Table
    [self.indicator startAnimating];
    self.searchBar.text = @"Tom";
    __weak MusicSearchTableViewController *weakSelf = self;
    [[MusicDataManager sharedManager] fetchMusicListWithSearchString:@"Tom" CompletionHandler:^(id responseData) {
        weakSelf.dataSourceArray = nil;
        weakSelf.dataSourceArray = [(NSArray *)responseData mutableCopy];
        dispatch_sync(dispatch_get_main_queue(), ^{
            [weakSelf.tableView reloadData];
            [weakSelf.indicator stopAnimating];
            [weakSelf.refreshControl endRefreshing];
        });
        
    }];
   
}


 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
     
     MusicSearchTableViewCell *cell = (MusicSearchTableViewCell *)sender;
     NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
     Music *iObject = (Music *)self.dataSourceArray[indexPath.row];
     LyricsViewController *aController = (LyricsViewController *)segue.destinationViewController;
     aController.musicObject = iObject;
    
 }
 

@end
