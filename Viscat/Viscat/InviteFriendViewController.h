//
//  InviteFriendViewController.h
//  Viscat
//
//  Created by Sumit Ghosh on 23/03/15.
//  Copyright (c) 2015 Sumit Ghosh. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface InviteFriendViewController : UIViewController<UITextFieldDelegate,UITextViewDelegate>
{
    CGSize  windowSize;
    UILabel * bottomLbl,*tellFriend,*ruleOne,*ruleTwo,*ruleThree,* requiredLbl1,*requiredLbl2;
    UIScrollView * scorllView;
    CALayer *layer;
}

@property(nonatomic)UITextField * txt1,* txt2,* txt3,*txt4,*txt5,* txt6,*txt7,* txt8,* txt9,*txt10;
@property(nonatomic)UITextView * textView;
@property(nonatomic)UIButton * button;
@property(nonatomic)UIImageView * imageView;
@property(nonatomic)UILabel * lbl1,*lbl2,* lbl3,* lbl4,*lbl5,* lbl6;

@end
