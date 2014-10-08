//
//  ContentViewHelper.m
//  WordOfMouthEngine
//
//  Created by Bijit Halder on 2/15/14.
//  Copyright (c) 2014 Bijit Halder. All rights reserved.
//

#import "ContentViewHelper.h"
#import "ApiContent.h"
#import "UIImageView+AnimationCompletion.h"

@implementation ContentViewHelper



#pragma mark -  View Helper Methods: Views
+ (void)setView:(UIView *)view{
    // set app defaults
    [AppUIManager setUIView:view ofType:kAUCPriorityTypePrimary];
    // view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:[CommonUtility adjustImageFileName:kAUCContentBackgroundImage]]];
    view.backgroundColor = [UIColor whiteColor];
}
+ (UIImageView *)getContentBackGroundView{
    UIImageView *contentBackGround = [[UIImageView alloc] init];
    //contentBackGround.backgroundColor =[AppUIManager getContentColorForCategory:1];
    contentBackGround.backgroundColor =[UIColor whiteColor];
    contentBackGround.contentMode = UIViewContentModeScaleAspectFill;
    [contentBackGround setTranslatesAutoresizingMaskIntoConstraints:NO];
    
    //    [contentBackGround setAccessibilityIdentifier:@"Content Image"];
    //    [contentBackGround setIsAccessibilityElement:YES];
    
    return contentBackGround;
}
+ (UIImage *)getImageForContentBackGroudView{
    NSString *fileName =[[@"bg" stringByAppendingFormat:@"%d",[CommonUtility pickRandom:4]+1] stringByAppendingString:@".jpg"];
    return [UIImage imageNamed:fileName];
}
+ (void)updateContentBackGroundView:(UIView *)view forCategory:(kAPIContentCategory)category{
    //view.backgroundColor = [AppUIManager getContentColorForCategory:category];
}
+ (void)setSignInAndOutView:(UIView *)view{
    // set app defaults
    [AppUIManager setUIView:view ofType:kAUCPriorityTypePrimary];
    view.backgroundColor = [UIColor clearColor];
    //view.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.4];
    // add gradient
    NSArray *colors = @[(id)[UIColor colorWithWhite:0.0 alpha:0.0].CGColor,
                        (id)[UIColor colorWithWhite:0.0 alpha:0.4].CGColor,
                        (id)[UIColor colorWithWhite:0.0 alpha:0.6].CGColor];
    [AppUIManager addColorGradient:colors toView:view];
}

+ (void)setAnimationView:(UIView *)view withSpead:(UIImageView *)spreadView andKill:(UIImageView *)killView{
    [view setTranslatesAutoresizingMaskIntoConstraints:NO];
    [spreadView setTranslatesAutoresizingMaskIntoConstraints:NO];
    [killView setTranslatesAutoresizingMaskIntoConstraints:NO];
    
    view.hidden=YES;
    spreadView.hidden=YES;
    killView.hidden=YES;
    
    view.backgroundColor =[UIColor clearColor];
    spreadView.backgroundColor =[UIColor clearColor];
    killView.backgroundColor =[UIColor clearColor];
    [view addSubview:spreadView];
    [view addSubview:killView];
    
    // set images
    spreadView.animationDuration=0.6;
    spreadView.animationRepeatCount=1.0;
    spreadView.animationImages=[AppAnimationManager getSpreadAnimationImages];
    killView.animationDuration=spreadView.animationDuration;
    killView.animationRepeatCount=1.0;
    killView.animationImages=[AppAnimationManager getKillAnimationImages];
}
#pragma mark - View Helper Methods: Image Views
+ (UIImageView *)getUserImageView{
    UIImageView *iv =[[UIImageView alloc] init];
    // set app defaults
    [AppUIManager setImageView:iv];
    
    return iv;
}

