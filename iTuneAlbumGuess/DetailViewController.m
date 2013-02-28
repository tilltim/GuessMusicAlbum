//
//  DetailViewController.m
//  iTuneAlbumGuess
//
//  Created by Admin on 2013-02-28.
//  Copyright (c) 2013 Admin. All rights reserved.
//

#import "DetailViewController.h"
#import "AlbumsPhoto.h"
#import "AlbumCell.h"

@interface DetailViewController ()
{
    NSMutableData *webData;
    NSURLConnection *connection;
    NSMutableArray *array;
    NSMutableArray *photosArray;
    NSArray *arrayOfImImage;
    NSMutableArray *artistArray;
}

@end

@implementation DetailViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    if (!photosArray)
    {
        photosArray = [[NSMutableArray alloc] init];
    }
    
    if (!arrayOfImImage)
    {
        arrayOfImImage = [[NSMutableArray alloc] init];
    }
    
    [[self myTableView] setDelegate:self];
    [[self myTableView] setDataSource:self];
    array = [[NSMutableArray alloc] init];
    
    [array removeAllObjects];
    
    NSURL *url = [NSURL URLWithString:self.countryItem];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    connection = [NSURLConnection connectionWithRequest:request delegate:self];
    
    if (connection)
    {
        webData = [[NSMutableData alloc] init];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    [webData setLength:0];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [webData appendData:data];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    NSLog(@"Fail with error (fel med connection).");
}

-(void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    
    
    NSDictionary *allDataDictionary = [NSJSONSerialization JSONObjectWithData:webData options:0 error:nil];
    NSDictionary *feed = [allDataDictionary objectForKey:@"feed"];
    NSArray *arrayOffEntry = [feed objectForKey:@"entry"];
    
    for (NSDictionary *diction in arrayOffEntry)
    {
        //AlbumName
        NSDictionary *title = [diction objectForKey:@"title"];
        NSString *label = [title objectForKey:@"label"];
        
        [array addObject:label];
        
        // Photos
        arrayOfImImage = [diction objectForKey:@"im:image"];
        NSDictionary *label2 = [arrayOfImImage[0] objectForKey:@"label"];
        
        [photosArray addObject:label2];
        
        [[self myTableView] reloadData];

        
        //ArtistName
        NSDictionary *artistName = [diction objectForKey:@"im:artist"];
        NSString *label3 = [artistName objectForKey:@"label"];
        
        [artistArray addObject:label3];
        
        NSLog(@"Atist: %@", label3);
        
        
        

    }
    
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [array count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    AlbumCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (!cell)
    {
        cell = [[AlbumCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }

    // Tar bort all text efter bindestreck.
    NSString *adjusted;
    
    NSString *rawAlbumNameLabel = [array objectAtIndex:indexPath.row];
    NSString * test = [NSString stringWithString:rawAlbumNameLabel];
    NSRange range = [test rangeOfString:@"-"];
    if (range.length > 0)
    {
       adjusted = [test substringToIndex:range.location];
    }
    
    cell.albumNameLabel.text = adjusted;//[array objectAtIndex:indexPath.row];

    cell.albumNameLabel.text = [array objectAtIndex:indexPath.row];
    cell.artistNameLabel.text = [artistArray objectAtIndex:indexPath.row];

    
    // Photos
    AlbumsPhoto *photo = photosArray[indexPath.row];
    NSString *photoString = (NSString *) photo;
    [cell.albumImageView setImageWithURL:[NSURL URLWithString:photoString]];
    
    return cell;
    
}

@end
