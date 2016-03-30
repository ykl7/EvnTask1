//
//  TextFieldSeparator.m
//  TestUI
//
//  Created by YASH on 29/03/16.
//  Copyright © 2016 YASH. All rights reserved.
//

#import "TextFieldSeparator.h"

@implementation TextFieldSeparator

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void) awakeFromNib
{
    self.layer.shadowColor = self.backgroundColor.CGColor;
    self.layer.shadowOpacity = 0.8;
    self.layer.shadowOffset = CGSizeZero;
    self.layer.shadowRadius = 2.5;
}

@end
