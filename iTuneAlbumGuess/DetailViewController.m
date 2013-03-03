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
    int clickCounter;
}

@end

@implementation DetailViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Gissa listans 3 i topp!"
                                                    message:@"Tryck på de 3 musikalbum som du tror ligger överst på iTunes Top10. Rätt svar får du när listan är sparad."
                                                   delegate:nil
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil];
    [alert show];
    
    
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
    artistArray = [[NSMutableArray alloc]init];
    
    [array removeAllObjects];
    
    NSURL *url = [NSURL URLWithString:self.countryItem];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    connection = [NSURLConnection connectionWithRequest:request delegate:self];
    
    if (connection)
    {
        webData = [[NSMutableData alloc] init];
    }
    
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"background.png"]];
    
    
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
    
    // Calling the array´s shufflemethod.
    NSArray *shuffledArrayOffEntry = [self shuffleArray:arrayOffEntry];
        
    for (NSDictionary *diction in shuffledArrayOffEntry)
    {
        //AlbumName
        NSDictionary *title = [diction objectForKey:@"title"];
        NSString *label = [title objectForKey:@"label"];
        
        [array addObject:label];
        
        // Photos
        arrayOfImImage = [diction objectForKey:@"im:image"];
        NSDictionary *label2 = [arrayOfImImage[0] objectForKey:@"label"];
        
        [photosArray addObject:label2];

        
        //ArtistName
        NSDictionary *artist = [diction objectForKey:@"im:artist"];
        NSString *label3 = [artist objectForKey:@"label"];
        
        [artistArray addObject:label3];
        
        [[self myTableView] reloadData];
        
        NSLog(@"Artist: %@", artistArray);
    }
}

- (NSArray*)shuffleArray:(NSArray*)unShuffledArray
{
    NSMutableArray *temp = [[NSMutableArray alloc] initWithArray:unShuffledArray];
    
    for(NSUInteger i = [unShuffledArray count]; i > 1; i--)
    {
        NSUInteger j = arc4random_uniform(i);
        [temp exchangeObjectAtIndex:i-1 withObjectAtIndex:j];
    }
    
    return [NSArray arrayWithArray:temp];
} // eof method shuffleArray.

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
        cell = [[AlbumCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    
    
    UIView *bgColorView = [[UIView alloc] init];
    [bgColorView setBackgroundColor:[UIColor colorWithRed:2/255.0 green:38/255.0 blue:52/255.0 alpha:1]];
//       [bgColorView setBackgroundColor:[UIColor blackColor]];
    [cell setSelectedBackgroundView:bgColorView];
    
    
        
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


    
    cell.artistNameLabel.text = [artistArray objectAtIndex:indexPath.row];
//    NSLog(@"artistLabel %@", artistArray);


    // Photos
    AlbumsPhoto *photo = photosArray[indexPath.row];
    NSString *photoString = (NSString *) photo;
    [cell.albumImageView setImageWithURL:[NSURL URLWithString:photoString]];
    
    // En metod för att ta bort bindestrcket och allt som är bakom. Vi ska använda denna metod senare.
//    NSString * test = [NSString stringWithString:@"Searching for Sugar Man - Rodriguez"];
//    NSRange range = [test rangeOfString:@"-"];
//    if (range.length > 0)
//    {
//        NSString *adjusted = [test substringToIndex:range.location];
//        NSLog(@"result: %@", adjusted);
//    }
    
    
    return cell;
    
}

// När ett album är klickat/valt ska det skrivas ut i guessLabel:arna.
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *guessText = [array objectAtIndex:indexPath.row];
    
    switch (clickCounter)
    {
        case 0:
            [[self firstGuessLabel] setText:[@"1. " stringByAppendingString:guessText]];
            [[self secondGuessLabel] setTextColor:[UIColor redColor]];
            [[self firstGuessLabel] setTextColor:[UIColor whiteColor]];
            break;
            
        case 1:
            [[self secondGuessLabel] setText:[@"2. " stringByAppendingString:guessText]];
            [[self thirdGuessLabel] setTextColor:[UIColor redColor]];
            [[self secondGuessLabel] setTextColor:[UIColor whiteColor]];
            break;
            
        case 2:
            [[self thirdGuessLabel] setText:[@"3. " stringByAppendingString:guessText]];
            [[self firstGuessLabel] setTextColor:[UIColor whiteColor]];
            [[self thirdGuessLabel] setTextColor:[UIColor whiteColor]];
            break;
            
        default:
            break;
    } // eof switch.
    
    clickCounter++;
    if (clickCounter > 2)
    {
        clickCounter = 0;
    }
} // eof method tableView:didSelectRowAtIndexPath.

- (IBAction)clearButton:(id)sender
{
    [[self firstGuessLabel] setText:@"1."];
    [[self firstGuessLabel] setTextColor:[UIColor redColor]];
    [[self secondGuessLabel] setText:@"2."];
    [[self secondGuessLabel] setTextColor:[UIColor whiteColor]];
    [[self thirdGuessLabel] setText:@"3."];
    [[self thirdGuessLabel] setTextColor:[UIColor whiteColor]];
}
@end
