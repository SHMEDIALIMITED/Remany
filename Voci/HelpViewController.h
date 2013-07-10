//
//  HelpViewController.h
//  Remany
//
//  Created by Hello World on 27/06/2013.
//  Copyright (c) 2013 SH MEDIA Limited. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HelpViewController;

@protocol HelpViewControllerDelegate <NSObject>
- (void)helpViewControllerDidCancel:(HelpViewController *)controller;
@end

@interface HelpViewController : UIViewController

@property (strong, nonatomic) IBOutlet UIWebView *content;
@property (weak, nonatomic) id <HelpViewControllerDelegate> delegate;

- (IBAction)cancel:(id)sender;

@end
