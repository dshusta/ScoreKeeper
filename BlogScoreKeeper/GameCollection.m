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
    [self synchronize];
}

- (void)removeGame:(Game *)game {
    [self.data removeObject:game];
    [self synchronize];
}

- (NSArray *)games {
    return self.data;
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

- (void)synchronize {
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
