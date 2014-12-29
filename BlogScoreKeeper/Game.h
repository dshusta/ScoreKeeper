#import <Foundation/Foundation.h>

@class Player;

@interface Game : NSObject

@property (nonatomic, copy, readonly) NSString *name;
@property (nonatomic, copy, readonly) NSArray *players;

+ (Game *)deserialize:(NSDictionary *)dictionary;

- (Game *)initWithName:(NSString *)name players:(NSArray *)players;

- (NSDictionary *) serialize;


@end
