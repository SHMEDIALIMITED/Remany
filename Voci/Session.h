//
//  Session.h
//  Voci
//
//  Created by Hello World on 24/06/2013.
//  Copyright (c) 2013 SH MEDIA Limited. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Session : NSObject

@property(nonatomic) NSMutableArray *right;
@property(nonatomic) NSMutableArray *wrong;
@property(nonatomic) int total;
-(void)reset;
-(BOOL)update;

@end
