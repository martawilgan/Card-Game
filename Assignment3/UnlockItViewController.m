//
//  UnlockItViewController.m
//  Assignment3
//
//  Created by marta wilgan on 3/13/13.
//  Copyright (c) 2013 nyu. All rights reserved.
//
#import <AudioToolbox/AudioToolbox.h>
#import "UnlockItViewController.h"
#import "CardInfo.h"

@implementation UnlockItViewController
@synthesize unlockPicker;
@synthesize faceTypes;
@synthesize suitTypes;
@synthesize cardInfos;

NSString *gSecretCard = @"No card yet."; // the secret card as a string
NSString *gCurrentGuess = @"No guess yet."; // the current guess as a string
int gNumOfGuesses = 0; // number of guesses made by user

int gAllHeartsGuessed; // 1 if all face values for heart set, 0 otherwise
int gAllClubsGuessed; // 1 if all face values for club set, 0 otherwise
int gAllDiamondsGuessed; // 1 if all face values for diamond set, 0 otherwise
int gAllSpadesGuessed; // 1 if all face values for spade set, 0 otherwise

int gAllFaceValuesGuessed[] = {0,0,0,0};
int gAllSuitValuesGuessed[] = {0,0,0,0,0,0,0,0,0,0,0,0};

extern int gRandomNumber; // random number 0 to 51 for secret card

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
        
    // Create the faceTypes
    NSArray *faceTypesArray = [[NSArray alloc] initWithObjects: @"The Ace of",@"The Two of",@"The Three of",@"The Four of",@"The Five of", @"The Six of", @"The Seven of",@"The Eight of", @"The Nine of",@"The Ten of", @"The Jack of",@"The Queen of",@"The King of",nil];
    self.faceTypes = faceTypesArray;
    
    // Define the images
    UIImage *heart = [UIImage imageNamed:@"heart.png"];
    UIImage *club = [UIImage imageNamed:@"club.png"];
    UIImage *diamond = [UIImage imageNamed:@"diamond.png"];
    UIImage *spade = [UIImage imageNamed:@"spade.png"];
    
    // Create the image views
    UIImageView *heartView = [[UIImageView alloc] initWithImage:heart];
    UIImageView *clubView = [[UIImageView alloc] initWithImage:club];
    UIImageView *diamondView = [[UIImageView alloc] initWithImage:diamond];
    UIImageView *spadeView = [[UIImageView alloc] initWithImage:spade];
    
    // Create the suitTypes
    NSArray *suitTypesArray = [[NSArray alloc] initWithObjects: heartView, clubView, diamondView, spadeView, nil];
    self.suitTypes = suitTypesArray;
    
    // Create the cardInfos
    NSMutableArray *cardTypesArray = [[NSMutableArray alloc] initWithCapacity:52];
   
    for (int i = 0; i < 13; i++)
    {
        // Create the card name
        NSString *cardName = [NSString stringWithFormat:@" %@ Hearts", [faceTypes objectAtIndex:i]];
        
        // Create the card info
        CardInfo *theInfo = [CardInfo cardInfoWithName : cardName];
        
        // Insert card info into array
        [cardTypesArray insertObject : theInfo atIndex: i];
    }
    
    for (int i = 0; i < 13; i++)
    {
        // Create the card name
        NSString *cardName = [NSString stringWithFormat:@" %@ Clubs", [faceTypes objectAtIndex:i]];
        
        // Create the card info
        CardInfo *theInfo = [CardInfo cardInfoWithName : cardName];
        
        // Insert card info into array
        [cardTypesArray insertObject : theInfo atIndex: i+13];
    }
    
    for (int i = 0; i < 13; i++)
    {
        // Create the card name
        NSString *cardName = [NSString stringWithFormat:@" %@ Diamonds", [faceTypes objectAtIndex:i]];
        
        // Create the card info
        CardInfo *theInfo = [CardInfo cardInfoWithName : cardName];
        
        // Insert card info into array
        [cardTypesArray insertObject : theInfo atIndex: i+26];
    }
    
    for (int i = 0; i < 13; i++)
    {
        // Create the card name
        NSString *cardName = [NSString stringWithFormat:@" %@ Spades", [faceTypes objectAtIndex:i]];
        
        // Create the card info
        CardInfo *theInfo = [CardInfo cardInfoWithName : cardName];
        
        // Insert card info into array
        [cardTypesArray insertObject : theInfo atIndex: i+39];
    }
    
    self.cardInfos = cardTypesArray;
    
    // set the random number from 0 to 51
    srandom(time(NULL));
    gRandomNumber = random() % 52;
    
    // Find the secret card
    CardInfo *secretCard = [cardInfos objectAtIndex: gRandomNumber];
    [[cardInfos objectAtIndex:gRandomNumber] setToSecret];
    gSecretCard = [NSString stringWithFormat:@" %@",[secretCard name]];
        
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
    self.unlockPicker = nil;
    self.faceTypes = nil;
    self.suitTypes = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

