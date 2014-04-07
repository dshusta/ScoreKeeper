#import <Foundation/Foundation.h>

@class Scoresheet;


@interface ScoresheetCollection : NSObject <UITableViewDataSource, UITableViewDelegate>

@property(readonly, nonatomic) NSArray *scoresheets;

- (void)addScoresheet:(Scoresheet *)scoresheet;

- (NSInteger)count;

@end
