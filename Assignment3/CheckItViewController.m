//
//  CheckItViewController.m
//  Assignment3
//
//  Created by marta wilgan on 3/13/13.
//  Copyright (c) 2013 nyu. All rights reserved.
//
#import <AudioToolbox/AudioToolbox.h>
#import "CheckItViewController.h"
#import "UIApplication.h"

@implementation CheckItViewController
@synthesize guessLabel;
@synthesize checkLabel;
@synthesize numOfGuessesLabel;

extern NSString *gSecretCard;
extern NSString *gCurrentGuess;
extern int gNumOfGuesses;
extern int gRandomNumber;

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
    
    // show number of guesses
    numOfGuessesLabel.text = [NSString stringWithFormat: @"%i", gNumOfGuesses];
    
    // update the view for guess
    guessLabel.text = gCurrentGuess;
    
    // check guess against secret card
    if ([gCurrentGuess isEqualToString:gSecretCard] == YES)
    {   
        checkLabel.textColor =  [UIColor colorWithRed:0 green:0 blue:1 alpha:1], /* #0000ff blue */
        checkLabel.backgroundColor = [UIColor colorWithRed:0.8 green:1 blue:0.8 alpha:1], /* #ccffcc green */
        checkLabel.text = [NSString stringWithFormat:@"You found the card! YOU WIN!"]; 
        
        // play sound
        NSString *path = [ [NSBundle mainBundle] pathForResource:@"magic1" ofType:@"wav"];
        SystemSoundID theSound;
        AudioServicesCreateSystemSoundID((__bridge CFURLRef)[NSURL fileURLWithPath:path], &theSound);
        AudioServicesPlaySystemSound (theSound); 
        
        [[UIApplication sharedApplication] 
            performSelector:@selector(terminateWithSuccess)
                 withObject:nil
                 afterDelay:3.0];
    } 
    else if ( ([gCurrentGuess isEqualToString:gSecretCard] == NO) &&
             ([gCurrentGuess isEqualToString:@"No guess yet."] == NO) )
    {
        checkLabel.text = 
        [NSString stringWithFormat:@"Nice try but thats not the secret card."];
    }

}

- (void)viewDidUnload
{
    [self setGuessLabel:nil];
    [self setCheckLabel:nil];
    [self setNumOfGuessesLabel:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
