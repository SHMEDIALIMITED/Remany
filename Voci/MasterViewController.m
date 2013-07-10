//
//  MasterViewController.m
//  Voci
//
//  Created by Hello World on 06/06/2013.
//  Copyright (c) 2013 SH MEDIA Limited. All rights reserved.
//

#import "MasterViewController.h"
#import "DetailViewController.h"
#import "ColorUtils.h"
#import "HelpViewController.h"


@interface MasterViewController () {
   
}
@end

@implementation MasterViewController

@synthesize exercices;

- (void)awakeFromNib
{
    [super awakeFromNib];
}



- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    self.navigationItem.leftBarButtonItem = self.editButtonItem;
    self.title = NSLocalizedString(@"RemAny",nil);
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc]
                                   initWithTitle: NSLocalizedString(@"Back",nil)
                                   style: UIBarButtonItemStyleBordered
                                   target: nil action: nil];
    
    [self.navigationItem setBackBarButtonItem: backButton];
    
    
    BOOL coachMarksShown = [[NSUserDefaults standardUserDefaults] boolForKey:@"RemanyHelpShown"];
    if (coachMarksShown == NO) {
        // Don't show again
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"RemanyHelpShown"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
        // Show coach marks
        [self performSegueWithIdentifier: @"Help" sender: self];
    }
}

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return exercices.count;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return NO;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView
                             dequeueReusableCellWithIdentifier:@"ExerciceCell"];
	Exercice *exercice = [self.exercices objectAtIndex:indexPath.row];
	UILabel *nameLabel = (UILabel *)[cell viewWithTag:0];
	nameLabel.text = exercice.name;
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [exercices removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
    }
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"ShowRegister"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        Exercice *exercice = exercices[indexPath.row];
        [[segue destinationViewController] setDetailItem:exercice];
    } else if ([segue.identifier isEqualToString:@"NewExercice"])
	{
		UINavigationController *navigationController = segue.destinationViewController;
		NewExerciceViewController *playerDetailsViewController = [[navigationController viewControllers]objectAtIndex:0];
		playerDetailsViewController.delegate = self;
	}else if ([segue.identifier isEqualToString:@"Help"])
	{
		UINavigationController *navigationController = segue.destinationViewController;
		HelpViewController *helpViewController = [[navigationController viewControllers]objectAtIndex:0];
		helpViewController.delegate = self;
	}
}

#pragma mark - NewExerciceViewControllerDelegate

- (void)newExerciceViewController:(NewExerciceViewController *)controller didAddExercice:(Exercice *)exercice {
    
    [self.exercices addObject:exercice];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:[self.exercices count] - 1 inSection:0];
    [self.tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"save" object:nil];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)newExerciceViewControllerDidCancel:(NewExerciceViewController *)controller {
	[self dismissViewControllerAnimated:YES completion:nil];
}


- (void)helpViewControllerDidCancel:(HelpViewController *)controller {
	[self dismissViewControllerAnimated:YES completion:nil];
}

@end
