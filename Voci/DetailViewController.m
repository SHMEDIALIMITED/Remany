//
//  DetailViewController.m
//  Voci
//
//  Created by Hello World on 06/06/2013.
//  Copyright (c) 2013 SH MEDIA Limited. All rights reserved.
//

#import "DetailViewController.h"
#import <UIKit/UIKit.h>
#import "AddCardViewController.h"
#import "Exercice.h"
 #import <QuartzCore/QuartzCore.h>
#import "AppDelegate.h"
#import "Session.h"
#import "GADBannerView.h"
#import "ColorUtils.h"
#import "WSCoachMarksView.h"

@interface DetailViewController ()
- (void)configureView;
   
@end

@implementation DetailViewController {
    NSInteger index;
    Session *session;
     GADBannerView *bannerView_;
    BOOL first;
}

@synthesize primaryView;
@synthesize secondaryView;
@synthesize container;
@synthesize rightButton;
@synthesize wrongButton;

#pragma mark - Managing the detail item

-(void)initHelp {
    // Setup coach marks
    NSArray *coachMarks = @[
                            @{
                                @"rect": [NSValue valueWithCGRect:(CGRect){{10,124},{300,226}}],
                                @"caption": NSLocalizedString( @"Swipe from left to right to reveal back of the card.",nil)
                                },
                            @{
                                @"rect": [NSValue valueWithCGRect:(CGRect){{10,351},{300.0f,75}}],
                                @"caption": NSLocalizedString(@"Tap left button if you know the correct answer or the right button if your answer was incorrect.", nil)
                                },
                            @{
                                @"rect": [NSValue valueWithCGRect:(CGRect){{0,self.navigationController.view.frame.size.height - 40},{40,40}}],
                                @"caption": NSLocalizedString(@"Tap to delete current card.", nil)
                                }
                            ];
    WSCoachMarksView *coachMarksView = [[WSCoachMarksView alloc] initWithFrame:self.navigationController.view.bounds coachMarks:coachMarks];
    coachMarksView.maskColor = [[UIColor blackColor] colorWithAlphaComponent:0.8];
    [self.navigationController.view addSubview:coachMarksView];
    [coachMarksView start];
}

-(void)initAd {
    // Create a view of the standard size at the top of the screen.
    // Available AdSize constants are explained in GADAdSize.h.
    
    bannerView_ = [[GADBannerView alloc] initWithAdSize:kGADAdSizeBanner];
    
    // Specify the ad's "unit identifier". This is your AdMob Publisher ID.
    bannerView_.adUnitID = @"a151c8a135d79f1";
    
    // Let the runtime know which UIViewController to restore after taking
    // the user wherever the ad goes and add it to the view hierarchy.
    bannerView_.rootViewController = self;
    [self.view addSubview:bannerView_];
    [self.view bringSubviewToFront:bannerView_];
    
    GADRequest *r = [[GADRequest alloc] init];
    // Initiate a generic request to load it with an ad.
    [bannerView_ loadRequest:r];
}

- (void)setDetailItem:(id)newDetailItem
{
   
    if (_detailItem != newDetailItem) {
        _detailItem = newDetailItem;
        
        // Update the view.
        [self configureView];
    }
}

