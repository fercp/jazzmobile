//
//  JMImageViewController.m
//  JazzMobile
//
//  Created by Ferat Capar on 28.03.2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "JMImageViewController.h"

@interface JMImageViewController ()
@property (strong,nonatomic) NSURL *url;
@property (strong,nonatomic) NSString *imageName;
@end

@implementation JMImageViewController
@synthesize navigationBar;
@synthesize imageView,url,imageName;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.navigationBar.topItem setTitle:imageName];
    NSData *data=[[NSData alloc] initWithContentsOfURL:url];
    UIImage *image=[[UIImage alloc] initWithData:data];
    [[self imageView] setImage:image];
	// Do any additional setup after loading the view.
}

- (void)viewDidUnload
{
    [self setImageView:nil];
    [self setNavigationBar:nil];
    [self setUrl:nil];
    [self setImageName:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (IBAction)close:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
