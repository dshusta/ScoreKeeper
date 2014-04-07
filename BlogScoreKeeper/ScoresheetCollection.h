//
//  ScoresheetCollection.h
//  BlogScoreKeeper
//
//  Created by pivotal on 4/4/14.
//  Copyright (c) 2014 PivotalBeach. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ScoresheetCollection : NSObject <UITableViewDataSource, UITableViewDelegate>
@property(readonly, nonatomic) NSArray* scoresheets;
- (void)addObject:(NSObject *)anObject;
- (NSInteger)count;
@end
