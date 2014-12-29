//
//  GameCollection.m
//  BlogScoreKeeper
//
//  Created by pivotal on 4/4/14.
//  Copyright (c) 2014 PivotalBeach. All rights reserved.
//

#import "GameCollection.h"
#import "Game.h"

@interface GameCollection ()
@property (strong, nonatomic) NSMutableArray *data;
@end

@implementation GameCollection

- (id)init {
    self = [super init];
    if (self) {
        self.data = [[NSMutableArray alloc] init];

        [self readFromUserDefaults];
    }
    return self;
}

#pragma mark - Model

- (void)addGame:(Game *)game {
    [self.data addObject:game];
    [self saveToUserDefaults];
}

- (NSArray *)games {
    return self.data;
}

- (NSInteger)count {
    return [self.data count];
}

#pragma TableView callbacks

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
    
    NSString *gameName = [[self.data objectAtIndex:indexPath.row] name];
    [cell.textLabel setText:gameName];

    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    Game *game = self.data[indexPath.row];
    [self.delegate didTapOnGame:game];
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.data removeObjectAtIndex:indexPath.row];
    [tableView reloadData];
    [self saveToUserDefaults];
}

#pragma mark - Model persistence

- (void)readFromUserDefaults {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSArray *games = [defaults objectForKey:@"games"];

    for (NSDictionary *serializedGame in games) {
        Game *game = [Game deserialize:serializedGame];
        [self.data addObject:game];
    }
}

- (void)saveToUserDefaults {
    NSMutableArray *gameNames = [NSMutableArray array];

    for (Game *game in self.data) {
        NSDictionary *serializedGame = [game serialize];
        [gameNames addObject:serializedGame];
    }

    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:gameNames forKey:@"games"];
    [defaults synchronize];
}

@end
