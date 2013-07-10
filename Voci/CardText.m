//
//  CardText.m
//  Voci
//
//  Created by Hello World on 12/06/2013.
//  Copyright (c) 2013 SH MEDIA Limited. All rights reserved.
//

#import "CardText.h"
#import "ColorUtils.h"

@implementation CardText

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.contentMode = UIViewContentModeRedraw;
    }
    return self;
}

- (void)drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    UIColor *color = [UIColor colorWithString:@"97ccde"];
    CGContextSetStrokeColorWithColor(context, color.CGColor);
    CGContextSetLineWidth(context, 0.5);
    CGFloat strokeOffset = 0.0;
    
    CGFloat rowHeight = self.font.lineHeight;
    CGRect rowRect;
    int i = 0;
    if (rowHeight > 0) {
            rowRect = CGRectMake(self.contentOffset.x, - self.bounds.size.height, self.contentSize.width, rowHeight);
        while (rowRect.origin.y < (self.bounds.size.height + self.contentSize.height)) {
            i++;
            if(i == 8) {
                rowRect.origin.y += rowHeight;
                continue;
            }
            
            CGContextMoveToPoint(context, rowRect.origin.x + strokeOffset, rowRect.origin.y + strokeOffset);
            CGContextAddLineToPoint(context, rowRect.origin.x + rowRect.size.width + strokeOffset, rowRect.origin.y + strokeOffset);
            CGContextDrawPath(context, kCGPathStroke);
            rowRect.origin.y += rowHeight;
        }
    }
    
    CGContextSetStrokeColorWithColor(context, [UIColor redColor].CGColor);
    CGContextSetLineWidth(context, 0.5);
    CGContextMoveToPoint(context, 0.0f, 11.0f);
    CGContextAddLineToPoint(context, rowRect.size.width, 11.0f);
    CGContextMoveToPoint(context, 0.0f, 14.0f);
    CGContextAddLineToPoint(context, rowRect.size.width, 14.0f);
    CGContextDrawPath(context, kCGPathStroke);
}


@end
