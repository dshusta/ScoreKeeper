#import "Scoresheet.h"


@interface Scoresheet ()

@property (nonatomic, copy) NSString *name;

@end



@implementation Scoresheet

+ (Scoresheet *)deserialize:(NSDictionary *)dictionary {
    Scoresheet *scoresheet = [[Scoresheet alloc] initWithName:dictionary[@"name"]];
    scoresheet.player1 = dictionary[@"player1"];
    scoresheet.player5 = dictionary[@"player5"];
    scoresheet.player3 = dictionary[@"player3"];
    scoresheet.player4 = dictionary[@"player4"];
    scoresheet.player2 = dictionary[@"player2"];
    return scoresheet;
}

- (Scoresheet *)initWithName:(NSString *)name {
    self = [self init];
    if (self) {
        self.name = name;
    }
    return self;
}

- (NSDictionary *)serialize {
    return  @{
              @"name": self.name,
              @"player1": self.player1,
              @"player3": self.player3,
              @"player2": self.player2,
              @"player5": self.player5,
              @"player4": self.player4
              };
}

@end
