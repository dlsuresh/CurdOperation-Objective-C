//
//  TableViewCell.h
//  CurdOperations
//
//  Created by Suresh on 2/22/17.
//  Copyright © 2017 Suresh. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TableViewCell : UITableViewCell

//- (IBAction)editButton:(id)sender;

//- (IBAction)deleteButton:(id)sender;

@property (strong, nonatomic) IBOutlet UILabel *nameLabel;

@property (strong, nonatomic) IBOutlet UILabel *idLabel;

@property (strong, nonatomic) IBOutlet UILabel *companyLabel;

@property (strong, nonatomic) IBOutlet UILabel *designationLabel;

@property (strong, nonatomic) IBOutlet UIButton *editOutlet;

@property (strong, nonatomic) IBOutlet UIButton *deleteOutlet;

@end
