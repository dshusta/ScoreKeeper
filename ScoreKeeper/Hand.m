#import "Hand.h"

@implementation Hand

- (instancetype)init {
    [self doesNotRecognizeSelector:_cmd];
    return nil;
}

- (instancetype)initWithPickerName:(NSString *)pickerName partnerName:(NSString *)partnerName{
    self = [super init];
    if (self) {
        self.pickerName = pickerName;
        self.partnerName = partnerName;
    }
    return self;
}

+ (instancetype)deserialize:(NSDictionary *)handDictionary {
    Hand *hand = [[Hand alloc] initWithPickerName:handDictionary[@"pickerName"] partnerName:handDictionary[@"partnerName"]];
    return hand;
}

- (NSDictionary *)serialize {
    return @{
             @"pickerName": self.pickerName,
             @"partnerName": self.partnerName
             };
}

@end
