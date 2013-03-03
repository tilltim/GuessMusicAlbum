//
//  AppDelegate.m
//  iTuneAlbumGuess
//
//  Created by Admin on 2013-02-28.
//  Copyright (c) 2013 Admin. All rights reserved.
//

#import "AppDelegate.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    
    
    [self UIAppearance];
    return YES;
}

-(void)UIAppearance
{    
    [[UINavigationBar appearance] setTintColor:[UIColor colorWithRed:118/255.0 green:176/255.0 blue:197/255.0 alpha:1]];
;
    
    //knappar i normalt läge
    UIImage *image = [UIImage imageNamed:@"blue_button_press.png"];
    image = [image stretchableImageWithLeftCapWidth:11 topCapHeight:11];
    
    [[UIButton appearance] setBackgroundImage:image forState:UIControlStateNormal];
    
    //knappar vid tryckning
    UIImage *buttonPressed = [UIImage imageNamed:@"blue_button_pressed.png"];
    buttonPressed = [buttonPressed stretchableImageWithLeftCapWidth:11 topCapHeight:11];
    
    [[UIButton appearance] setBackgroundImage:buttonPressed forState:UIControlStateHighlighted];
    
    //Ändra textfärgen i UIButton
    [[UIButton appearance] setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    //Ändra textfärgen i UIlabel
    [[UILabel appearance] setTextColor:[UIColor whiteColor]];
    
    
//    [[UITableView appearance] setBackgroundColor:[UIColor colorWithRed:118/255.0 green:176/255.0 blue:197/255.0 alpha:1]];
    
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
