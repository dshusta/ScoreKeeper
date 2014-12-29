#import <Foundation/Foundation.h>

@class Game;


@interface GameCollection : NSObject

@property (readonly, nonatomic) NSArray *games;
- (void)addGame:(Game *)game;
- (void)removeGame:(Game *)game;

@end
