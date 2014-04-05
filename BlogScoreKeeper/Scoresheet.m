//
//  Scoresheet.m
//  BlogScoreKeeper
//
//  Created by pivotal on 4/4/14.
//  Copyright (c) 2014 PivotalBeach. All rights reserved.
//

#import "Scoresheet.h"

@implementation Scoresheet

- (Scoresheet*)initWithName:(NSString*) name {
    self = [self init];
    self.name = name;
    return self;
}

@end
