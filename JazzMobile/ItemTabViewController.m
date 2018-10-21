//
//  ItemTabViewController.m
//  Project Tracker
//
//  Created by Ferat Capar on 26.02.2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ItemTabViewController.h"

@interface ItemTabViewController ()

@end

@implementation ItemTabViewController
@synthesize imageDictionary,item,projectId,parentController;



- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    UIViewController *destination = segue.destinationViewController;

    if ([destination respondsToSelector:@selector(setItem:)]) {
        [destination setValue:item forKey:@"item"];
        [destination setValue:projectId forKey:@"projectId"];
        [destination setValue:^{[[self.viewControllers objectAtIndex:0] reload];} forKey:@"dissmissBlock"];
        [parentController setValue:@"YES" forKey:@"changed"];
    }
}



@end
