//
//  JMSearchPropertiesViewController.h
//  JazzMobile
//
//  Created by Ferat Capar on 25.03.2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JMSearchPropertiesViewController : UITableViewController <UISearchBarDelegate>
@property (strong,nonatomic) NSString *key;
@property (strong,nonatomic) NSString *type;
@property (strong,nonatomic) NSString *resource;
@property (nonatomic, retain) NSArray *searchResult;
@property (nonatomic, copy) NSString *savedSearchTerm;
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@property (nonatomic) BOOL searchWasActive;
@property (strong,nonatomic) UIViewController *viewDelegate;
@property (copy,nonatomic)  void (^dissmissBlock)(void);
@property (strong,nonatomic) NSString *projectId;
@end
