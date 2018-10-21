//
//  RootViewController.m
//  Project Tracker
//
//  Created by Ferat Capar on 30/1/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "RootViewController.h"
#import "ProjectListDelegate.h"
#import "MessageUtil.h"





@interface RootViewController ()
@property (strong,nonatomic) RTCAuthorizationDelegate *authorizationDelegate;
@end



@implementation RootViewController
@synthesize passwordTextField = _passwordTextField;
@synthesize userNameTextField = _userNameTextField;
@synthesize okButton = _okButton;
@synthesize repositoryAddress = _repositoryAddress;
@synthesize authorizationDelegate;




- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}


- (IBAction)onTouchUpInsideOkButton:(id)sender {
    if([self.userNameTextField text] == nil){
        [MessageUtil showError:@"Enter User Id"];
        [self.userNameTextField becomeFirstResponder]; 
    }else if([self.passwordTextField text]==nil){
        [MessageUtil showError:@"Enter Password"];
        [self.passwordTextField becomeFirstResponder]; 
    }else if([self.repositoryAddress text]==nil){
        [MessageUtil showError:@"Enter Repository Adress"];
        [self.repositoryAddress becomeFirstResponder]; 
    }else{
        NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
        NSString *baseUrl=[prefs stringForKey:@"repository_address"];
        if(baseUrl==nil){
            [prefs setObject:[self.repositoryAddress text] forKey:@"repository_address"];
            [prefs synchronize];
        }
        [[self view] endEditing:YES];
        [authorizationDelegate login:[self.userNameTextField text] password:[self.passwordTextField text] url:[self.repositoryAddress text]];
    }
}


- (IBAction)backGroundTapped:(id)sender {
    [[self view] endEditing:YES];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    if(textField == self.userNameTextField)
        [self.passwordTextField becomeFirstResponder];
    
    return YES; 
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    UIViewController *destination = segue.destinationViewController;
    if ([destination respondsToSelector:@selector(setProjects:)]) { 
      //  ProjectListDelegate *delegate=(ProjectListDelegate *) sender;
       // [destination setValue:delegate.projects forKey:@"projects"];
    }
}


#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.userNameTextField becomeFirstResponder];
    authorizationDelegate=[[RTCAuthorizationDelegate alloc] initWithController:self];
}

- (void)viewDidUnload
{
    [self setPasswordTextField:nil];
    [self setUserNameTextField:nil];
    [self setOkButton:nil];    
    [self setRepositoryAddress:nil];
    [super viewDidUnload];

}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    UIColor *background = [[UIColor alloc] initWithPatternImage:[UIImage imageNamed:@"bg.png"]];
    self.view.backgroundColor = background;
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    NSString *baseUrl=[prefs stringForKey:@"repository_address"];
    if(baseUrl!=nil){
        [self.repositoryAddress setText:baseUrl];
    }

}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}





@end
