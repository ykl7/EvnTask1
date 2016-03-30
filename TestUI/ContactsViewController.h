//
//  ContactsViewController.h
//  TestUI
//
//  Created by YASH on 29/03/16.
//  Copyright © 2016 YASH. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ContactsViewController : UIViewController

@property (strong, nonatomic) IBOutlet UITableView *contactsTable;
@property (strong, nonatomic) IBOutlet UISegmentedControl *selectOption;
@property (strong, nonatomic) IBOutlet UIView *segmentedBgView;

@end
