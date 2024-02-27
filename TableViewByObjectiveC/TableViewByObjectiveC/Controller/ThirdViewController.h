//
//  ThirdViewController.h
//  TableViewByObjectiveC
//
//  Created by naeem alabboodi on 2/16/24.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ThirdViewController : UIViewController<UITableViewDelegate , UITableViewDataSource>

@property (strong , nonatomic) IBOutlet UITableView *myThirdTableView;

@end

NS_ASSUME_NONNULL_END
