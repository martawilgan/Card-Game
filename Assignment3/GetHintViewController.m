//
//  GetHintViewController.m
//  Assignment3
//
//  Created by marta wilgan on 3/13/13.
//  Copyright (c) 2013 nyu. All rights reserved.
//

#import <AudioToolbox/AudioToolbox.h>
#import "GetHintViewController.h"

@implementation GetHintViewController
@synthesize hintLabel;

extern NSString *gSecretCard;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}


-(void) viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
}    

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
    
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

-(IBAction)buttonPressed
{
 
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Get Hint" 
                                                    message:@"Are you sure you want me to give you the answer?" 
                                                   delegate:self 
                                          cancelButtonTitle:@"No" 
                                          otherButtonTitles:@"Yes", nil];
    // play sound
    NSString *path = [ [NSBundle mainBundle] pathForResource:@"woosh1" ofType:@"wav"];
    SystemSoundID theSound;
    AudioServicesCreateSystemSoundID((__bridge CFURLRef)[NSURL fileURLWithPath:path], &theSound);
    AudioServicesPlaySystemSound (theSound); 
    
    [alert show];
    
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{    
    // Show secret card if user asks
    if (buttonIndex == 1)
    {    
        hintLabel.text = [NSString stringWithFormat:@"OK Fine! The answer is %@",gSecretCard];
    }   
    
}

@end
