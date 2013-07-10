//
//  HelpViewController.m
//  Remany
//
//  Created by Hello World on 27/06/2013.
//  Copyright (c) 2013 SH MEDIA Limited. All rights reserved.
//

#import "HelpViewController.h"

@interface HelpViewController ()

@end

@implementation HelpViewController

@synthesize content;
@synthesize delegate;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = NSLocalizedString(@"How it works", nil);
    NSString *path = [[NSBundle mainBundle] bundlePath];
    NSURL *baseURL = [NSURL fileURLWithPath:path];
    [[self content] loadHTMLString:NSLocalizedString(@"<style>*{ font-family:Helvetica; }</style><p>Remany utilises register cards where a question is written on one side and the answer on the other side. Each exercise consists of 6 card registers. The registers help to repeat cards in different intervals so that a memroised card will not be repeated unnecessarily and the card will be memorised for ever.</br></br><img src='Illustartion_REM_en.png'></img></p><ul><li><b>1st Register:</b>If a card is memorised correctly it will move to the 2nd register. These cards should be <bold>repeated every day.</bold>.</li><li><b>2nd Register:</b>If a card is memorised correctly it will move to the 3rd register. If not the card will go back to the 1st register. These cards should be <bold>repeated every second day.</bold></li><li><b>3rd Register:</b>If a card is memorised correctly it will move to the 4th register. If not the card will go back to the 1st register. These cards should be <bold>repeated every third day.</bold></li><li><b>4th Register:</b>If a card is memorised correctly it will move to the 4th register. If not the card will go back to the 1st register. These cards should be <bold>repeated every week.</bold></li><li><b>5th Register:</b>If a card is memorised correctly it will be moved to the 'Completed' register. If not the card will go back to the 1st register. These cards should be <bold>repeated every month.</bold></li><ul>", nil) baseURL:baseURL];
	// Do any additional setup after loading the view.
}

- (IBAction)cancel:(id)sender {
    [[self delegate] helpViewControllerDidCancel:self];
}
@end
