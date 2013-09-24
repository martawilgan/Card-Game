//
//  CardInfo.h
//  Assignment3
//
//  Created by marta wilgan on 3/14/13.
//  Copyright (c) 2013 nyu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CardInfo : NSObject
{
    NSString *name;
    int guessed; // 1 if set 0 otherwise
    int secret; // 1 if secrect card 0 otherwise
}

+(CardInfo*) cardInfoWithName : (NSString*) theName;
-(CardInfo*) initWithName : (NSString*) theName;

-(NSString *) name;
-(void) setToGuessed;
-(void) setToSecret;
-(int) guessed;
-(int) secret;

@end
