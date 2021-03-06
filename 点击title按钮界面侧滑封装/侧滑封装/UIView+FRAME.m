//
//  UIView+FRAME.m
//  GDPR
//
//  Created by zxl on 2017/12/26.
//  Copyright © 2017年 EM. All rights reserved.
//

#import "UIView+FRAME.h"

@implementation UIView (FRAME)
- (CGPoint)origin
{
    return self.frame.origin;
}

- (void)setOrigin:(CGPoint)origin
{
    CGRect frame = self.frame;
    frame.origin = origin;
    self.frame = frame;
}

- (CGSize)size
{
    return self.frame.size;
}

- (void)setSize:(CGSize)size
{
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
}

- (CGFloat)top
{
    return self.origin.y;
}

- (void)setTop:(CGFloat)top
{
    CGRect frame = self.frame;
    frame.origin.y = top;
    self.frame = frame;
}

- (CGFloat)left
{
    return self.origin.x;
}

- (void)setLeft:(CGFloat)left
{
    CGRect frame = self.frame;
    frame.origin.x = left;
    self.frame = frame;
}

- (CGFloat)right
{
    return self.left + self.width;
}

- (void)setRight:(CGFloat)right
{
    CGRect frame = self.frame;
    frame.origin.x = right - frame.size.width;
    self.frame = frame;
}

- (CGFloat)bottom
{
    return self.top + self.height;
}

- (void)setBottom:(CGFloat)bottom
{
    CGRect frame = self.frame;
    frame.origin.y = bottom - frame.size.height;
    self.frame = frame;
}

- (CGFloat)width
{
    return self.size.width;
}

- (void)setWidth:(CGFloat)width
{
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}

- (CGFloat)height
{
    return self.size.height;
}

- (void)setHeight:(CGFloat)height
{
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}

- (CGFloat)x
{
    return self.left;
}

- (void)setX:(CGFloat)x
{
    self.frame = CGRectMake(x, self.top, self.width, self.height);
}

- (CGFloat)y
{
    return self.top;
}

- (void)setY:(CGFloat)y
{
    self.frame = CGRectMake(self.left, y, self.width, self.height);
}

-(CGFloat)centerX{
    
    return self.center.x;
}

-(void)setCenterX:(CGFloat)centerX{
    
    CGPoint  point=self.center;
    
    point.x=centerX;
    
    self.center=point;
    
    
}


-(CGFloat)centerY{
    return self.center.y;

}
-(void)setCenterY:(CGFloat)centerY{
    CGPoint  point=self.center;
    point.y=centerY;

    self.center=point;

}


@end