-(IBAction)buttonPressed
{
    // find the rows
    NSInteger faceRow = [unlockPicker selectedRowInComponent:kFaceComponent];
    NSInteger suitRow = [unlockPicker selectedRowInComponent:kSuitComponent];
    
    
    // find what is stored at faceRow
    NSString *faceStr = [NSString stringWithFormat:@" %@", [faceTypes objectAtIndex:faceRow]];
    
    // find string representation of what is stored at suitRow
    // and set the selected card to guessed
    NSString *suitStr;
    
    switch(suitRow)
    {
        case 0:
            suitStr = @"Hearts";
            [[cardInfos objectAtIndex:faceRow] setToGuessed];
            break;
        case 1:
            suitStr = @"Clubs";
            [[cardInfos objectAtIndex:faceRow+13] setToGuessed];
            break;
        case 2:
            suitStr = @"Diamonds";
            [[cardInfos objectAtIndex:faceRow+26] setToGuessed];
            break;
        case 3:
            suitStr = @"Spades";
            [[cardInfos objectAtIndex:faceRow+39] setToGuessed];
            break;
            
    }
    
    gCurrentGuess = [NSString stringWithFormat:@" %@ %@", faceStr, suitStr];
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"You have guessed : " 
                                                    message:gCurrentGuess
                                                   delegate:nil
                                          cancelButtonTitle:@"Done" 
                                          otherButtonTitles: nil];
    gNumOfGuesses++; // update number of guesses
    
    // play sound
    NSString *path = [ [NSBundle mainBundle] pathForResource:@"woosh1" ofType:@"wav"];
    SystemSoundID theSound;
    AudioServicesCreateSystemSoundID((__bridge CFURLRef)[NSURL fileURLWithPath:path], &theSound);
    AudioServicesPlaySystemSound (theSound); 
    
    [alert show];
    
}

#pragma mark - 
#pragma mark Picker Data Source Methods
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 2;
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if (component == kFaceComponent)
    {
        return [self.faceTypes count];
    }
    
    return [self.suitTypes count];
}

