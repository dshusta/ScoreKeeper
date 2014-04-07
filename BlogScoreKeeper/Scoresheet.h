#import <Foundation/Foundation.h>

@interface Scoresheet : NSObject

@property (nonatomic, copy, readonly) NSString *name;
@property (nonatomic, copy) NSString *player1;
@property (nonatomic, copy) NSString *player2;
@property (nonatomic, copy) NSString *player3;
@property (nonatomic, copy) NSString *player4;
@property (nonatomic, copy) NSString *player5;

+ (Scoresheet *)deserialize:(NSDictionary *)dictionary;

- (Scoresheet *)initWithName:(NSString *)name;

- (NSDictionary *) serialize;

@end
