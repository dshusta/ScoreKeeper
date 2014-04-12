#import <Foundation/Foundation.h>

@interface ScoresheetCollection : NSObject <UITableViewDelegate, UITableViewDataSource>
@end

@interface ScoresheetCollection (ProxiedMethods)

- (NSUInteger)count;
- (id)lastObject;
- (void)addObject:(NSDictionary *)object;

@end