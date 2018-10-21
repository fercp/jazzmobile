//
//  JMEditPropertiesViewController.m
//  JazzMobile
//
//  Created by Ferat Capar on 26.03.2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "JMEditPropertiesViewController.h"
#import "JMWorkItemModifierDelegate.h"
#import <MobileCoreServices/UTCoreTypes.h>
#import "RestClient.h"
#import "JMImagePostDelegate.h"
#import "JMLink.h"

@interface JMEditPropertiesViewController ()
@property (strong,nonatomic) JMWorkItemModifierDelegate *delegate;
@property  BOOL saveComment;
@property (strong,nonatomic) JMImagePostDelegate *imageDelegate;
@property (strong,nonatomic) JMLink *attachment;
@property (strong,nonatomic) NSMutableArray *attachedLinks;
@end

@implementation JMEditPropertiesViewController
@synthesize hideButton;
@synthesize commentText;
@synthesize attachment=_attachment;
@synthesize comment,saveComment,attachedLinks;



@synthesize projectId,item,delegate,dissmissBlock,imageDelegate;

-(void)setAttachment:(JMLink *)attachment{
    _attachment=attachment;
    [self.attachedLinks addObject:attachment];
    [self dismissModalViewControllerAnimated: YES];
}

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void) setResult:(NSArray *)result{
    if(saveComment){
        if(comment.text!=nil&&![comment.text isEqualToString:@""]){
        Comment *commentObj=[[Comment alloc] init];
        commentObj.description=comment.text;
        saveComment=NO;
            [delegate saveComment:commentObj ofId:self.item.identifier];
        }else {
            [self dismissViewControllerAnimated:YES completion:dissmissBlock];
        }
    }else{
        [self dismissViewControllerAnimated:YES completion:dissmissBlock];
    }
}

-(void) viewWillDisappear:(BOOL)animated{
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    saveComment=YES;
    attachedLinks=[item.attachedLinks mutableCopy];
    if(attachedLinks==nil)
       attachedLinks=[[NSMutableArray alloc] init];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)viewDidUnload
{
    [self setComment:nil];
    [self setCommentText:nil];
    [self setHideButton:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row==0)
      cell.detailTextLabel.text=item.owner.title;
    else if(indexPath.row==1)
        cell.detailTextLabel.text=item.state.title;
    else if(indexPath.row==2)
        cell.detailTextLabel.text=item.severity.title;
    else
        cell.detailTextLabel.text=item.priority.title;


}



- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    UIViewController *destination = segue.destinationViewController;
    NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
    NSString *key,*type,*resource,*title;
    if(indexPath.row==0){
        type=@"item.owner.title";
        key=@"item.owner.resource";
        title=@"Owner";
        resource=item.owner.resource;
    }
    else if(indexPath.row==1){
        type=@"item.state.title";
        key=@"item.state.resource";
        title=@"Actions";
        resource=[item.state.resource stringByReplacingOccurrencesOfString:@"states" withString:@"actions"];
    }
    else if(indexPath.row==2){
        type=@"item.severity.title";
        key=@"item.severity.resource";
        title=@"Severity";
        resource=item.severity.resource;
    }
    else{
        type=@"item.priority.title";
        key=@"item.priority.resource";
        title=@"Priority";
        resource=item.priority.resource;
    }
    
    NSURL *url=[[NSURL alloc] initWithString:resource];
    url=[url URLByDeletingLastPathComponent];
    [destination setValue:key forKey:@"key"];
    [destination setValue:type forKey:@"type"];
    [destination setValue:self forKey:@"viewDelegate"];
    [destination setValue:^{[self.tableView reloadData];} forKey:@"dissmissBlock"];
    [destination setValue:projectId forKey:@"projectId"];
    [destination setValue:[url absoluteString] forKey:@"resource"];
    [destination setValue:title forKey:@"title"];
    url=nil;
}


