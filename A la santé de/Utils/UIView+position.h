//
//  UIView+position.h
//  A la santé de
//
//  Created by Valentin Garcia on 03/04/2019.
//  Copyright © 2019 Valentin Garcia. All rights reserved.
//
#import <UIKit/UIKit.h>

@interface UIView (position)

@property (nonatomic) CGPoint origin;
@property (nonatomic) CGSize size;

@property (nonatomic) CGFloat rx;
@property (nonatomic) CGFloat ry;

// Setting these modifies the origin but not the size.
@property (nonatomic) CGFloat right;
@property (nonatomic) CGFloat bottom;

@property (nonatomic) CGFloat width;
@property (nonatomic) CGFloat height;

- (void)centerViewHorizontically;
- (void)centerViewVertically;

@end