- (void)configureView
{
    // Update the user interface for the detail item.
    if (self.detailItem) {
        
        
        Exercice *e = (Exercice *) self.detailItem;
        session.total += [e.data[e.index] count];
        [session reset];
        [self shuffle];
        
        
        self.title = [NSMutableString stringWithFormat:@"%@ : %i",e.name, e.index+1];
        
        if(e.index == 5) {
            // hide 1st tools group for completed register
        }else {
            // show 1st tools group            
        }
        
        [container.layer setBorderColor:[UIColor lightGrayColor].CGColor];
        [container.layer setBorderWidth:0.5f];
        [container.layer setShadowColor:[UIColor blackColor].CGColor];
        [container.layer setShadowOpacity:0.3];
        [container.layer setShadowRadius:8.0];
        [container.layer setShadowOffset:CGSizeMake(0.0, 0.0)];
        
        
       
        [self update];
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    index = 0;
    first = YES;
    if(!session) session = [[Session alloc] init];
       
//    [rightButton setTitle:NSLocalizedString(@"Right Button",nil ) forState:UIControlStateNormal];
//    [rightButton setTitle:NSLocalizedString(@"Right Button",nil ) forState:UIControlStateHighlighted];
//    [rightButton setTitle:NSLocalizedString(@"Right Button",nil ) forState:UIControlStateSelected];
//    [rightButton setTitle:NSLocalizedString(@"Right Button",nil ) forState:UIControlStateDisabled];
//    
//    [wrongButton setTitle:NSLocalizedString(@"Wrong Button",nil ) forState:UIControlStateNormal];
//    [wrongButton setTitle:NSLocalizedString(@"Wrong Button",nil ) forState:UIControlStateHighlighted];
//    [wrongButton setTitle:NSLocalizedString(@"Wrong Button",nil ) forState:UIControlStateSelected];
//    [wrongButton setTitle:NSLocalizedString(@"Wrong Button",nil ) forState:UIControlStateDisabled];
    
   	// Do any additional setup after loading the view, typically from a nib.
    [self configureView];
    [self initAd];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (IBAction)swipeRight:(UISwipeGestureRecognizer *)sender {
    first = NO;
    [UIView transitionFromView:primaryView
                        toView:secondaryView
                      duration:0.4
                       options:UIViewAnimationOptionTransitionFlipFromLeft
     
                    completion:^(BOOL finished) {
                        if (finished) {
                            
                        }
                    }
     ];
}

- (IBAction)swipeLeft:(UISwipeGestureRecognizer *)sender {
    if(first) return;
    [UIView transitionFromView:secondaryView
                        toView:primaryView
                      duration:0.4
                       options:UIViewAnimationOptionTransitionFlipFromRight
     
                    completion:^(BOOL finished) {
                        if (finished) {
                            
                        }
                    }
     ];
}

- (void) update{
    
    Exercice *exercice = (Exercice *) self.detailItem;
    
    if([[exercice.data objectAtIndex:exercice.index] count] == 0) {
        [container setHidden:YES];
    } else {
        [container setHidden:NO];
        Card *card = [exercice.data objectAtIndex:exercice.index][index];
        primaryView.text = card.front;
        secondaryView.text = card.back;
    }
}

- (IBAction)swipeUp:(UISwipeGestureRecognizer *)sender {
    [self next];
}

- (IBAction)swipeDown:(UISwipeGestureRecognizer *)sender {
    [self previous];
}

-(void) previous {
    if(index > 0) index--;
    else return;
    [UIView animateWithDuration: 0.3
                          delay: 0
                        options: (UIViewAnimationOptionCurveEaseIn | UIViewAnimationOptionAllowUserInteraction)
                     animations:^{
                         [container setTransform:CGAffineTransformMakeTranslation(0.0, -300.0)];
                     }
                     completion:^(BOOL finished) {
                         [self update];
                         [UIView transitionFromView:secondaryView
                                             toView:primaryView
                                           duration:0.0
                                            options:UIViewAnimationOptionTransitionFlipFromLeft
                          
                                         completion:^(BOOL finished) {
                                             if (finished) {
                                                 
                                             }
                                         }
                          ];
                         [container setTransform:CGAffineTransformMakeTranslation(0.0, 480.0)];
                         [UIView animateWithDuration: 0.3
                                               delay: 0.1
                                             options: (UIViewAnimationOptionCurveEaseOut | UIViewAnimationOptionAllowUserInteraction)
                                          animations:^{
                                              [container setTransform:CGAffineTransformMakeTranslation(0.0, 0.0)];
                                          }
                                          completion:^(BOOL finished) {
                                              
                                          }
                          ];
                         
                     }
     ];

}

-(void) next {
    Exercice *exercice = (Exercice *) self.detailItem;
    
    int n = [[exercice.data objectAtIndex:exercice.index] count];
    n--;
    if(index < n) {
        index++;
    } else {
        if([[exercice.data objectAtIndex:exercice.index] count] > 0) index = 0;
        return;
    }
    [UIView animateWithDuration: 0.3
                          delay: 0
                        options: (UIViewAnimationOptionCurveEaseIn | UIViewAnimationOptionAllowUserInteraction)
                     animations:^{
                         [container setTransform:CGAffineTransformMakeTranslation(0.0, 480.0)];
                     }
                     completion:^(BOOL finished) {
                         [self update];
                         [UIView transitionFromView:secondaryView
                                             toView:primaryView
                                           duration:0.0
                                            options:UIViewAnimationOptionTransitionFlipFromLeft
                          
                                         completion:^(BOOL finished) {
                                             if (finished) {
                                                 
                                             }
                                         }
                          ];
                         [container setTransform:CGAffineTransformMakeTranslation(0.0, -300.0)];
                         [UIView animateWithDuration: 0.3
                                               delay: 0.1
                                             options: (UIViewAnimationOptionCurveEaseOut | UIViewAnimationOptionAllowUserInteraction)
                                          animations:^{
                                              [container setTransform:CGAffineTransformMakeTranslation(0.0, 0.0)];
                                          }
                                          completion:^(BOOL finished) {
                                              
                                          }
                          ];
                         
                     }
     ];

}

- (void)shuffle {
    Exercice *exercice = (Exercice *) self.detailItem;
    NSUInteger count = [[exercice.data objectAtIndex:exercice.index] count];
    for (NSUInteger i = 0; i < count; ++i) {
        // Select a random element between i and end of array to swap with.
        NSInteger nElements = count - i;
        NSInteger n = (arc4random() % nElements) + i;
        [[exercice.data objectAtIndex:exercice.index] exchangeObjectAtIndex:i withObjectAtIndex:n];
    }
    index = 0;
    [self update];
}

- (IBAction)deleteItem:(id)sender {
    
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self
                                                    cancelButtonTitle:NSLocalizedString(@"Cancel", nil)
                                               destructiveButtonTitle:NSLocalizedString(@"Delete Card", nil)
                                                    otherButtonTitles: nil];
    
    actionSheet.actionSheetStyle = UIActionSheetStyleAutomatic;
    [actionSheet showFromToolbar:self.navigationController.toolbar];
    
}

- (IBAction)rightAnswer:(id)sender {
    Exercice *exercice = (Exercice *) self.detailItem;
    Card *card = [exercice.data objectAtIndex:exercice.index][index];
    [session.right addObject:card];
    if(exercice.index < 5) {
        
        [[exercice.data objectAtIndex:exercice.index] removeObjectAtIndex:index ];
        

        [[exercice.data objectAtIndex:exercice.index+1] addObject:card];

        if([[exercice.data objectAtIndex:exercice.index] count] > 0){
            if([session update]) {
                [self sessionHasEnded];
                //[self.navigationController popViewControllerAnimated:YES];
                return;
            }
            index--;
            [self next];
        }
        else {
            
            [self sessionHasEnded];
            //[self.navigationController popViewControllerAnimated:YES];
            return;
        }
    }else {
        if([session update]) {
            [self sessionHasEnded];
            //[self.navigationController popViewControllerAnimated:YES];
            return;
        }
        [self next];
    }
}

-(void)sessionHasEnded {
    NSMutableString *message = [NSMutableString stringWithFormat:NSLocalizedString(@"%i correct answers\n %i wrong answers",nil), session.right.count, session.wrong.count];
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Session Result", nil)
                                                    message:message
                                                   delegate:self
                                          cancelButtonTitle:NSLocalizedString(@"OK", nil)
                                          otherButtonTitles:nil];
    [alert show];
}

