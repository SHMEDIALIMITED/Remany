//
//  CardViewController.m
//  Voci
//
//  Created by Hello World on 10/06/2013.
//  Copyright (c) 2013 SH MEDIA Limited. All rights reserved.
//

#import "AddCardViewController.h"
#import "GADBannerView.h"
#import "WSCoachMarksView.h"

@interface AddCardViewController ()

@end

@implementation AddCardViewController {
    GADBannerView *bannerView_;
    BOOL first;
}

@synthesize delegate;
@synthesize primaryView;
@synthesize secondaryView;

-(void)initHelp {
    // Setup coach marks
    NSArray *coachMarks = @[@{
                                @"rect": [NSValue valueWithCGRect:(CGRect){{10,124},{300,226}}],
                                @"caption":NSLocalizedString(@"Tap to enter text.", nil)
                                },
                            @{
                                @"rect": [NSValue valueWithCGRect:(CGRect){{10,124},{300,226}}],
                                @"caption": NSLocalizedString(@"Swipe from left to right to reveal back of the card.", nil)
                                }
                            ];
    WSCoachMarksView *coachMarksView = [[WSCoachMarksView alloc] initWithFrame:self.navigationController.view.bounds coachMarks:coachMarks];
    coachMarksView.maskColor = [[UIColor blackColor] colorWithAlphaComponent:0.8];
    [self.navigationController.view addSubview:coachMarksView];
    [coachMarksView start];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
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

- (void)viewDidLoad
{
    [super viewDidLoad];
    first = YES;
    self.title = NSLocalizedString(@"Add New Card", nil);
    [self initAd];
}

- (IBAction)showHelp:(id)sender {
    [self initHelp];
}

- (IBAction)done:(id)sender {
    Card *card = [[Card alloc] init];
    card.front = primaryView.text;
    card.back = secondaryView.text;
    [self.delegate cardViewController:self didAddCard:card];
}

- (IBAction)cancel:(id)sender {
    [self.delegate cardViewControllerDidCancel:self];
}

- (IBAction)swipeRight:(UISwipeGestureRecognizer *)sender {
    if(first) first = NO;
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

@end
