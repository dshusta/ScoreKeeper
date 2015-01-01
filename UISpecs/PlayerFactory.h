#import <Foundation/Foundation.h>
#import "Player.h"

@interface PlayerFactory : NSObject
+ (Player *)createPlayer;
+ (NSArray *)createPlayersForGame;
@end