//
//  RegisterViewController.h
//  Voci
//
//  Created by Hello World on 22/06/2013.
//  Copyright (c) 2013 SH MEDIA Limited. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Exercice.h"
#import "AddCardViewController.h"
#import "HelpViewController.h"

@interface RegisterViewController : UITableViewController <AddCardViewControllerDelegate, HelpViewControllerDelegate>

@property (strong, nonatomic) IBOutlet UILabel *label1;
@property (strong, nonatomic) IBOutlet UILabel *label2;
@property (strong, nonatomic) IBOutlet UILabel *label3;
@property (strong, nonatomic) IBOutlet UILabel *label4;
@property (strong, nonatomic) IBOutlet UILabel *label5;
@property (strong, nonatomic) IBOutlet UILabel *label6;

@property (strong, nonatomic) Exercice *detailItem;
@property (strong, nonatomic) IBOutlet UITableViewCell *cell1;
@property (strong, nonatomic) IBOutlet UITableViewCell *cell2;
@property (strong, nonatomic) IBOutlet UITableViewCell *cell3;
@property (strong, nonatomic) IBOutlet UITableViewCell *cell4;
@property (strong, nonatomic) IBOutlet UITableViewCell *cell5;
@property (strong, nonatomic) IBOutlet UITableViewCell *cell6;

@end
