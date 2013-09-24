//
//  UnlockItViewController.h
//  Assignment3
//
//  Created by marta wilgan on 3/13/13.
//  Copyright (c) 2013 nyu. All rights reserved.
//

#import <UIKit/UIKit.h>

#define kFaceComponent 0
#define kSuitComponent 1

@interface UnlockItViewController : UIViewController <UIPickerViewDelegate, UIPickerViewDataSource>

@property (strong, nonatomic) IBOutlet UIPickerView *unlockPicker;
@property (strong, nonatomic) NSArray *faceTypes;
@property (strong, nonatomic) NSArray *suitTypes;
@property (strong, nonatomic) NSArray *cardInfos;

-(IBAction)buttonPressed;

@end
