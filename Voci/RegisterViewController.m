//
//  RegisterViewController.m
//  Voci
//
//  Created by Hello World on 22/06/2013.
//  Copyright (c) 2013 SH MEDIA Limited. All rights reserved.
//

#import "RegisterViewController.h"
#import "Exercice.h"
#import "AddCardViewController.h"
#import "ColorUtils.h"
#import "HelpViewController.h"

@interface RegisterViewController ()

@end

@implementation RegisterViewController {
    
}

@synthesize label1;
@synthesize label2;
@synthesize label3;
@synthesize label4;
@synthesize label5;
@synthesize label6;

@synthesize cell1;
@synthesize cell2;
@synthesize cell3;
@synthesize cell4;
@synthesize cell5;
@synthesize cell6;



- (void)setDetailItem:(id)newDetailItem
{
    if (_detailItem != newDetailItem) {
        _detailItem = newDetailItem;
    }
}


- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    return self;
}

-(void)viewWillAppear:(BOOL)animated {

    [super viewWillAppear:animated];
    Exercice *e = (Exercice *) self.detailItem;
    
    // Update the view.
    self.title = e.name;
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc]
                                   initWithTitle: NSLocalizedString(@"Back", nil)
                                   style: UIBarButtonItemStyleBordered
                                   target: nil action: nil];
    
    [self.navigationItem setBackBarButtonItem: backButton];
    
    self.label1.text = [NSMutableString stringWithFormat:NSLocalizedString( @"%d of %d Cards", nil),[e.data[0] count], 10];
    self.label2.text = [NSMutableString stringWithFormat:NSLocalizedString( @"%d of %d Cards", nil),[e.data[1] count], 20];
    self.label3.text = [NSMutableString stringWithFormat:NSLocalizedString( @"%d of %d Cards", nil),[e.data[2] count], 30];
    self.label4.text = [NSMutableString stringWithFormat:NSLocalizedString( @"%d of %d Cards", nil),[e.data[3] count], 40];
    self.label5.text = [NSMutableString stringWithFormat:NSLocalizedString( @"%d of %d Cards", nil),[e.data[4] count], 60];
    self.label6.text = [NSMutableString stringWithFormat:NSLocalizedString( @"%d Cards", nil),[e.data[5] count]];
    
    
    
    cell1.textLabel.text = NSLocalizedString(@"1st Register", nil);
    cell2.textLabel.text = NSLocalizedString(@"2nd Register", nil);
    cell3.textLabel.text = NSLocalizedString(@"3rd Register", nil);
    cell4.textLabel.text = NSLocalizedString(@"4th Register", nil);
    cell5.textLabel.text = NSLocalizedString(@"5th Register", nil);
    cell6.textLabel.text = NSLocalizedString(@"Completed", nil);
    
    [self enableCell:cell1];
    if([e.data[0] count] > 20) {
        [cell1 setBackgroundColor:[UIColor colorWithString:@"FF898C"]];
    }else if([e.data[0] count] > 10) {
        [cell1 setBackgroundColor:[UIColor colorWithString:@"FFC48C"]];
    }else if([e.data[0] count] == 0) {
        [self disableCell:cell1];
        [cell1 setBackgroundColor:[UIColor whiteColor]];
        cell1.textLabel.backgroundColor = [UIColor clearColor];
        cell1.detailTextLabel.backgroundColor = [UIColor clearColor];
    }else {
        [cell1 setBackgroundColor:[UIColor whiteColor]];
        cell1.textLabel.backgroundColor = [UIColor clearColor];
        cell1.detailTextLabel.backgroundColor = [UIColor clearColor];
    }
    
    [self enableCell:cell2];
    
    if([e.data[1] count] > 30) {
        [cell2 setBackgroundColor:[UIColor colorWithString:@"FF898C"]];
    }else if([e.data[1] count] > 20)  {
        [cell2 setBackgroundColor:[UIColor colorWithString:@"FFC48C"]];
    }else if([e.data[1] count] == 0) {
        [self disableCell:cell2];
        [cell2 setBackgroundColor:[UIColor whiteColor]];
        cell2.textLabel.backgroundColor = [UIColor clearColor];
        cell2.detailTextLabel.backgroundColor = [UIColor clearColor];
    }else {
        [cell2 setBackgroundColor:[UIColor whiteColor]];
        cell2.textLabel.backgroundColor = [UIColor clearColor];
        cell2.detailTextLabel.backgroundColor = [UIColor clearColor];
    }
    
    [self enableCell:cell3];
    if([e.data[2] count] > 40) {
        [cell3 setBackgroundColor:[UIColor colorWithString:@"FF898C"]];
    }else if([e.data[2] count] > 30) {
        [cell3 setBackgroundColor:[UIColor colorWithString:@"FFC48C"]];
    }else if([e.data[2] count] == 0) {
        [self disableCell:cell3];
        [cell3 setBackgroundColor:[UIColor whiteColor]];
        cell3.textLabel.backgroundColor = [UIColor clearColor];
        cell3.detailTextLabel.backgroundColor = [UIColor clearColor];
    }else {
        [cell3 setBackgroundColor:[UIColor whiteColor]];
        cell3.textLabel.backgroundColor = [UIColor clearColor];
        cell3.detailTextLabel.backgroundColor = [UIColor clearColor];
    }
    
    [self enableCell:cell4];
    if([e.data[3] count] > 50) {
        [cell4 setBackgroundColor:[UIColor colorWithString:@"FF898C"]];
    }else if([e.data[3] count] > 40) {
        [cell4 setBackgroundColor:[UIColor colorWithString:@"FFC48C"]];
    }else if([e.data[3] count] == 0) {
        [self disableCell:cell4];
        [cell4 setBackgroundColor:[UIColor whiteColor]];
        cell4.textLabel.backgroundColor = [UIColor clearColor];
        cell4.detailTextLabel.backgroundColor = [UIColor clearColor];
    }else {
        [cell4 setBackgroundColor:[UIColor whiteColor]];
        cell4.textLabel.backgroundColor = [UIColor clearColor];
        cell4.detailTextLabel.backgroundColor = [UIColor clearColor];
    }
    
    [self enableCell:cell5];
    if([e.data[4] count] > 70) {
        [cell5 setBackgroundColor:[UIColor colorWithString:@"FF898C"]];
    }else if([e.data[4] count] > 60) {
        [cell5 setBackgroundColor:[UIColor colorWithString:@"FFC48C"]];
    }else if([e.data[4] count] == 0) {
        [self disableCell:cell5];
        [cell5 setBackgroundColor:[UIColor whiteColor]];
        cell5.textLabel.backgroundColor = [UIColor clearColor];
        cell5.detailTextLabel.backgroundColor = [UIColor clearColor];
    }else {
        [cell5 setBackgroundColor:[UIColor whiteColor]];
        cell5.textLabel.backgroundColor = [UIColor clearColor];
        cell5.detailTextLabel.backgroundColor = [UIColor clearColor];
    }
    
     [self enableCell:cell6];
    if([e.data[5] count] == 0) {
        [self disableCell:cell6];
    }else {
        [cell6 setBackgroundColor:[UIColor whiteColor]];
        cell6.textLabel.backgroundColor = [UIColor clearColor];
        cell6.detailTextLabel.backgroundColor = [UIColor clearColor];
    }
}

