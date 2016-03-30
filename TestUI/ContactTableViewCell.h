//
//  ContactTableViewCell.h
//  TestUI
//
//  Created by YASH on 29/03/16.
//  Copyright © 2016 YASH. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ContactTableViewCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *nameLabel;
@property (strong, nonatomic) IBOutlet UILabel *locationLabel;
@property (strong, nonatomic) IBOutlet UIImageView *profilePhoto;
@property (strong, nonatomic) IBOutlet UIImageView *availabilityIcon;

@end
