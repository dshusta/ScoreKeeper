//
//  ScoresheetCollection.m
//  BlogScoreKeeper
//
//  Created by pivotal on 4/4/14.
//  Copyright (c) 2014 PivotalBeach. All rights reserved.
//

#import "ScoresheetCollection.h"
#import "Scoresheet.h"

@interface ScoresheetCollection ()
@property (strong, nonatomic) NSMutableArray *data;
@end

@implementation ScoresheetCollection

- (id)init {
    self = [super init];
    if (self) {
        self.data = [[NSMutableArray alloc] init];

        [self readFromUserDefaults];
    }
    return self;
}

- (void)addScoresheet:(Scoresheet *)scoresheet {
    [self.data addObject:scoresheet];
    [self saveToUserDefaults];
}

- (NSArray *)scoresheets {
    return self.data;
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

    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    NSString *scoresheetName = [[self.data objectAtIndex:indexPath.row] name];
    [cell.textLabel setText:scoresheetName];

    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    Scoresheet *scoresheet = self.data[indexPath.row];
    [self.delegate didTapOnScoresheet:scoresheet];
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.data removeObjectAtIndex:indexPath.row];
    [tableView reloadData];
    [self saveToUserDefaults];
}

- (void)readFromUserDefaults {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSArray *scoresheets = [defaults objectForKey:@"scoresheets"];

    for (NSDictionary *serializedScoresheet in scoresheets) {
        Scoresheet *scoresheet = [Scoresheet deserialize:serializedScoresheet];
        [self.data addObject:scoresheet];
    }
}

- (void)saveToUserDefaults {
    NSMutableArray *scoresheetNames = [NSMutableArray array];

    for (Scoresheet *scoresheet in self.data) {
        NSDictionary *serializedScoresheet = [scoresheet serialize];
        [scoresheetNames addObject:serializedScoresheet];
    }

    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:scoresheetNames forKey:@"scoresheets"];
    [defaults synchronize];
}

@end