-(void) enableCell:(UITableViewCell *)cell {
    cell.userInteractionEnabled = YES;
    cell.selectionStyle = UITableViewCellSelectionStyleBlue;
    cell.textLabel.enabled = YES;
    cell.detailTextLabel.enabled = YES;
}

-(void) disableCell:(UITableViewCell *)cell {
    cell.userInteractionEnabled = NO;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.textLabel.enabled = NO;
    cell.detailTextLabel.enabled = NO;
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"AddCard"])
	{
		UINavigationController *navigationController = segue.destinationViewController;
		AddCardViewController *cardViewController = [[navigationController viewControllers]objectAtIndex:0];
		cardViewController.delegate = self;
	}else if ([segue.identifier isEqualToString:@"Help"])
	{
		UINavigationController *navigationController = segue.destinationViewController;
		HelpViewController *helpViewController = [[navigationController viewControllers]objectAtIndex:0];
		helpViewController.delegate = self;
	}else {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        Exercice *exercice = (Exercice *) self.detailItem;
        exercice.index = indexPath.row;
        [[segue destinationViewController] setDetailItem:exercice];
    }
}

- (void)cardViewController:(AddCardViewController *)controller didAddCard:(Card *)card {
    Exercice *exercice = (Exercice *) self.detailItem;
    [[exercice.data objectAtIndex:0] addObject:card];
    // [exercice.data  insertObject:card atIndex:0];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"save" object:nil];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)cardViewControllerDidCancel:(AddCardViewController *)controller {
	[self dismissViewControllerAnimated:YES completion:nil];
}

- (void)helpViewControllerDidCancel:(HelpViewController *)controller {
	[self dismissViewControllerAnimated:YES completion:nil];
}


@end
