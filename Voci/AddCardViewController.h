//
//  CardViewController.h
//  Voci
//
//  Created by Hello World on 10/06/2013.
//  Copyright (c) 2013 SH MEDIA Limited. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Card.h"

@class AddCardViewController;

@protocol AddCardViewControllerDelegate <NSObject>
- (void)cardViewControllerDidCancel:(AddCardViewController *)controller;
- (void)cardViewController:(AddCardViewController *)controller didAddCard:(Card *)card;
@end

@interface AddCardViewController : UIViewController

@property (nonatomic, weak) id <AddCardViewControllerDelegate> delegate;
@property (strong, nonatomic) IBOutlet UITextView *primaryView;
@property (strong, nonatomic) IBOutlet UITextView *secondaryView;

- (IBAction)showHelp:(id)sender;
- (IBAction)done:(id)sender;
- (IBAction)cancel:(id)sender;
- (IBAction)swipeRight:(UISwipeGestureRecognizer *)sender;
- (IBAction)swipeLeft:(UISwipeGestureRecognizer *)sender;

@end
