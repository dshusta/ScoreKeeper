#import "ScoresheetCollection.h"

@interface ScoresheetCollection ()

@property (strong, nonatomic) NSMutableArray* scoresheets;

@end

@implementation ScoresheetCollection

- (id)init {
    self = [super init];
    if (self) {
        self.scoresheets = [[NSMutableArray alloc]init];
    }
    return self;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.scoresheets count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *identifier = NSStringFromClass([self class]);
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];

    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }

    NSDictionary *scoresheet = [self.scoresheets objectAtIndex:indexPath.row];
    NSString *scoresheetName = scoresheet[@"name"];
    [cell.textLabel setText:scoresheetName];

    return cell;
}

- (BOOL)respondsToSelector:(SEL)selector {
    return [super respondsToSelector:selector] || [self.scoresheets respondsToSelector:selector];
}

- (id)forwardingTargetForSelector:(SEL)selector {
    if ([self.scoresheets respondsToSelector:selector]) {
        return self.scoresheets;
    }
    return [super forwardingTargetForSelector:selector];
}

- (NSMethodSignature *)methodSignatureForSelector:(SEL)selector {
    if ([self.scoresheets respondsToSelector:selector]) {
        return [self.scoresheets methodSignatureForSelector:selector];
    }
    return [super methodSignatureForSelector:selector];
}

@end
