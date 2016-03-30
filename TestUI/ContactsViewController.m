//
//  ContactsViewController.m
//  TestUI
//
//  Created by YASH on 29/03/16.
//  Copyright © 2016 YASH. All rights reserved.
//

#import "ContactsViewController.h"
#import "ContactTableViewCell.h"

@interface ContactsViewController () <UITableViewDataSource, UITableViewDelegate>
{
    NSMutableArray *filteredNameArray;
    NSMutableArray *filteredLocationArray;
    
    NSArray *nameArray;
    NSArray *locationArray;
}

@end

@implementation ContactsViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName : [UIColor whiteColor]};
    
    UIImage *separatorImage = [self makeImageWithColor:self.view.backgroundColor andSize:CGSizeMake(1, self.selectOption.bounds.size.height)];
    UIImage *selectedSeparatorImage = [self makeImageWithColor:[UIColor colorWithRed:51/255 green:102/255 blue:153/255 alpha:1.0] andSize:CGSizeMake(1, self.selectOption.bounds.size.height)];
    UIImage *normalBackgroundImage = [self makeImageWithColor:self.view.backgroundColor andSize:CGSizeMake(44, self.selectOption.bounds.size.height)];

    [self.selectOption setDividerImage:separatorImage forLeftSegmentState:UIControlStateNormal rightSegmentState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    [self.selectOption setDividerImage:selectedSeparatorImage forLeftSegmentState:UIControlStateNormal rightSegmentState:UIControlStateSelected barMetrics:UIBarMetricsDefault];
    [self.selectOption setDividerImage:selectedSeparatorImage forLeftSegmentState:UIControlStateSelected rightSegmentState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    [self.selectOption setBackgroundImage:normalBackgroundImage forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    
    nameArray = [NSArray new];
    locationArray = [NSArray new];
    
    nameArray = @[@"Donald Trump", @"Hillary Clinton", @"Barack Obama", @"Narendra Modi", @"Cristiano Ronaldo", @"Lionel Messi", @"Jordi Alba", @"Juliano Belletti", @"David Beckham", @"Dennis Ritchie", @"Linus Torvalds"];
    locationArray = @[@"Washington", @"Oregon", @"Boston", @"New Delhi", @"Madrid", @"Barcelona", @"Barcelona", @"Rio de Janeiro", @"Manchester", @"New Jersey", @"Helsinki"];
    
}

- (void) clearDataSource
{
    filteredLocationArray = [NSMutableArray new];
    filteredNameArray = [NSMutableArray new];
}

- (void)viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBar.translucent = false;
    [self.navigationController.navigationBar setBarTintColor:self.view.backgroundColor];
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
    [self.navigationController.navigationBar setBackgroundImage:[self makeImageWithColor:self.view.backgroundColor andSize:CGSizeMake(self.view.bounds.size.width, 66)] forBarMetrics:UIBarMetricsDefault];
    [self clearDataSource];
    for (int i=1; i<nameArray.count; i++)
    {
        if (i%5 == 0)
        {
            [filteredNameArray addObject:[nameArray objectAtIndex:i]];
            [filteredLocationArray addObject:[locationArray objectAtIndex:i]];
        }
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return filteredNameArray.count;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ContactTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    if (cell == nil)
    {
        cell = [[ContactTableViewCell alloc] init];
    }
    
    cell.nameLabel.text = [filteredNameArray objectAtIndex:indexPath.row];
    cell.profilePhoto.image = [self addCircularBorder:[UIImage imageNamed:[NSString stringWithFormat:@"%@.jpeg", [filteredNameArray objectAtIndex:indexPath.row]]]];
    cell.locationLabel.text = [filteredLocationArray objectAtIndex:indexPath.row];
    if (indexPath.row%2 == 0)
    {
        cell.availabilityIcon.image = [UIImage imageNamed:@"available.png"];
    }
    else
    {
        cell.availabilityIcon.image = [UIImage imageNamed:@"busy.png"];
    }
    
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    return [[UIView alloc] initWithFrame:CGRectZero];
}

- (IBAction)goBack:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)selectIndex:(id)sender
{
    if (self.selectOption.selectedSegmentIndex == 0)
    {
        [self clearDataSource];
        for (int i=1; i<nameArray.count; i++)
        {
            if (i%5 == 0)
            {
                [filteredNameArray addObject:[nameArray objectAtIndex:i]];
                [filteredLocationArray addObject:[locationArray objectAtIndex:i]];
            }
            [self.contactsTable reloadData];
        }
    }
    else if (self.selectOption.selectedSegmentIndex == 1)
    {
        [self clearDataSource];
        for (int i=1; i<nameArray.count; i++)
        {
            if (i%3 == 0)
            {
                [filteredLocationArray addObject:[locationArray objectAtIndex:i]];
                [filteredNameArray addObject:[nameArray objectAtIndex:i]];
            }
        }
        [self.contactsTable reloadData];
    }
    else
    {
        [self clearDataSource];
        for (int i=1; i<nameArray.count; i++)
        {
            [filteredNameArray addObject:[nameArray objectAtIndex:i]];
            [filteredLocationArray addObject:[locationArray objectAtIndex:i]];
        }
        [self.contactsTable reloadData];
    }
}

- (UIImage *)addCircularBorder : (UIImage *) image
{
	
	CGFloat minWidth = MIN(image.size.width, image.size.height);
	CGRect imageRect = CGRectMake(0, 0, minWidth, minWidth);
	
	UIGraphicsBeginImageContextWithOptions(imageRect.size, NO, [UIScreen mainScreen].scale);
	
	UIBezierPath *maskPath = [UIBezierPath bezierPathWithOvalInRect:imageRect];
	[maskPath addClip];
	
	[image drawInRect:imageRect];
	
	UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
	UIGraphicsEndImageContext();
	
	return newImage;
	
}

- (UIImage *) makeImageWithColor: (UIColor *) color andSize: (CGSize) size
{
    CGRect imageRect = CGRectMake(0, 0, size.width, size.height);
    
    UIGraphicsBeginImageContext(imageRect.size);
    
    UIBezierPath *bezierPath = [UIBezierPath bezierPathWithRoundedRect:imageRect cornerRadius:4];
    
    [color setFill];
    [bezierPath fill];
    
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return newImage;
}
@end