- (IBAction)saveClicked:(id)sender {
    delegate=[[JMWorkItemModifierDelegate alloc] initWithController:self];
    JMWorkItemModifier *saveItem=[[JMWorkItemModifier alloc] init];
    JMResourceRepresentation *resource=[[JMResourceRepresentation alloc] init];
    resource.value=item.owner.resource;
    saveItem.owner=resource;
    resource=[[JMResourceRepresentation alloc] init];
    resource.value=item.state.resource;
    saveItem.state=resource;
    resource=[[JMResourceRepresentation alloc] init];
    resource.value=item.severity.resource;
    saveItem.severity=resource;
    resource=[[JMResourceRepresentation alloc] init];
    resource.value=item.priority.resource;
    saveItem.priority=resource;
    saveItem.attachedLinks=attachedLinks;
    [delegate saveItem:saveItem ofId:self.item.identifier];
}

- (void)textViewDidBeginEditing:(UITextView *)textView{
    [hideButton setHidden:NO];    
}

- (IBAction)doneClicked:(id)sender {
  [self dismissViewControllerAnimated:YES completion:nil];
}
- (IBAction)hideKeyboard:(id)sender {
    [hideButton setHidden:YES];
    [self.commentText resignFirstResponder];
}

-(void) takePhoto:(UIImagePickerControllerSourceType) type{
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
    imagePicker.sourceType =  type;
    // uncomment for front camera
    if(type==UIImagePickerControllerSourceTypeCamera){
    imagePicker.cameraDevice = UIImagePickerControllerCameraDeviceRear; 
    imagePicker.mediaTypes =
        [UIImagePickerController availableMediaTypesForSourceType: UIImagePickerControllerCameraDeviceRear];
        imagePicker.showsCameraControls = YES;
    }
    // imagePicker.cameraDevice = UIImagePickerControllerCameraCaptureModeVideo;
    
    imagePicker.toolbarHidden = YES;
    imagePicker.navigationBarHidden = YES;
    imagePicker.wantsFullScreenLayout = YES;
    imagePicker.delegate = self;
  
    [self presentModalViewController:imagePicker animated:YES];
}

- (IBAction)attachPhoto:(id)sender {
    [self takePhoto:UIImagePickerControllerSourceTypeCamera];
}


- (IBAction)chooseFromAlbum:(id)sender {
    [self takePhoto:UIImagePickerControllerSourceTypePhotoLibrary];
}

- (void) imagePickerControllerDidCancel: (UIImagePickerController *) picker {
    
    [self dismissModalViewControllerAnimated: YES];

}

// For responding to the user accepting a newly-captured picture or movie
- (void) imagePickerController: (UIImagePickerController *) picker
 didFinishPickingMediaWithInfo: (NSDictionary *) info {
    imageDelegate=[[JMImagePostDelegate alloc] initWithController:self.modalViewController]; 
    NSString *mediaType = [info objectForKey: UIImagePickerControllerMediaType];
    UIImage *image;
    
    // Handle a still image capture
    if (CFStringCompare ((__bridge CFStringRef) mediaType, kUTTypeImage, 0)
        == kCFCompareEqualTo) {
        
        image = (UIImage *) [info objectForKey:
                                     UIImagePickerControllerOriginalImage];
        [imageDelegate putImage:image projectId:projectId];
        // Save the new image (original or edited) to the Camera Roll
        if(picker.sourceType != UIImagePickerControllerSourceTypePhotoLibrary)
            UIImageWriteToSavedPhotosAlbum (image, nil, nil , nil);
        image=nil;
    }
    
    // Handle a movie capture
    if (CFStringCompare ((__bridge CFStringRef) mediaType, kUTTypeMovie, 0)
        == kCFCompareEqualTo) {
        
        NSString *moviePath = [[info objectForKey:
                                UIImagePickerControllerMediaURL] path];
 
        NSData *movie=[NSData dataWithContentsOfFile:moviePath];
        [imageDelegate putMovie:movie projectId:projectId];
        if (picker.sourceType != UIImagePickerControllerSourceTypePhotoLibrary &&UIVideoAtPathIsCompatibleWithSavedPhotosAlbum (moviePath)) {
            UISaveVideoAtPathToSavedPhotosAlbum (
                                                 moviePath, nil, nil, nil);
        }
    }
    
  //  [self dismissModalViewControllerAnimated: YES];

}
@end