- (IBAction)wrongAnswer:(id)sender {
    Exercice *exercice = (Exercice *) self.detailItem;
    Card *card = [exercice.data objectAtIndex:exercice.index][index];
    
    if(exercice.index < 5) {
        [[exercice.data objectAtIndex:exercice.index] removeObjectAtIndex:index ];
        
        
        
        [[exercice.data objectAtIndex:0] addObject:card];
    }
    [session.wrong addObject:card];
    
    
    if([[exercice.data objectAtIndex:exercice.index] count] > 0){
        if([session update]) {
            [self sessionHasEnded];
            return;
        }
        index--;
        [self next];
    }
    else {
        [self sessionHasEnded];
        return;
    }
}

- (IBAction)showHelp:(id)sender {
   [self initHelp];
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    [session reset];
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 0) {
        Exercice *exercice = (Exercice *) self.detailItem;
        if([[exercice.data objectAtIndex:exercice.index] count] == 0) return;
        [[exercice.data objectAtIndex:exercice.index] removeObjectAtIndex:index];
        if(index > 0) index--;
        [self update];
    } 
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"AddCard"])
	{
		UINavigationController *navigationController = segue.destinationViewController;
		AddCardViewController *cardViewController = [[navigationController viewControllers]objectAtIndex:0];
		cardViewController.delegate = self;
	}
}



#pragma mark - NewExerciceViewControllerDelegate

- (void)cardViewController:(AddCardViewController *)controller didAddCard:(Card *)card {
    Exercice *exercice = (Exercice *) self.detailItem;
    [[exercice.data objectAtIndex:0] addObject:card];
    // [exercice.data  insertObject:card atIndex:0];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"save" object:nil];
    [self dismissViewControllerAnimated:YES completion:nil];
    [self update];
}

- (void)cardViewControllerDidCancel:(AddCardViewController *)controller {
	[self dismissViewControllerAnimated:YES completion:nil];
}



@end
