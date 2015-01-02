#import <Foundation/Foundation.h>
#import "Player.h"

@interface Hand : NSObject

@property (nonatomic, strong) NSString *pickerName;
@property (nonatomic, strong) NSString *partnerName;

- (instancetype)initWithPickerName:(NSString *)pickerName partnerName:(NSString *)parnterName;

+ (instancetype)deserialize:(NSDictionary *)handDictionary;
- (NSDictionary *)serialize;

@end
