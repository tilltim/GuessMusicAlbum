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

@property (weak, nonatomic) IBOutlet UITableView *myTableView;
@property (strong, nonatomic) id countryItem;

@end