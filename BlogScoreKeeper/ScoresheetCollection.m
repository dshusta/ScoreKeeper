//
//  ScoresheetCollection.m
//  BlogScoreKeeper
//
//  Created by pivotal on 4/4/14.
//  Copyright (c) 2014 PivotalBeach. All rights reserved.
//

#import "ScoresheetCollection.h"

@interface ScoresheetCollection ()
@property (strong, nonatomic) NSMutableArray *data;
@end

@implementation ScoresheetCollection

- (id)init {
    self = [super init];
    self.data = [[NSMutableArray alloc] init];
    
    return self;
}

- (id)addObject:(NSObject *)anObject {
    [self.data addObject:anObject];
    return self;
}

- (NSInteger)count {
    return [self.data count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.data count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *cellIdentifier = NSStringFromClass([self class]);
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    NSString *dateString = [NSDateFormatter localizedStringFromDate:[self.data objectAtIndex:indexPath.row]
                                                          dateStyle:NSDateFormatterShortStyle
                                                          timeStyle:NSDateFormatterFullStyle];
    [cell.textLabel setText:dateString];

    return cell;
}

@end
