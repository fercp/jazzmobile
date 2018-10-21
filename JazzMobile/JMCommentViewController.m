//
//  JMCommentViewController.m
//  JazzMobile
//
//  Created by Ferat Capar on 29.02.2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "JMCommentViewController.h"
#import "DateUtil.h"

@interface JMCommentViewController ()
@property (strong,nonatomic) Comment * comment;
@end

@implementation JMCommentViewController
@synthesize userName;
@synthesize date;
@synthesize commentView;
@synthesize comment=_comment;



-(id) initWithComment:(Comment *) comment{
    self.comment=comment;
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.userName.text=self.comment.creator.title;
    self.date.text=[DateUtil formatDate:self.comment.creationDate];
    NSString *htmlString=[NSString stringWithFormat:@"<html> \n"
     "<head> \n"
     "<style type=\"text/css\"> \n"
     "body {font-family: \"%@\"; font-size: 50;}\n"
     "</style> \n"
     "</head> \n"
     "<body>%@</body> \n"
     "</html>", @"helvetica",self.comment.description];

    [self.commentView loadHTMLString:htmlString baseURL:nil];
}

- (void)viewDidUnload
{
    [self setUserName:nil];
    [self setDate:nil];
    [self setCommentView:nil];
    [self setView:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