+ (UIImageView *)getPageLogoImageView{
    UIImageView *iv =[[UIImageView alloc] init];
    // set app defaults
    [AppUIManager setImageView:iv];
    iv.image = [UIImage imageNamed:kAUCPageLogoImage];
    return iv;
}
#pragma mark -  View Helper Methods: TextViews
+ (UITextView *)getContentTextViewWithDelegate:(id)delegate{
    UITextView *textView =[[UITextView alloc] init];
    // set app defaults
    [AppUIManager setTextView:textView ofType:kAUCPriorityTypePrimary];
    
    // set custom textview properties
    //textView.frame = [CommonUtility shrinkRect:kSIVNameFrame byXPoints:10 yPoints:40];  //kSIVNameFrame;
    textView.backgroundColor = [UIColor clearColor];
    //textView.backgroundColor = [UIColor  colorWithWhite:1.0 alpha:.8];
    
    //textView.backgroundColor = [UIColor lightGrayColor];
    // textView.text=@"";
    //textView.attributedText =
    textView.font = [UIFont fontWithName:kAUCFontFamilyPrimary size:kAUCFontSizeTertiary];
    //textView.textColor =[UIColor whiteColor];//[UIColor colorWithHue:kCRDPrimaryHue saturation:0.0 brightness:1.0 alpha:1.0];
    textView.editable = NO;
    textView.selectable = YES;
    textView.allowsEditingTextAttributes = NO;
    textView.scrollEnabled = NO;
    //textView.dataDetectorTypes = UIDataDetectorTypeAll ;
    //textView.textAlignment = NSTextAlignmentCenter;
    //textView.typingAttributes =
    // textView.linkTextAttributes =
    //textView.textContainerInset =
    
    // text shadow: use layer property (UIView)
    //textView.layer.shadowColor = [HEXCOLOR (kCRDShadowWhiteColor) CGColor];
    //textView.layer.shadowColor = [HEXCOLOR (kCRDTextDropShadowColor) CGColor];
    // textView.layer.shadowOffset = CGSizeMake(1.0f, 1.0f);
    // textView.layer.shadowOpacity = 0.6f;
    // textView.layer.shadowRadius = 0.0f;
    
    // set up key board
    //textView.returnKeyType = UIReturnKeyDone;
    textView.keyboardType = UIKeyboardTypeASCIICapable;
    
    textView.delegate=delegate;
    
    [textView setAccessibilityIdentifier:@"Content Text"];
    return textView;
}

+ (NSAttributedString *)getAttributedText:(NSString *)text{
    NSMutableParagraphStyle *paraStyle = [NSMutableParagraphStyle new];
    paraStyle.lineBreakMode = NSLineBreakByWordWrapping;
    paraStyle.alignment = NSTextAlignmentCenter;
    paraStyle.lineSpacing = -kAUCFontSizeContentText/2.0 + 9.0;
    
    NSShadow *shadow = [[NSShadow alloc] init];
    shadow.shadowOffset = CGSizeMake(0.0,1.0);
    shadow.shadowBlurRadius = (CGFloat) 4.0;
    shadow.shadowColor = [UIColor colorWithWhite:0.1 alpha:1.0];
    
    NSMutableAttributedString *atext =[[NSMutableAttributedString alloc]
                                       initWithString:text
                                       attributes:@{
                                                    NSFontAttributeName: [UIFont fontWithName:kAUCFontFamilySecondary size:kAUCFontSizeContentText],
                                                    NSForegroundColorAttributeName:[UIColor whiteColor],
                                                    NSParagraphStyleAttributeName:paraStyle,
                                                    NSStrokeColorAttributeName: [AppUIManager getColorOfType:kAUCColorTypeTextStroke],//[UIColor blackColor],
                                                    //NSStrokeWidthAttributeName:@-3.0,
                                                    NSShadowAttributeName:shadow
                                                    // NSKernAttributeName:@1.0 // inter letter spacing
                                                    }];
    
    return atext;
}

