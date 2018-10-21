//
//  JMEditPropertiesViewController.h
//  JazzMobile
//
//  Created by Ferat Capar on 26.03.2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RtcItem.h"

@interface JMEditPropertiesViewController : UITableViewController<UINavigationControllerDelegate, UIImagePickerControllerDelegate>
@property (strong,nonatomic) RtcItem *item;
@property (strong,nonatomic) NSString *projectId;
@property (copy,nonatomic)  void (^dissmissBlock)(void);
@property (weak, nonatomic) IBOutlet UIButton *hideButton;

- (IBAction)saveClicked:(id)sender;
- (IBAction)doneClicked:(id)sender;
@property (weak, nonatomic) IBOutlet UITextView *comment;
- (IBAction)hideKeyboard:(id)sender;
@property (weak, nonatomic) IBOutlet UITextView *commentText;

- (IBAction)attachPhoto:(id)sender;

- (IBAction)chooseFromAlbum:(id)sender;
@end
