//
//  ViewController.h
//  CurdOperations
//
//  Created by Suresh on 2/22/17.
//  Copyright © 2017 Suresh. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>
@property (strong, nonatomic) IBOutlet UITableView *TableView;
- (IBAction)addButton:(id)sender;
@property(strong, nonatomic)NSIndexPath *selectedPath;

- (IBAction)editButton:(UIButton *)sender;
- (IBAction)deleteButton:(UIButton*)sender;
- (IBAction)leftSwipe:(id)sender;
- (IBAction)rightSwipe:(id)sender;




@end

