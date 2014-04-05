//
//  Scoresheet.h
//  BlogScoreKeeper
//
//  Created by pivotal on 4/4/14.
//  Copyright (c) 2014 PivotalBeach. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Scoresheet : NSObject
@property (strong, nonatomic) NSString *name;

- (Scoresheet*)initWithName:(NSString*) name;
@end
