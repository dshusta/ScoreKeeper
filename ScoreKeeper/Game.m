#import "Game.h"
#import "Player.h"
#import "Hand.h"


@interface Game ()

@property (nonatomic, copy) NSString *name;
@property (nonatomic, strong) NSArray *players;
@property int createdAt;

@end


@implementation Game


- (Game *)initWithName:(NSString *)name players:(NSMutableArray *)players {
    int now = [[NSDate date] timeIntervalSince1970];
    return [self initWithName:name players:players createdAt:now];
}

- (Game *)initWithName:(NSString *)name players:(NSMutableArray *)players createdAt:(int)createdAt {
    self = [self init];
    if (self) {
        self.name = name;
        self.players = players;
        self.hands = [[NSMutableArray alloc] init];
        self.createdAt = createdAt;
    }
    return self;
}

- (NSComparisonResult)compare:(Game *)otherObject {
    return self.createdAt <= otherObject.createdAt ? (NSComparisonResult)NSOrderedDescending : (NSComparisonResult)NSOrderedAscending;
}

+ (Game *)deserialize:(NSDictionary *)dictionary {
    NSArray *playerArray = dictionary[@"players"];
    NSMutableArray *players = [[NSMutableArray alloc] init];
    for (NSDictionary *player in playerArray) {
        Player *p = [Player deserialize:player];
        [players addObject:p];
    }
    NSArray *handArray = dictionary[@"hands"];
    NSMutableArray *hands = [[NSMutableArray alloc] init];
    for (NSDictionary *hand in handArray) {
        [hands addObject:[Hand deserialize:hand]];
    }

    NSNumber *createdAtNumber = dictionary[@"createdAt"];
    Game *game = [[Game alloc] initWithName:dictionary[@"name"] players:players createdAt:[createdAtNumber intValue]];
    [game.hands addObjectsFromArray:hands];
    return game;
}

- (NSDictionary *)serialize {
    NSMutableArray *playerArray = [[NSMutableArray alloc] init];
    NSMutableArray *handArray = [[NSMutableArray alloc] init];
    
    for (Player *player in self.players) {
        [playerArray addObject:[player serialize]];
    }
    
    for (Hand *hand in self.hands) {
        [handArray addObject:[hand serialize]];
    }

    return  @{
              @"name": self.name,
              @"players": playerArray,
              @"hands": handArray,
              @"createdAt": [NSNumber numberWithInt:self.createdAt]
              };
}

@end
