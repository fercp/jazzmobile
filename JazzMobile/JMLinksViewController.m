//
//  JMLinksViewController.m
//  JazzMobile
//
//  Created by Ferat Capar on 28.03.2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "JMLinksViewController.h"
#import "JMLink.h"
#import "DateUtil.h"
#import "RtcItem.h"
#import <MediaPlayer/MediaPlayer.h>
#import <MobileCoreServices/MobileCoreServices.h>
#import "RestClient.h"

@interface JMLinksViewController ()
@property (weak,nonatomic) NSArray *links;
@property MPMoviePlayerController *moviePlayer;
@property (strong,nonatomic) NSURL *imageURL;
@property (strong,nonatomic) NSString *imageName;
@end

@implementation JMLinksViewController
@synthesize links=_links;
@synthesize moviePlayer,imageURL,imageName;

-(void) setLinks:(NSArray *)links{
    _links=links;
    [self.tableView reloadData];
}

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void) viewWillAppear:(BOOL)animated{
    RtcItem *item=[[self parentViewController] valueForKey:@"item"];
    self.links=item.attachedLinks; 
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [self.links count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    JMLink *link=[self.links objectAtIndex:indexPath.row];
    UILabel *label=(UILabel *)[cell viewWithTag:1];
    [label setText:[NSString stringWithFormat:@"%d",link.identifier]];
    label=(UILabel *)[cell viewWithTag:2];
    [label setText:link.title];
    label=(UILabel *)[cell viewWithTag:3];
    [label setText:link.creator];
    label=(UILabel *)[cell viewWithTag:4];
    [label setText:[DateUtil formatDate:link.creationDate]];

    // Configure the cell...
    
    return cell;
}

-(NSURL*) writeFile:(NSURL *) url fileName:(NSString *) fileName{ 
    NSData *attachment=[NSData dataWithContentsOfURL:url];    
    NSString *urlString = [NSTemporaryDirectory() stringByAppendingPathComponent:fileName];
    NSURL *fileurl = [NSURL fileURLWithPath:urlString];
    [attachment writeToURL:fileurl atomically:NO]; 
    return fileurl;
}



-(NSString*) fileMIMEType:(NSURL *) file {
    CFStringRef UTI = UTTypeCreatePreferredIdentifierForTag(kUTTagClassFilenameExtension, (__bridge CFStringRef)[file pathExtension], NULL);
    CFStringRef MIMEType = UTTypeCopyPreferredTagWithClass (UTI, kUTTagClassMIMEType);
    CFRelease(UTI);
    return (__bridge NSString *)MIMEType;
}

- (void) moviePlayBackDidFinish:(NSNotification*)notification {
    MPMoviePlayerController *player = [notification object];
    [[NSNotificationCenter defaultCenter] 
     removeObserver:self
     name:MPMoviePlayerPlaybackDidFinishNotification
     object:player];
    
    if ([player
         respondsToSelector:@selector(setFullscreen:animated:)])
    {
        [player.view removeFromSuperview];
    }
    moviePlayer=nil;
}

-(void)playMovie:(NSURL *) url
{
    moviePlayer = [[MPMoviePlayerController alloc] initWithContentURL: url];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(moviePlayBackDidFinish:)
                                                 name:MPMoviePlayerPlaybackDidFinishNotification
                                               object:moviePlayer];
    
    moviePlayer.controlStyle = MPMovieControlStyleDefault;
    moviePlayer.shouldAutoplay = YES;
    [self.view addSubview:moviePlayer.view];
    [moviePlayer setFullscreen:YES animated:YES];
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    JMLink *link=[self.links objectAtIndex:indexPath.row];
    NSString *linkUrl=[NSString stringWithFormat:@"%@%@%d",[[RestClient sharedClient] baseURL],@"/service/com.ibm.team.workitem.common.internal.rest.IAttachmentRestService/itemName/com.ibm.team.workitem.Attachment/",link.identifier];
 
    NSURL *url=[NSURL URLWithString:linkUrl];
    if([link.format isEqualToString:@"video/quicktime"]){
         url=[self writeFile:url fileName:@"attachment.mov"];
        [self playMovie:url];
    }
    else if([link.format isEqualToString:@"image/jpeg"]){
        imageURL=url;
        imageName=link.title;
        [self performSegueWithIdentifier: @"showImage" sender: self];
    }
    else  {
        [ [ UIApplication sharedApplication ] openURL: url ]; 
    }
    url=nil;
    
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    UIViewController *destination = segue.destinationViewController;
    if ([destination respondsToSelector:@selector(setUrl:)]) {
        [destination setValue:imageURL forKey:@"url"];
        [destination setValue:imageName forKey:@"imageName"];
    }
}

@end
