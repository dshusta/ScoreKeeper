//
//  ScoresheetCollection.h
//  BlogScoreKeeper
//
//  Created by pivotal on 4/4/14.
//  Copyright (c) 2014 PivotalBeach. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ScoresheetCollection : NSObject <UITableViewDataSource, UITableViewDelegate>
- (id)addObject:(NSObject *)anObject;
- (NSInteger)count;
@end