#pragma mark -  View Helper Methods: Buttons
+ (UIButton *)getSpreadButton{
    //return [AppUIManager setButtonWithTitle:@"spread" ofType:kAUCPriorityTypeTertiary];
    UIButton *button =  [AppUIManager getTransparentUIButton];
    [button setImage:[UIImage imageNamed:kAUCSpreadButtonImage] forState:UIControlStateNormal];
    [button setAccessibilityIdentifier:@"Spread"];
    return button;
    
}
+ (UIButton *)getKillButton{
    //UIButton *button  = [AppUIManager setButtonWithTitle:@"kill" ofType:kAUCPriorityTypeTertiary];
    //UIButton *button  = [AppUIManager setButtonWithTitle:@"kill" andColor:[UIColor redColor]];
    
    UIButton *button =  [AppUIManager getTransparentUIButton];
    [button setImage:[UIImage imageNamed:kAUCKillButtonImage] forState:UIControlStateNormal];
    [button setAccessibilityIdentifier:@"Kill"];
    return button;
}

+ (UIButton *)getComposeButton{
    //UIButton *button  = [AppUIManager setButtonWithTitle:@"kill" ofType:kAUCPriorityTypeTertiary];
    //UIButton *button  = [AppUIManager setButtonWithTitle:@"kill" andColor:[UIColor redColor]];
    
    UIButton *button =  [AppUIManager getTransparentUIButton];
    [button setImage:[UIImage imageNamed:kAUCComposeButtonImage] forState:UIControlStateNormal];
    [button setAccessibilityIdentifier:@"Compose"];
    return button;
}



+ (UIButton *)getPageLogoButton{
    //UIButton *button  = [AppUIManager setButtonWithTitle:@"kill" ofType:kAUCPriorityTypeTertiary];
    //UIButton *button  = [AppUIManager setButtonWithTitle:@"kill" andColor:[UIColor redColor]];
    
    UIButton *button =  [AppUIManager getTransparentUIButton];
    [button setImage:[UIImage imageNamed:kAUCPageLogoImage] forState:UIControlStateNormal];
    //[button.titleLabel setFont:[UIFont fontWithName:kAUCFontFamilySecondary  size:kAUCFontSizeSecondary]];
    //button.backgroundColor = [CommonUtility getColorFromHSBACVec:kAUCColorLightTeal];
    //[button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    //[button setTitle:@"Signin" forState:UIControlStateNormal];
    [button setAccessibilityIdentifier:@"PageLogoButton"];
    return button;
}
+ (UIButton *)getSignInOutButton{
    //UIButton *button  = [AppUIManager setButtonWithTitle:@"kill" ofType:kAUCPriorityTypeTertiary];
    //UIButton *button  = [AppUIManager setButtonWithTitle:@"kill" andColor:[UIColor redColor]];
    
    UIButton *button =  [AppUIManager getTransparentUIButton];
    [button setImage:[UIImage imageNamed:kAUCSignOutButtonImage] forState:UIControlStateNormal];
    //[button.titleLabel setFont:[UIFont fontWithName:kAUCFontFamilySecondary  size:kAUCFontSizeSecondary]];
    //button.backgroundColor = [CommonUtility getColorFromHSBACVec:kAUCColorLightTeal];
    //[button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    //[button setTitle:@"Signin" forState:UIControlStateNormal];
    [button setAccessibilityIdentifier:@"SignInAndOutButton"];
    return button;
}
+ (UIButton *)getDismissButton{
    UIButton *button =  [AppUIManager getTransparentUIButton];
    [button setAccessibilityIdentifier:@"DismissButton"];
    return button;
}




#pragma mark - Text label mathods
//+ (UILabel *)getTextLabelForSpreadCount{
//    UILabel *textLabel= [[UILabel alloc] init];
//    // set app defaults
//    [AppUIManager setUILabel:textLabel ofType:kAUCPriorityTypePrimary];
//
//    return textLabel;
//}
//+ (UILabel *)getTextLabelForTimeCount{
//    UILabel *textLabel= [[UILabel alloc] init];
//    // set app defaults
//    [AppUIManager setUILabel:textLabel ofType:kAUCPriorityTypeSecondary];
//
//    return textLabel;
//}

