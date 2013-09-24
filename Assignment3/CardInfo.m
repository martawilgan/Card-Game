//
//  CardInfo.m
//  Assignment3
//
//  Created by marta wilgan on 3/14/13.
//  Copyright (c) 2013 nyu. All rights reserved.
//

#import "CardInfo.h"

@implementation CardInfo

+(CardInfo*) cardInfoWithName : (NSString*) theName
{
    CardInfo *theInfo = [CardInfo new];
    return [theInfo initWithName: theName ];
}

-(CardInfo*) initWithName : (NSString*) theName;
{
    if (self = [super init])
    {
        name = [NSString stringWithFormat:@"%@", theName];
    }
    
    return (self);
}

-(NSString *) name
{
    return (name);
}

-(void) setToGuessed
{
    if (guessed != 1)
    {    
        guessed = 1;
    }    
}

-(void) setToSecret
{
    if (secret != 1)    
    {
        secret = 1;
    }    
}

-(int) guessed
{
    return (guessed);
}

-(int) secret
{
    return (secret);
}

@end
