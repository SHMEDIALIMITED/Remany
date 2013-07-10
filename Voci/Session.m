//
//  Session.m
//  Voci
//
//  Created by Hello World on 24/06/2013.
//  Copyright (c) 2013 SH MEDIA Limited. All rights reserved.
//

#import "Session.h"

@implementation Session {
    int index;
}

@synthesize right;
@synthesize wrong;

-(id)init {
    self = [super init];
    if(self) {
        right = [[NSMutableArray alloc] initWithCapacity:0];
        wrong = [[NSMutableArray alloc] initWithCapacity:0];
    }
    return self;
}

-(void)reset {
    index = 0;
    [right removeAllObjects];
    [wrong removeAllObjects];
}

-(BOOL)update {
    index++;
    if(self.total == index) return YES;
    else return NO;
}

@end