#pragma mark Picker Delegate Methods
-(UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row 
                                               forComponent:(NSInteger)component reusingView:(UIView *)view
{     
    // if pickerView is UIImageView simply return it
    if (component == kSuitComponent)
    {
        return [self.suitTypes objectAtIndex :row];
    }  
    
    // otherwise create a label and return it
    UILabel *theLabel = [[UILabel alloc] init];
    theLabel.text = [NSString stringWithFormat:@" %@",[self.faceTypes objectAtIndex:row]];
    theLabel.font = [UIFont fontWithName:@"Courier New" size:16];
    theLabel.backgroundColor = [UIColor clearColor];
    return theLabel;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    // find the rows
    NSInteger faceRow = [unlockPicker selectedRowInComponent:kFaceComponent];
    NSInteger suitRow = [unlockPicker selectedRowInComponent:kSuitComponent];
    
        int nextFaceRow = faceRow;
        int nextSuitRow = suitRow;
        int infoIndex = faceRow + 13*suitRow;
        int continueSuitLoop = 0;
        int continueFaceLoop = 0;
    
        if (component == kSuitComponent)
        {
            continueSuitLoop = 1;
        }
        if (component == kFaceComponent)
        {
            continueFaceLoop = 1;
        }
        
            // if already guessed and not secret card move the selection
            while ( [[cardInfos objectAtIndex:infoIndex] guessed] == 1 &&
                    [[cardInfos objectAtIndex:infoIndex] secret] != 1)
            {
                while( [[cardInfos objectAtIndex:infoIndex] guessed] == 1 &&
                       [[cardInfos objectAtIndex:infoIndex] secret] != 1 &&
                        continueSuitLoop)
                {    
      
                    // if at end start from beginning
                    if (nextSuitRow == 3)
                    {
                        nextSuitRow = 0;
                    }
            
                    // if not at end of suit and not found increment
                    else if (nextSuitRow < 3)
                    {    
                        nextSuitRow++;
                    }
            
                    infoIndex = nextFaceRow + 13*nextSuitRow;
            
                    // if nextSuitRow not found and not secret card find nextFaceRow
                    if ( [[cardInfos objectAtIndex:nextFaceRow] guessed] == 1 &&
                         [[cardInfos objectAtIndex:nextFaceRow+13] guessed] == 1 &&
                         [[cardInfos objectAtIndex:nextFaceRow+26] guessed] == 1 &&
                         [[cardInfos objectAtIndex:nextFaceRow+39] guessed] == 1 )
                    {
                        continueSuitLoop = 0;
                        
                        if([[cardInfos objectAtIndex:infoIndex]secret] != 1)
                        {    
                            continueFaceLoop = 1;
                        }    
                    }
                }
                
                while ( [[cardInfos objectAtIndex:infoIndex] guessed] == 1 &&
                        [[cardInfos objectAtIndex:infoIndex] secret] != 1 && continueFaceLoop)    
                {
                    
                    // if at end start from beginning
                    if (nextFaceRow == 12)
                    {
                        nextFaceRow = 0;
                    }
                    
                    // if not at end and not found increment
                    else if (nextFaceRow < 12)
                    {    
                        nextFaceRow++;
                    }
                    
                    infoIndex = nextFaceRow + 13*suitRow;
                    
                    // if nextFaceRow not found and not secret card find nextSuitRow
                    if ( [[cardInfos objectAtIndex:(0 + (13*nextSuitRow))] guessed] == 1 &&
                         [[cardInfos objectAtIndex:(1 + (13*nextSuitRow))] guessed] == 1 &&
                         [[cardInfos objectAtIndex:(2 + (13*nextSuitRow))] guessed] == 1 &&
                         [[cardInfos objectAtIndex:(3 + (13*nextSuitRow))] guessed] == 1 &&
                         [[cardInfos objectAtIndex:(4 + (13*nextSuitRow))] guessed] == 1 &&
                         [[cardInfos objectAtIndex:(5 + (13*nextSuitRow))] guessed] == 1 &&
                         [[cardInfos objectAtIndex:(6 + (13*nextSuitRow))] guessed] == 1 &&
                         [[cardInfos objectAtIndex:(7 + (13*nextSuitRow))] guessed] == 1 &&
                         [[cardInfos objectAtIndex:(8 + (13*nextSuitRow))] guessed] == 1 &&
                         [[cardInfos objectAtIndex:(9 + (13*nextSuitRow))] guessed] == 1 &&
                         [[cardInfos objectAtIndex:(10 + (13*nextSuitRow))] guessed] == 1 &&
                         [[cardInfos objectAtIndex:(11 + (13*nextSuitRow))] guessed] == 1 &&
                         [[cardInfos objectAtIndex:(12 + (13*nextSuitRow))] guessed] == 1 )
                    {
                        continueFaceLoop = 0;
                        
                        if([[cardInfos objectAtIndex:infoIndex]secret] != 1)
                        {    
                            continueSuitLoop = 1;
                        }    
                    }
                    
                }
            } // end while
    
             
        // if nextSuitRow found and not on secret card select card
        if (nextSuitRow != suitRow
            && [[cardInfos objectAtIndex:(nextFaceRow + (13*suitRow))] secret] != 1)
        {
            [unlockPicker selectRow:nextSuitRow 
                        inComponent:kSuitComponent 
                           animated:YES];
            [unlockPicker reloadComponent:kSuitComponent];
        }
    
        // if nextFaceRow found and not on secret card select card
        if (nextFaceRow != faceRow
            && [[cardInfos objectAtIndex:(faceRow + (13*nextSuitRow))] secret] != 1)
        {
            [unlockPicker selectRow:nextFaceRow 
                        inComponent:kFaceComponent 
                           animated:YES];
            [unlockPicker reloadComponent:kFaceComponent];
            
        }

   
    // play sound
    NSString *path = [ [NSBundle mainBundle] pathForResource:@"pick" ofType:@"wav"];
    SystemSoundID theSound;
    AudioServicesCreateSystemSoundID((__bridge CFURLRef)[NSURL fileURLWithPath:path], &theSound);
    AudioServicesPlaySystemSound (theSound); 
}


@end
