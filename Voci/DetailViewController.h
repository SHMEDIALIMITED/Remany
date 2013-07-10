//
//  DetailViewController.h
//  Voci
//
//  Created by Hello World on 06/06/2013.
//  Copyright (c) 2013 SH MEDIA Limited. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Exercice.h"
#import "AddCardViewController.h"

@interface DetailViewController : UIViewController <AddCardViewControllerDelegate, UIActionSheetDelegate, UIAlertViewDelegate>

@property (strong, nonatomic) Exercice *detailItem;

@property (strong, nonatomic) IBOutlet UITextView *primaryView;
@property (strong, nonatomic) IBOutlet UITextView *secondaryView;
@property (strong, nonatomic) IBOutlet UIView *container;
@property (strong, nonatomic) IBOutlet UIButton *rightButton;
@property (strong, nonatomic) IBOutlet UIButton *wrongButton;


- (IBAction)swipeRight:(UISwipeGestureRecognizer *)sender;
- (IBAction)swipeLeft:(UISwipeGestureRecognizer *)sender;

- (IBAction)deleteItem:(id)sender;
- (IBAction)rightAnswer:(id)sender;
- (IBAction)wrongAnswer:(id)sender;
- (IBAction)showHelp:(id)sender;
@end
