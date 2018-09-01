//
//  MyPopupDialog.h
//  SchoolApp
//
//  Created by TwinkleStar on 11/28/15.
//  Copyright © 2015 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ViewDialogDelegate <NSObject>

@optional
-(BOOL)didSubmit:(NSDictionary*)data View:(id)view;
-(BOOL)didCancel:(NSDictionary*)data View:(id)view;
@end

@interface MyPopupDialog : UIView

@property (nonatomic,strong) UIView* backgroundview;
@property (nonatomic,assign) BOOL isShowing;
@property (nonatomic,weak) id delegate;
@property (nonatomic,weak) UIView* contentview;

-(void) setup:(UIView*) view backgroundDismiss:(BOOL) dismiss backgroundColor:(UIColor*) color;
-(void)showPopup:(UIView*) root;
-(void)showAnimation;
-(void)dismissPopup;
-(void)setLayout:(CGSize) rect;

-(void)setupForFullScreen:(UIView*)view Frame:(CGRect)rect;
@end
