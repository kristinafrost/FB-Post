//
//  ViewController.m
//  FB-Post
//
//  Created by Kristina Frost on 6/8/14.
//  Copyright (c) 2014 Kristina Frost. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (nonatomic,strong) UIView *commentTextview;
@property (weak, nonatomic) IBOutlet UIButton *likeButton;
- (IBAction)onLikeButton:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *commentButton;
- (IBAction)onCommentButton:(id)sender;
@property (weak, nonatomic) IBOutlet UIView *inlineActionsBar;
@property (weak, nonatomic) IBOutlet UIButton *shareButton;
- (IBAction)onShareButton:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *likeCount;
@property (strong, nonatomic) IBOutlet UITapGestureRecognizer *tapRecognizer;
- (IBAction)endTap:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *linkButton;
- (IBAction)onLink:(id)sender;



- (void)willShowKeyboard:(NSNotification *)notification;
- (void)willHideKeyboard:(NSNotification *)notification;

@end

@implementation ViewController

- (NSString *)styledHTMLwithHTML:(NSString *)HTML {
    NSString *style = @"<meta charset=\"UTF-8\"><style> body { font-family: 'HelveticaNeue'; font-size: 15px; } b {font-family: 'HelveticaNeue'; } a { COLOR: #4072FF; font-family: 'HelveticaNeue'; font-size: 12px;}</style>";
    
    return [NSString stringWithFormat:@"%@%@", style, HTML];
}

- (NSString *)styledHTMLwithHTML2:(NSString *)HTML {
    NSString *style = @"<meta charset=\"UTF-8\"><style> body { COLOR: #a8a8a8; font-family: 'HelveticaNeue'; font-size: 13px; } b {font-family: 'HelveticaNeue'; }</style>";
    
    return [NSString stringWithFormat:@"%@%@", style, HTML];
}

- (NSString *)styledHTMLwithHTML3:(NSString *)HTML {
    NSString *style = @"<meta charset=\"UTF-8\"><style> body { font-family: 'HelveticaNeue'; font-size: 14px; } b {font-family: 'HelveticaNeue'; } a { COLOR: #546893; font-family: 'HelveticaNeue'; font-size: 14px;}</style>";
    
    return [NSString stringWithFormat:@"%@%@", style, HTML];
}

- (NSString *)styledHTMLwithHTML4:(NSString *)HTML {
    NSString *style = @"<meta charset=\"UTF-8\"><style> body { font-family: 'HelveticaNeue'; font-size: 12px; } b {font-family: 'HelveticaNeue'; } a { COLOR: #4072FF; font-family: 'HelveticaNeue'; font-size: 14px;}</style>";
    
    return [NSString stringWithFormat:@"%@%@", style, HTML];
}

- (NSAttributedString *)attributedStringWithHTML:(NSString *)HTML {
    NSDictionary *options = @{ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType };
    return [[NSAttributedString alloc] initWithData:[HTML dataUsingEncoding:NSUTF8StringEncoding] options:options documentAttributes:NULL error:NULL];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Register the methods for the keyboard hide/show events
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(willShowKeyboard:) name:UIKeyboardWillShowNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(willHideKeyboard:) name:UIKeyboardWillHideNotification object:nil];
    }
    return self;
}

- (IBAction)onLikeButton:(id)sender {
        UIButton *button = (UIButton*)sender;
        button.selected = !button.isSelected;
    }

- (IBAction)onCommentButton:(id)sender {
    UIButton *button = (UIButton*)sender;
    button.selected = !button.isSelected;
}

- (IBAction)onShareButton:(id)sender {
    UIButton *button = (UIButton*)sender;
    button.selected = !button.isSelected;
}


- (IBAction)endTap:(id)sender {
    [self.view endEditing:YES];
}


- (IBAction)onLink:(id)sender {
    NSLog(@"You pressed the link");
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString: @"http://bit.ly/1jV9zM8"]];
}

