#import "Player.h"

@implementation Player

+ (instancetype)deserialize:(NSDictionary *)dictionary {
    Player *p = [[Player alloc]init];
    p.name = dictionary[@"name"];
    p.score = [dictionary[@"score"] integerValue];
    return p;
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
