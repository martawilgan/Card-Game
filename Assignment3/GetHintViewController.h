//
//  GetHintViewController.h
//  Assignment3
//
//  Created by marta wilgan on 3/13/13.
//  Copyright (c) 2013 nyu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GetHintViewController : UIViewController <UIAlertViewDelegate>

@property (weak, nonatomic) IBOutlet UILabel *hintLabel;

-(IBAction)buttonPressed;

@end
