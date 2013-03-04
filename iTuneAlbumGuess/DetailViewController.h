//
//  DetailViewController.h
//  iTuneAlbumGuess
//
//  Created by Admin on 2013-02-28.
//  Copyright (c) 2013 Admin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AlbumsPhoto.h"

@interface DetailViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, NSURLConnectionDataDelegate>

@property (strong, nonatomic) id countryItem;

@property (weak, nonatomic) IBOutlet UITableView *myTableView;
@property (weak, nonatomic) IBOutlet UILabel *firstGuessLabel;
@property (weak, nonatomic) IBOutlet UILabel *secondGuessLabel;
@property (weak, nonatomic) IBOutlet UILabel *thirdGuessLabel;


- (IBAction)clearButton:(id)sender;

@end
