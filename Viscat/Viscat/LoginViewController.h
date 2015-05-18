//
//  LoginViewController.h
//  Viscat
//
//  Created by Sumit Ghosh on 17/03/15.
//  Copyright (c) 2015 Sumit Ghosh. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoginViewController : UIViewController<UITextFieldDelegate>
{
    CGSize windowSize;
    UILabel * loginLbl,*warningLbl,*emailIdLbl,*password,*bottomLbl;
    UIButton *forgotPassword;
    UIImageView *imageView;
}


@property(nonatomic,strong)UITextField * userText,* passwordText;
@property(nonatomic,strong)UIButton * loginButton;
@end
