//
//  ViewController.m
//  CurdOperations
//
//  Created by Suresh on 2/22/17.
//  Copyright © 2017 Suresh. All rights reserved.
//

#import "ViewController.h"
#import "TableViewCell.h"
#import "AppDelegate.h"

@interface ViewController ()

@end

@implementation ViewController{
    NSMutableArray*resultArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self fetchData];
    [self.TableView reloadData];
  
    
    
    
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(NSManagedObjectContext *)getContext{
    AppDelegate *app = (AppDelegate*)[UIApplication sharedApplication].delegate;
    NSManagedObjectContext *context = app.persistentContainer.viewContext;
    return context;
    
}


-(void)fetchData{
    
    NSManagedObjectContext *context = [self getContext];
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Database"];
    resultArray = [[NSMutableArray alloc]initWithArray:[context executeFetchRequest:request error:nil]];
    
    
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return resultArray.count;
    
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    TableViewCell *cell = [self.TableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    if (cell == nil) {
        cell = [[TableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }

    NSManagedObject *obj = [resultArray objectAtIndex:indexPath.row];
    
    cell.nameLabel.text = [obj valueForKey:@"name"];
    cell.idLabel.text = [obj valueForKey:@"id"];
    cell.designationLabel.text = [obj valueForKey:@"designation"];
    cell.companyLabel.text = [obj valueForKey:@"company"];

    
    return cell;
}



- (IBAction)addButton:(id)sender {
    
    
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Enter Details" message:nil preferredStyle:UIAlertControllerStyleAlert];
    [alert addTextFieldWithConfigurationHandler:^(UITextField *nameTF) {
        nameTF.placeholder = @"Enter Name";
    }];[alert addTextFieldWithConfigurationHandler:^(UITextField *idTF) {
        idTF.placeholder = @"Enter i'd";

    }];[alert addTextFieldWithConfigurationHandler:^(UITextField *designationTF) {
        designationTF.placeholder = @"Enter Designation";

    }];[alert addTextFieldWithConfigurationHandler:^(UITextField *companyTF) {
        companyTF.placeholder = @"Enter Company";

    }];
//
    
    UIAlertAction *OK = [UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        NSManagedObjectContext *context = [self getContext];
        NSManagedObject *obj = [NSEntityDescription insertNewObjectForEntityForName:@"Database" inManagedObjectContext:context];
        
        UITextField *name = [alert.textFields objectAtIndex:0];
        UITextField *idTF = [alert.textFields objectAtIndex:1];
        UITextField *designation = [alert.textFields objectAtIndex:2];
        UITextField *company = [alert.textFields objectAtIndex:3];
        
            [obj setValue:name.text forKey:@"name"];
            [obj setValue:idTF.text forKey:@"id"];
            [obj setValue:designation.text forKey:@"designation"];
            [obj setValue:company.text forKey:@"company"];
            
            NSError *error;
            
            
            if (![context save:&error]) {
                NSLog(@"failed to save");
            }else{
                if ((name.text.length && idTF.text.length && designation.text.length && company.text.length )> 0){
                [context save:nil];
                NSLog(@"Saved Successfully");
                [self fetchData];
                [self.TableView reloadData];
                }
            }
            
        }];
        
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }];
    
    [alert addAction:OK];
    [alert addAction:cancel];
    [self presentViewController:alert animated:YES completion:nil];








}

- (IBAction)editButton:(UIButton*)sender {
    NSManagedObjectContext *context = [self getContext];
    
    NSManagedObject *obj = [resultArray objectAtIndex:_selectedPath.row];
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Enter Details" message:nil preferredStyle:UIAlertControllerStyleAlert];
    [alert addTextFieldWithConfigurationHandler:^(UITextField *nameTF) {
        nameTF.text = [obj valueForKey:@"name"];
    }];
        [alert addTextFieldWithConfigurationHandler:^(UITextField *idTF) {
            idTF.text = [obj valueForKey:@"id"];
    }];[alert addTextFieldWithConfigurationHandler:^(UITextField *designationTF) {
        designationTF.text = [obj valueForKey:@"designation"];
    }];[alert addTextFieldWithConfigurationHandler:^(UITextField *companyTF) {
        companyTF.text = [obj valueForKey:@"company"];
    }];
    //
    
    UIAlertAction *OK = [UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        
        UITextField *name = [alert.textFields objectAtIndex:0];
        UITextField *idTF = [alert.textFields objectAtIndex:1];
        UITextField *designation = [alert.textFields objectAtIndex:2];
        UITextField *company = [alert.textFields objectAtIndex:3];

    
        [obj setValue:name.text forKey:@"name"];
        [obj setValue:idTF.text forKey:@"id"];
        [obj setValue:designation.text forKey:@"designation"];
        [obj setValue:company.text forKey:@"company"];
        
        if ([context save:nil]) {
            NSLog(@"Saved Successfully");
            [self fetchData];
            [self.TableView reloadData];
        }
        
    }];
    
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleDestructive handler:nil];
    
    [alert addAction:OK];
    [alert addAction:cancel];
    [self presentViewController:alert animated:YES completion:nil];
}

                         
                         
                         
                         

- (IBAction)deleteButton:(UIButton*)sender {
    
    NSIndexPath *indexpath = [self.TableView indexPathForCell:(TableViewCell*)sender.superview.superview];
    
    NSManagedObjectContext *context = [self getContext];
    [context deleteObject:[resultArray objectAtIndex:indexpath.row]];
    [resultArray removeObjectAtIndex:indexpath.row];
    [context save:nil];
    [self.TableView reloadData];
    
}

- (IBAction)leftSwipe:(UISwipeGestureRecognizer*)sender {
    
    CGPoint location = [sender locationInView:self.TableView];
    self.selectedPath = [self.TableView indexPathForRowAtPoint:location];
    
    TableViewCell *cell = [self.TableView cellForRowAtIndexPath:self.selectedPath];
    
//    [self setModalTransitionStyle:UIModalTransitionStyleFlipHorizontal];
    cell.editOutlet.hidden = NO;
    cell.deleteOutlet.hidden = NO;
}

- (IBAction)rightSwipe:(UISwipeGestureRecognizer*)sender {
    
    CGPoint location = [sender locationInView:self.TableView];
    self.selectedPath = [self.TableView indexPathForRowAtPoint:location];
    
    TableViewCell *cell = [self.TableView cellForRowAtIndexPath:self.selectedPath];
    
    cell.editOutlet.hidden = YES;
    cell.deleteOutlet.hidden = YES;
    [self modalPresentationStyle];
    
    
}




@end
