#import <Foundation/Foundation.h>

@class Scoresheet;


@protocol ScoresheetCollectionDelegate <NSObject>

- (void)didTapOnScoresheet:(Scoresheet *)scoresheet;

@end


@interface ScoresheetCollection : NSObject <UITableViewDataSource, UITableViewDelegate>

@property (readonly, nonatomic) NSArray *scoresheets;

@property (nonatomic, weak) id<ScoresheetCollectionDelegate> delegate;

- (void)addScoresheet:(Scoresheet *)scoresheet;

- (NSInteger)count;

@end
