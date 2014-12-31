#import <Foundation/Foundation.h>

@interface Player : NSObject

@property (nonatomic, copy) NSString *name;
@property (nonatomic) NSInteger score;

+ (instancetype)deserialize: (NSDictionary*)dictionary;

- (instancetype)initWithName:(NSString *)name;

- (NSDictionary*)serialize;

@end