- (void)willShowKeyboard:(NSNotification *)notification {
    NSDictionary *userInfo = [notification userInfo];
    
//     [self.view addGestureRecognizer:self.tapRecognizer];
    
    // Get the keyboard height and width from the notification
    // Size varies depending on OS, language, orientation
    CGSize kbSize = [[userInfo objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    NSLog(@"Height: %f Width: %f", kbSize.height, kbSize.width);
    
    // Get the animation duration and curve from the notification
    NSNumber *durationValue = userInfo[UIKeyboardAnimationDurationUserInfoKey];
    NSTimeInterval animationDuration = durationValue.doubleValue;
    NSNumber *curveValue = userInfo[UIKeyboardAnimationCurveUserInfoKey];
    UIViewAnimationCurve animationCurve = curveValue.intValue;
    
    // Move the view with the same duration and animation curve so that it will match with the keyboard animation
    [UIView animateWithDuration:animationDuration
                          delay:0.0
                        options:(animationCurve << 16)
                     animations:^{
                         self.commentTextview.frame = CGRectMake(0, self.view.frame.size.height - kbSize.height - self.commentTextview.frame.size.height, self.commentTextview.frame.size.width, self.commentTextview.frame.size.height);
                     }
                     completion:nil];
}

 - (void)willHideKeyboard:(NSNotification *)notification {
    NSLog(@"Hiding keyboard");
    NSDictionary *userInfo = [notification userInfo];
     
//     [self.view removeGestureRecognizer:self.tapRecognizer];
    
    // Get the animation duration and curve from the notification
    NSNumber *durationValue = userInfo[UIKeyboardAnimationDurationUserInfoKey];
    NSTimeInterval animationDuration = durationValue.doubleValue;
    NSNumber *curveValue = userInfo[UIKeyboardAnimationCurveUserInfoKey];
    UIViewAnimationCurve animationCurve = curveValue.intValue;
    
    // Move the view with the same duration and animation curve so that it will match with the keyboard animation
    [UIView animateWithDuration:animationDuration
                          delay:0.0
                        options:(animationCurve << 16)
                     animations:^{
                         self.commentTextview.frame = CGRectMake(0, self.view.frame.size.height - self.commentTextview.frame.size.height - 44.5, self.commentTextview.frame.size.width, self.commentTextview.frame.size.height);
                     }
                     completion:nil];


}

-(void)didTapAnywhere: (UITapGestureRecognizer*) recognizer {
    [self.commentTextview resignFirstResponder];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.

    
    self.view.backgroundColor=[UIColor colorWithRed:0.909 green:0.913 blue:0.921 alpha:1.0];

    
    //post background
    CGRect postFrame = CGRectMake(10, 75, 300, 500);
    CGRect postContainerFrame = CGRectMake(10, 40, 300, 80);
    UIView *postView = [[UIView alloc] initWithFrame:postFrame];
    postView.backgroundColor = [UIColor whiteColor];
    postView.layer.borderWidth = 0.5;
    postView.layer.borderColor = [UIColor colorWithRed:0.98 green:0.98 blue:0.98 alpha:1.0].CGColor;
    postView.layer.cornerRadius = 2;
    postView.layer.shadowColor = [UIColor lightGrayColor].CGColor;
    postView.layer.shadowOffset = CGSizeMake(1, 1);
    postView.layer.shadowOpacity = 0.2;
    postView.layer.shadowRadius = 3;
    
    
    //post image
    UIView *postContainerview = [[UIView alloc] initWithFrame:postContainerFrame];
    UIImage *postImage = [UIImage imageNamed:@"HerImage"];
    UIImageView *postImageView = [[UIImageView alloc] initWithFrame:postFrame];
    postImageView.image = postImage;
    [postImageView setContentMode:UIViewContentModeCenter];
    [postImageView setFrame:CGRectMake(10, 55, postImageView.frame.size.width, postImageView.frame.size.height)];
//    postImageView.layer.cornerRadius = 2;
//    postImageView.layer.shadowColor = [UIColor lightGrayColor].CGColor;
//    postImageView.layer.shadowOffset = CGSizeMake(1, 1);
//    postImageView.layer.shadowOpacity = 0.2;
    
    [postContainerview addSubview:postImageView];

    
    //user icon
    CGRect iconFrame = CGRectMake(15, 85, 320, 45);
    CGRect iconContainerFrame = CGRectMake(10, 40, 300, 80);
    UIView *iconContainerview = [[UIView alloc] initWithFrame:iconContainerFrame];
    UIImage *iconImage = [UIImage imageNamed:@"hericon2"];
    UIImageView *iconImageView = [[UIImageView alloc] initWithFrame:iconFrame];
    iconImageView.image = iconImage;
    [iconImageView setContentMode:UIViewContentModeCenter];
    [iconImageView setFrame:CGRectMake(-120, 82, iconImageView.frame.size.width, iconImageView.frame.size.height)];
    
    [iconContainerview addSubview:iconImageView];
    
    
    //user name text
    NSString *html = @"<b>Her</b>";
    
    // Apply some inline CSS
    NSString *styledHtml = [self styledHTMLwithHTML:html];
    
    // Generate an attributed string from the HTML
    NSAttributedString *attributedText = [self attributedStringWithHTML:styledHtml];
    
    UILabel *postText = [[UILabel alloc] initWithFrame:CGRectMake(65, 75, postFrame.size.width, 40)];
    postText.attributedText = attributedText;
    
    [postContainerview addSubview:postText];
  
    [postView addSubview:postText];
    
    
    
    //timestamp text
    NSString *html2 = @"February 1 at 11:00 AM";
    
    // Apply some inline CSS
    NSString *styledHtml2 = [self styledHTMLwithHTML2:html2];
    
    // Generate an attributed string from the HTML
    NSAttributedString *attributedText2 = [self attributedStringWithHTML:styledHtml2];
    
    UILabel *postText2 = [[UILabel alloc] initWithFrame:CGRectMake(56, 20, postFrame.size.width, 40)];
    postText2.attributedText = attributedText2;
    
    [postContainerview addSubview:postText2];
    
    [postView addSubview:postText2];
    
    
    
    //Content text
    NSString *html3 = @"<html><body>From collarless shirts to high-wasted pants,<br/><b>#Her</b>'s costume designer, Casey Storm,<br/> explains how he created his fashion looks<br/>for the future: <a>http://bit.ly/1jV9zM8</a></body></html>";
    
    // Apply some inline CSS
    NSString *styledHtml3 = [self styledHTMLwithHTML3:html3];
    
    // Generate an attributed string from the HTML
    NSAttributedString *attributedText3 = [self attributedStringWithHTML:styledHtml3];
    
    UILabel *postText3 = [[UILabel alloc] initWithFrame:CGRectMake(10, 60, 600, 70)];
    postText3.attributedText = attributedText3;
    postText3.numberOfLines = 4;
    
    [postContainerview addSubview:postText3];
    
    [postView addSubview:postText3];
    
    //Comment text field
    CGSize textFieldSize = CGSizeMake(320,44.5);
    
    UITextField *tf = [[UITextField alloc] initWithFrame:CGRectMake(0, 0, textFieldSize.width, 44.5)];
    tf.textColor = [UIColor blackColor];
    tf.font = [UIFont fontWithName:@"HelveticaNeue" size:15];
    tf.backgroundColor=[UIColor clearColor];
    tf.text=@"      ";
    
    tf.background = [UIImage imageNamed:@"commentbar_blank"];
    self.commentTextview = [[UIView alloc] initWithFrame:CGRectMake(0, 479, 320, 44.5)];
    self.commentTextview.backgroundColor = [UIColor clearColor];
    
    [self.commentTextview setContentMode:UIViewContentModeCenter];
    
    [self.commentTextview addSubview:tf];
    
    
    //navigation bar
    CGRect navBarFrame = CGRectMake(0, 9.5, 320, 45);
    CGRect navBarContainerFrame = CGRectMake(10, 40, 300, 80);
    
    UIView *navBarContainerview = [[UIView alloc] initWithFrame:navBarContainerFrame];
    UIImage *navBarImage = [UIImage imageNamed:@"navbar"];
    UIImageView *navBarImageView = [[UIImageView alloc] initWithFrame:navBarFrame];
    navBarImageView.image = navBarImage;
    [navBarImageView setContentMode:UIViewContentModeCenter];
    
    [navBarContainerview addSubview:navBarImageView];
    
    
    //tab bar
    CGRect tabBarFrame = CGRectMake(0, 523, 320, 45);
    CGRect tabBarContainerFrame = CGRectMake(10, 40, 300, 80);
    
    UIView *tabBarContainerview = [[UIView alloc] initWithFrame:tabBarContainerFrame];
    UIImage *tabBarImage = [UIImage imageNamed:@"tabbar"];
    UIImageView *tabBarImageView = [[UIImageView alloc] initWithFrame:tabBarFrame];
    tabBarImageView.image = tabBarImage;
    [tabBarImageView setContentMode:UIViewContentModeCenter];
    
    [tabBarContainerview addSubview:tabBarImageView];


    
    [self.view addSubview:postView];
    [self.view addSubview:postImageView];
    [self.view addSubview:navBarImageView];
    [self.view addSubview:tabBarImageView];
    [self.view addSubview:iconImageView];
    [self.view addSubview:postText];
    [self.view addSubview:self.commentTextview];
      [self.view bringSubviewToFront:self.inlineActionsBar];
    [self.view bringSubviewToFront:self.likeButton];
    [self.view bringSubviewToFront:self.commentButton];
    [self.view bringSubviewToFront:self.shareButton];
    [self.view bringSubviewToFront:self.likeCount];
    [self.view bringSubviewToFront:self.linkButton];
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
