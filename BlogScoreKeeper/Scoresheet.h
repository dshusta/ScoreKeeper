#import <Foundation/Foundation.h>

@class Player;

@interface Scoresheet : NSObject

@property (nonatomic, copy, readonly) NSString *name;
@property (nonatomic, copy, readonly) NSArray *players;

+ (Scoresheet *)deserialize:(NSDictionary *)dictionary;

- (Scoresheet *)initWithName:(NSString *)name players:(NSArray *)players;

- (NSDictionary *) serialize;


@end
