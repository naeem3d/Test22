//
//  ViewController.h
//  TableViewByObjectiveC
//
//  Created by naeem alabboodi on 2/16/24.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController<UITableViewDelegate , UITableViewDataSource>

@property (strong , nonatomic) IBOutlet UITableView *myTableView;

@end

