//
//  JMImageViewController.h
//  JazzMobile
//
//  Created by Ferat Capar on 28.03.2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JMImageViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
- (IBAction)close:(id)sender;
@property (weak, nonatomic) IBOutlet UINavigationBar *navigationBar;

@end
