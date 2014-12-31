#import "Player.h"

@implementation Player

+ (instancetype)deserialize:(NSDictionary *)dictionary {
    Player *player = [[Player alloc]init];
    player.name = dictionary[@"name"];
    player.score = [dictionary[@"score"] integerValue];
    return player;
}

- (instancetype)initWithName:(NSString *)name {
    self = [super init];
    if (self) {
        self.name = name;
    }
    return self;
}

- (NSDictionary *)serialize {
    return @{
             @"name": self.name,
             @"score": @(self.score)
             };
}

@end
