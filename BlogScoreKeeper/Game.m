#import "Game.h"
#import "Player.h"
#import "Hand.h"


@interface Game ()

@property (nonatomic, copy) NSString *name;
@property (nonatomic, strong) NSArray *players;


@end


@implementation Game

+ (Game *)deserialize:(NSDictionary *)dictionary {
    NSArray *playerArray = dictionary[@"players"];
    NSMutableArray *players = [[NSMutableArray alloc] init];
    for (NSDictionary *player in playerArray) {
        Player *p = [Player deserialize:player];
        [players addObject:p];
    }
    NSMutableArray *hands = [[NSMutableArray alloc] init];
    for (int i = 0; i < [dictionary[@"hands"] count]; ++i) {
        [hands addObject:[[Hand alloc] init]];
    }

    Game *game = [[Game alloc] initWithName:dictionary[@"name"] players:players];
    [game.hands addObjectsFromArray:hands];
    return game;
}

- (Game *)initWithName:(NSString *)name players:(NSMutableArray *)players {
    self = [self init];
    if (self) {
        self.name = name;
        self.players = players;
        self.hands = [[NSMutableArray alloc] init];
    }
    return self;
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
              };
}

@end
