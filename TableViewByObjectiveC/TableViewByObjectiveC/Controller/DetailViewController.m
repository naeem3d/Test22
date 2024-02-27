//
//  DetailViewController.m
//  TableViewByObjectiveC
//
//  Created by naeem alabboodi on 2/16/24.
//

#import "DetailViewController.h"

@interface DetailViewController ()

@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [super viewDidLoad];
    self.mySecondTableView.dataSource = self ;
    self.mySecondTableView.delegate = self ;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // Check if the tapped cell is the one with the disclosure indicator
    if (indexPath.row == 1) {
        // Instantiate the DetailViewController
        DetailViewController *detailViewController = [[DetailViewController alloc] init];
        
        // Push the DetailViewController onto the navigation stack
        [self.navigationController pushViewController:detailViewController animated:YES];
    }
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return  10 ;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell2"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell2"];
    }
    
    // Set cell text
    cell.textLabel.text = @"Hello world";
    
    // Check if this is the cell you want to have a disclosure indicator
   
    
    return cell;
}
@end
