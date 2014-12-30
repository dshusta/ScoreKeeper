#import <Foundation/Foundation.h>

@class Player;

@interface Game : NSObject

@property (nonatomic, copy, readonly) NSString *name;
@property (nonatomic, strong, readonly) NSArray *players;
@property (nonatomic, strong) NSMutableArray *hands;

+ (Game *)deserialize:(NSDictionary *)dictionary;

- (Game *)initWithName:(NSString *)name players:(NSArray *)players;

- (NSDictionary *) serialize;


@end
