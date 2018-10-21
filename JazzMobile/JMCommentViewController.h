//
//  JMCommentViewController.h
//  JazzMobile
//
//  Created by Ferat Capar on 29.02.2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Comment.h"

@interface JMCommentViewController : UIViewController
-(id) initWithComment:(Comment *) comment;
@property (weak, nonatomic) IBOutlet UILabel *userName;
@property (weak, nonatomic) IBOutlet UILabel *date;
@property (weak, nonatomic) IBOutlet UIWebView *commentView;


@end
