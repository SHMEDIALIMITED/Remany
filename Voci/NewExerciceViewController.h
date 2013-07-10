//
//  NewExerciceViewController.h
//  Voci
//
//  Created by Hello World on 06/06/2013.
//  Copyright (c) 2013 SH MEDIA Limited. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Exercice.h"
#import "AddCardViewController.h"

@class NewExerciceViewController;
@class Exercice;

@protocol NewExerciceViewControllerDelegate <NSObject>
- (void)newExerciceViewControllerDidCancel:(NewExerciceViewController *)controller;
- (void)newExerciceViewController:(NewExerciceViewController *)controller didAddExercice:(Exercice *)exercice;
@end

@interface NewExerciceViewController : UITableViewController
@property (strong, nonatomic) IBOutlet UITextField *nameTextField;

@property (nonatomic, weak) id <NewExerciceViewControllerDelegate> delegate;

- (IBAction)cancel:(id)sender;
- (IBAction)done:(id)sender;

@end
