#import "Game.h"
#import "Player.h"


@interface Game ()

@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSArray *players;

@end



@implementation Game

+ (Game *)deserialize:(NSDictionary *)dictionary {

    NSArray *playerArray = dictionary[@"players"];
    NSMutableArray *players = [[NSMutableArray alloc] init];
    for (NSDictionary *player in playerArray) {
        Player *p = [Player deserialize:player];
        [players addObject:p];
    }

    return [[Game alloc] initWithName:dictionary[@"name"] players:players];
}

- (Game *)initWithName:(NSString *)name players:(NSMutableArray *)players {
    self = [self init];
    if (self) {
        self.name = name;
        self.players = players;
    }
    return self;
}

- (NSDictionary *)serialize {
    NSMutableArray *playerArray = [[NSMutableArray alloc] init];
    for (Player *player in self.players) {
        [playerArray addObject:[player serialize]];
    }

    return  @{
              @"name": self.name,
              @"players": playerArray
              };
}

@end
