#import <Foundation/Foundation.h>
#import "Player.h"

@interface Hand : NSObject

@property (nonatomic, strong) NSString *pickerName;

- (instancetype)initWithPickerName:(NSString *)pickerName;

+ (instancetype)deserialize:(NSDictionary *)handDictionary;
- (NSDictionary *)serialize;

@end
