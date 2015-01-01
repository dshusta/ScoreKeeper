#import "PlayerFactory.h"
#import "Player.h"


@implementation PlayerFactory
+ (Player *)createPlayer {
    NSString *nextName = [self generateNextName];
    
    Player *player = [[Player alloc] initWithName:nextName];
    return player;
}

+ (NSString *)generateNextName {
    static int counter = 0;
    return [NSString stringWithFormat:@"Player %i", counter++];
}

+ (NSArray *)createPlayersForGame {
    NSMutableArray *players = [[NSMutableArray alloc] init];
    for (int i = 0; i < 5; i++) {
        [players addObject:[self createPlayer]];
    }
    return players;
}
@end