#pragma mark -  View Helper Methods: ProgressViewb
+ (CVCircleCounterView *)getCounterViewWithDelegate:(id)delegate{
    CVCircleCounterView *circleView = [[CVCircleCounterView alloc] init];
    circleView.delegate = delegate;
    
    // custom look
    circleView.numberColor = [AppUIManager getColorOfType:kAUCColorTypePrimary]; //< Black, By Default
    circleView.numberFont = [UIFont fontWithName:kAUCFontFamilyPrimary size:kAUCFontSizePrimary]; //< Courier-Bold 20, By Default
    
    circleView.circleColor = [AppUIManager getColorOfType:kAUCColorTypePrimary]; //< Black, By Default
    circleView.circleDoneColor = [UIColor redColor]; //< Black, By Default
    circleView.circleBorderWidth = 1.0; //< 6 pixels, By Default
    circleView.circleTimeInterval = kAUCAppContentTimerMax;
    circleView.backgroundColor =[UIColor clearColor];
    
    //circleView.circleIncre=YES;
    
    // Auto layout
    [circleView setTranslatesAutoresizingMaskIntoConstraints:NO];
    
    return circleView;
}

#pragma mark - Animation
+ (void)animateViewsForContentDisplay:(NSArray *)views withFinalAction:(void (^)())action{
    // skip animation if number of views do not match
    if([views count]<5){
        if(action){
            action();
        }
    }
    // set up animation
    
    UIView *view1 = ((UIView *)views[0]);
    UIView *view2 = ((UIView *)views[1]);
    UIView *view3 = ((UIView *)views[2]);
    UIView *view4 = ((UIView *)views[3]);
    UIView *view5 = ((UIView *)views[4]);
    // fade in
    view1.alpha =0.0;
    view2.alpha =0.0;
    
    // slide
    float screenH=[CommonUtility getScreenHeight];
    CGPoint final3 = view3.center;
    CGPoint start3 = final3;
    start3.y=screenH+view3.frame.size.height;
    CGPoint final4 = view4.center;
    CGPoint start4 = final4;
    start4.y=screenH+view4.frame.size.height;
    CGPoint final5 = view5.center;
    CGPoint start5 = final5;
    start5.y=screenH+view5.frame.size.height;
    view3.center = start3;
    view4.center = start4;
    view5.center = start5;
    
    // unhide all
    view1.hidden=NO;
    view2.hidden=NO;
    view3.hidden=NO;
    view4.hidden=NO;
    view5.hidden=NO;
    
    [UIView animateWithDuration:0.4
                          delay:0.0
                        options:UIViewAnimationOptionCurveLinear
                     animations:^{
                         // fade in views
                         view1.alpha =1.0;
                         view2.alpha =1.0;
                         
                         // slide in buttons
                         view3.center = final3;
                         view4.center = final4;
                         view5.center = final5;
                     }
                     completion:^(BOOL finished){
                         if(action){
                             action();
                         }
                     }];
    
    
}
+ (void)animateViews:(NSArray *)views forUserResponse:(BOOL)response withFinalAction:(void (^)())action{
    // skip animation if number of views do not match
    if([views count]<7){
        if(action){
            action();
        }
    }
    // set up animation
    UIView *view1 = ((UIView *)views[0]);
    UIView *view2 = ((UIView *)views[1]);
    UIView *view3 = ((UIView *)views[2]);
    UIView *view4 = ((UIView *)views[3]);
    UIView *view5 = ((UIView *)views[4]);
    UIView *view6 = ((UIView *)views[5]);
    UIImageView *view7 = response?(UIImageView *)views[6]:(UIImageView *)views[7];
    view6.backgroundColor =response?[AppUIManager getColorOfType:kAUCColorTypePrimary]:[UIColor clearColor];
    view6.hidden=NO;
    view7.hidden=YES;
    
    // slide
    float screenH=[CommonUtility getScreenHeight];
    float screenW=[CommonUtility getScreenWidth];
    int slideX = response?(screenW+view1.frame.size.width):(-view1.frame.size.width);
    //int slideDir =response?1:-1;
    
    
    CGPoint final1 = view1.center;
    CGPoint start1 = final1;
    //start1.x=slideX+slideDir*view1.frame.size.width;
    start1.x = slideX;
    CGPoint final2 = view2.center;
    CGPoint start2 = final2;
    //start2.x=slideX+slideDir*view2.frame.size.width;
    start2.x = slideX;
    
    CGPoint final3 = view3.center;
    CGPoint start3 = final3;
    start3.y=screenH+view3.frame.size.height;
    CGPoint final4 = view4.center;
    CGPoint start4 = final4;
    start4.y=screenH+view4.frame.size.height;
    CGPoint final5 = view5.center;
    CGPoint start5 = final5;
    start5.y=screenH+view5.frame.size.height;
    
    [UIView animateWithDuration:0.3
                          delay:0.0
                        options:UIViewAnimationOptionCurveLinear
                     animations:^{
                         // fade in views
                         view1.center = start1;
                         view2.center = start2;
                         
                         // slide in buttons
                         view3.center = start3;
                         view4.center = start4;
                         view5.center = start5;
                     }
                     completion:^(BOOL finished){
                         
                         // hide all
                         view1.hidden=YES;
                         view2.hidden=YES;
                         view3.hidden=YES;
                         view4.hidden=YES;
                         view5.hidden=YES;
                         // bring them back
                         view1.center = final1;
                         view2.center = final2;
                         
                         // slide in buttons
                         view3.center = final3;
                         view4.center = final4;
                         view5.center = final5;
                         
                         // perform spread or kill animation
                         view6.hidden=NO;
                         view7.hidden=NO;
                         [view7  startAnimatingWithCompletionBlock:^(BOOL success) {
                             view6.hidden=YES;
                             view7.hidden=YES;
                             if(action){
                                 action();
                             }
                         } ];
                         
                     }];
}
//+ (void)animateButtonWithSlideUpAndReturn:(UIButton *)button  withFinalAction:(void (^)())action{
//    //NSLog(@"UP called: %f", button.center.y);
//    float durantion1 = 0.3;
//    float durantion2 = 0.3;
//    CGPoint final = button.center;
//    CGPoint middle =final;
//    middle.y = middle.y-60;
//
//    [AppAnimationManager slideView:(UIView *)button
//                      fromLocation:final
//                           through:middle
//                          duration:durantion1
//                                to:final
//                          duration:durantion2
//                   withFinalAction:action];
//
//}
//+ (void)animateButtonWithSlideFromDown:(UIButton *)button   withFinalAction:(void (^)())action{
//    //NSLog(@"Down with us called: %f", button.center.y);
//    float durantion =0.4;
//    CGPoint final = button.center;
//    CGPoint start = final;
//    start.y=[CommonUtility getScreenHeight]+button.frame.size.height;
//
//    [AppAnimationManager slideView:(UIView *)button
//                      fromLocation:start
//                                to:final
//                       andDuration:durantion
//                   withFinalAction:action];
//
//}
//+ (void)animateButtonWithSlideFromDownAndUpShoot:(UIButton *)button   withFinalAction:(void (^)())action{
//    //NSLog(@"Down with us called: %f", button.center.y);
//    float durantion1 = 0.3;
//    float durantion2 = 0.1;
//    CGPoint final = button.center;
//    CGPoint start = final;
//    start.y=[CommonUtility getScreenHeight]+button.frame.size.height;
//    CGPoint middle =final;
//    middle.y = middle.y-20;
//
//    [AppAnimationManager slideView:(UIView *)button
//                      fromLocation:start
//                           through:middle
//                          duration:durantion1
//                                to:final
//                          duration:durantion2
//                   withFinalAction:action];
//}
//
@end
