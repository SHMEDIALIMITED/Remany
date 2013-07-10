//
//  NewExerciceViewController.m
//  Voci
//
//  Created by Hello World on 06/06/2013.
//  Copyright (c) 2013 SH MEDIA Limited. All rights reserved.
//

#import "NewExerciceViewController.h"
#import "Exercice.h"
    


@implementation NewExerciceViewController

@synthesize delegate;
@synthesize nameTextField = _nameTextField;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = NSLocalizedString(@"Add New Exercise", nil);
}

- (IBAction)done:(id)sender {
    Exercice *exercice = [[Exercice alloc] init];
    exercice.name = self.nameTextField.text;
    exercice.data = [NSMutableArray array];
    [exercice.data addObject:[NSMutableArray array]];
    [exercice.data addObject:[NSMutableArray array]];
    [exercice.data addObject:[NSMutableArray array]];
    [exercice.data addObject:[NSMutableArray array]];
    [exercice.data addObject:[NSMutableArray array]];
    [exercice.data addObject:[NSMutableArray array]];
    [self.delegate newExerciceViewController:self didAddExercice:exercice];
}
- (IBAction)cancel:(id)sender {
    [self.delegate newExerciceViewControllerDidCancel:self];
}

- (void)tableView:(UITableView *)tableView
didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	if (indexPath.section == 2)
		[self.nameTextField becomeFirstResponder];
}

// localize section header 
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    NSString *t = NSLocalizedString(@"Exercise Name", nil);
    return t;
}
@end
