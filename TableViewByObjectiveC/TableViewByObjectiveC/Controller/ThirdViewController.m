//
//  ThirdViewController.m
//  TableViewByObjectiveC
//
//  Created by naeem alabboodi on 2/16/24.
//

#import "ThirdViewController.h"

@interface ThirdViewController ()

@end

@implementation ThirdViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.myThirdTableView.dataSource = self ;
    self.myThirdTableView.delegate = self ;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // Check if the tapped cell is the one with the disclosure indicator
   
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return  10 ;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell3"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell3"];
    }
    
    // Set cell text
    cell.textLabel.text = @"Naeem Hello";
    
    // Check if this is the cell you want to have a disclosure indicator
   
    
    return cell;
}
@end
