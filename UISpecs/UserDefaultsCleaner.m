#import "UserDefaultsCleaner.h"

@implementation UserDefaultsCleaner

+ (void)beforeEach {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults removeObjectForKey:@"games"];
    [defaults synchronize];
}

@end
