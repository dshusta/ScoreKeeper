#import <Foundation/Foundation.h>

@class Game;


@protocol GameCollectionDelegate <NSObject>

- (void)didTapOnGame:(Game *)game;

@end


@interface GameCollection : NSObject <UITableViewDataSource, UITableViewDelegate>

@property (readonly, nonatomic) NSArray *games;

@property (nonatomic, weak) id<GameCollectionDelegate> delegate;

- (void)addGame:(Game *)game;

- (void)saveToUserDefaults;

- (NSInteger)count;

@end
