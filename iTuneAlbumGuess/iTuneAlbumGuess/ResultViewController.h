//
//  ResultViewController.h
//  iTuneAlbumGuess
//
//  Created by Torbjörn on 2013-03-04.
//  Copyright (c) 2013 Admin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ResultViewController : UIViewController

@property (strong, nonatomic) id firstGuessItem;
@property (strong, nonatomic) id secondGuessItem;
@property (strong, nonatomic) id thirdGuessItem;

@property (strong, nonatomic) NSArray *albumTitelAndArtistArray;

@property (weak, nonatomic) IBOutlet UILabel *firstResultLabel;
@property (weak, nonatomic) IBOutlet UILabel *secondResultLabel;
@property (weak, nonatomic) IBOutlet UILabel *thirdResultLabel;

@end
