//
//  ViewController.m
//  TableViewByObjectiveC
//
//  Created by naeem alabboodi on 2/16/24.
//

#import "ViewController.h"
#import "DetailViewController.h"
#import "ThirdViewController.h"
@interface ViewController ()

@property (nonatomic, strong) NSArray *dataArray;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Initialize your array with the desired strings
    self.dataArray = @[@"one", @"two", @"three", @"four", @"five", @"six", @"seven"];
    
    self.myTableView.dataSource = self;
    self.myTableView.delegate = self;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    if (indexPath.row == 1 || indexPath.row == 2) {
    
        // Adjust the frame of the text label to start after the buttons
        cell.textLabel.frame = CGRectMake(150, cell.textLabel.frame.origin.y, cell.frame.size.width - 160, cell.textLabel.frame.size.height);
        
        // Set cell text from the array
           cell.textLabel.text = self.dataArray[indexPath.row];
        
        // Check if this is the cell you want to have a disclosure indicator
        if (indexPath.row == 1 || indexPath.row == 2) {
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        } else {
            cell.accessoryType = UITableViewCellAccessoryNone;
        }
    } else {
        cell.textLabel.frame = CGRectMake(150, cell.textLabel.frame.origin.y, cell.frame.size.width - 160, cell.textLabel.frame.size.height);
        
        // Set cell text from the array
           cell.textLabel.text = self.dataArray[indexPath.row];
        
        // Create Off button
        UIButton *offButton = [UIButton buttonWithType:UIButtonTypeCustom];
        offButton.frame = CGRectMake(240, 5, 60, 30);
        [offButton setTitle:@"Off" forState:UIControlStateNormal];
        [offButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        [offButton setTitleColor:[UIColor greenColor] forState:UIControlStateSelected]; // Set text color for selected state
        [offButton setBackgroundImage:[UIImage imageNamed:@"off_button_normal"] forState:UIControlStateNormal]; // Set background image for normal state
        [offButton setBackgroundImage:[UIImage imageNamed:@"off_button_selected"] forState:UIControlStateSelected]; // Set background image for selected state
        [offButton addTarget:self action:@selector(offButtonTapped:event:) forControlEvents:UIControlEventTouchUpInside];
        offButton.tag = 100; // Set a tag to identify the button later
        [cell.contentView addSubview:offButton];
        
        // Create On button
        UIButton *onButton = [UIButton buttonWithType:UIButtonTypeCustom];
        onButton.frame = CGRectMake(280, 5, 60, 30);
        [onButton setTitle:@"On" forState:UIControlStateNormal];
        [onButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [onButton setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected]; // Set text color for selected state
        [onButton setBackgroundImage:[UIImage imageNamed:@"on_button_normal"] forState:UIControlStateNormal]; // Set background image for normal state
        [onButton setBackgroundImage:[UIImage imageNamed:@"on_button_selected"] forState:UIControlStateSelected]; // Set background image for selected state
        [onButton addTarget:self action:@selector(onButtonTapped:event:) forControlEvents:UIControlEventTouchUpInside];
        onButton.tag = 101; // Set a tag to identify the button later
        [cell.contentView addSubview:onButton];
        
        // Ensure Off button is selected by default
        offButton.selected = YES;
    }
    return cell;
}




- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 1) {
            // Instantiate the DetailViewController from the storyboard
            UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
            DetailViewController *detailViewController = [storyboard instantiateViewControllerWithIdentifier:@"DetailViewControllerIdentifier"];
            
            // Push the DetailViewController onto the navigation stack
            [self.navigationController pushViewController:detailViewController animated:YES];
        } else if (indexPath.row == 2) {
           
            // Instantiate ThirdViewController
                  UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
                  ThirdViewController *thirdViewController = [storyboard instantiateViewControllerWithIdentifier:@"ThirdViewControllerIdentifier"];
                  
                  // Push ThirdViewController onto the navigation stack
                  [self.navigationController pushViewController:thirdViewController animated:YES];
             
        } else {
            
        }
}
- (void)offButtonTapped:(UIButton *)sender event:(UIEvent *)event {
    // Get the index path of the cell containing the tapped button
    UITouch *touch = [[event allTouches] anyObject];
    CGPoint point = [touch locationInView:self.myTableView];
    NSIndexPath *indexPath = [self.myTableView indexPathForRowAtPoint:point];
    
    // Deselect "On" button if tapped
    UITableViewCell *cell = [self.myTableView cellForRowAtIndexPath:indexPath];
    UIButton *onButton = [cell.contentView viewWithTag:101];
    onButton.selected = NO;
    
    // Handle Off button tap action
    sender.selected = YES;
}

- (void)onButtonTapped:(UIButton *)sender event:(UIEvent *)event {
    // Get the index path of the cell containing the tapped button
    UITouch *touch = [[event allTouches] anyObject];
    CGPoint point = [touch locationInView:self.myTableView];
    NSIndexPath *indexPath = [self.myTableView indexPathForRowAtPoint:point];
    
    // Deselect "Off" button if tapped
    UITableViewCell *cell = [self.myTableView cellForRowAtIndexPath:indexPath];
    UIButton *offButton = [cell.contentView viewWithTag:100];
    offButton.selected = NO;
    
    // Handle On button tap action
    sender.selected = YES;
}
@end
