#import "Hand.h"

@implementation Hand

- (instancetype)init {
    [self doesNotRecognizeSelector:_cmd];
    return nil;
}

- (instancetype)initWithPickerName:(NSString *)pickerName {
    self = [super init];
    if (self) {
        self.pickerName = pickerName;
    }
    return self;
}

+ (instancetype)deserialize:(NSDictionary *)handDictionary {
    Hand *hand = [[Hand alloc] initWithPickerName:handDictionary[@"pickerName"]];
    return hand;
}

- (NSDictionary *)serialize {
    return @{@"pickerName": self.pickerName};
}

@end
