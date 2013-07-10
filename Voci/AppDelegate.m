//
//  AppDelegate.m
//  Voci
//
//  Created by Hello World on 06/06/2013.
//  Copyright (c) 2013 SH MEDIA Limited. All rights reserved.
//

#import "AppDelegate.h"
#import "MasterViewController.h"
#import "Exercice.h"

@implementation AppDelegate {
    NSMutableArray *exercices;
    NSString* plistPath;
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    
    
    plistPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    plistPath = [plistPath stringByAppendingPathComponent:@"data.plist"];
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    if (![fileManager fileExistsAtPath:plistPath]) {
        NSLog(@"CREATING plist in DOCUMENTS");
        NSString *sourcePath = [[NSBundle mainBundle] pathForResource:@"data" ofType:@"plist"];
        [fileManager copyItemAtPath:sourcePath toPath:plistPath error:nil];
    }else {
        NSLog(@"ALREADY in DOCUMENTS");
    }
    
    
    NSDictionary* data = [[NSDictionary alloc] initWithContentsOfFile:plistPath];

    // Create Deep Model from plist
    exercices = [[NSMutableArray alloc] init];
    for(id object in [data objectForKey:@"exercices"] ) {
        Exercice *e = [[Exercice alloc] init];
        e.name = [object valueForKey:@"name"];
        e.data = [[NSMutableArray alloc] initWithCapacity:5];
        for(id object2 in [object valueForKey:@"data"]) {
            NSMutableArray *cards = [[NSMutableArray alloc] initWithCapacity:0];
            [e.data addObject:cards];
            for(NSArray *object3 in object2) {
                Card *c = [[Card alloc] init];
                c.front = [object3 valueForKey:@"front"];
                c.back = [object3 valueForKey:@"back"];
                [cards addObject:c];
            }
        }
        [exercices addObject:e];
    }
    
    
    // set model on masterview
	UINavigationController *navigationController = (UINavigationController *)self.window.rootViewController;
	MasterViewController *masterViewController = [[navigationController viewControllers] objectAtIndex:0];
	masterViewController.exercices = exercices;
    
    // App appearance
    [[UINavigationBar appearance] setTintColor:[UIColor blackColor]];
    [[UIToolbar appearance] setTintColor:[UIColor blackColor]];
    
    return YES;
}

-(void)saveData {
    
    // Serialize deep model to plist
    NSMutableArray *exportExercices = [[NSMutableArray alloc] init];
    for(Exercice *e in exercices) {
        NSMutableDictionary *exerciceDictionary = [[NSMutableDictionary alloc]initWithCapacity:2];
        [exerciceDictionary setObject:e.name forKey:@"name"];
        NSMutableArray *cardData = [[NSMutableArray alloc] initWithCapacity:e.data.count];
        
        for(NSMutableArray *r in e.data) {
             NSMutableArray *regsiterData = [[NSMutableArray alloc] initWithCapacity:r.count];
            for(Card * c in r) {
                NSMutableDictionary *cardDictionary = [[NSMutableDictionary alloc]initWithCapacity:2];
                [cardDictionary setObject:c.front forKey:@"front"];
                [cardDictionary setObject:c.back forKey:@"back"];
                [regsiterData addObject:cardDictionary];
            }
            [cardData addObject:regsiterData];
        }
        
       
        [exerciceDictionary setObject:cardData forKey:@"data"];
        [exportExercices addObject:exerciceDictionary];
        
    }
    
    NSMutableDictionary *saver = [[NSMutableDictionary alloc] initWithCapacity:1];
    [saver setObject:exportExercices forKey:@"exercices"];
    
    [saver writeToFile:plistPath atomically:NO];
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    [self saveData];
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:
    [self saveData];
}

@end
