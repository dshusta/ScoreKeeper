#import "UserDefaultsCleaner.h"

@implementation UserDefaultsCleaner

+ (void)beforeEach {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults removeObjectForKey:@"scoresheets"];
    [defaults synchronize];
}

@end
