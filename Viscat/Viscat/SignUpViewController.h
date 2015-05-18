//
//  SignUpViewController.h
//  Viscat
//
//  Created by Sumit Ghosh on 17/03/15.
//  Copyright (c) 2015 Sumit Ghosh. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SignUpViewController : UIViewController<UITextFieldDelegate,UIPickerViewDataSource,UIPickerViewDelegate>
{
    CGSize windowSize;
    UILabel * titleLabel,*requiredLabel;
    UIImageView * imageView;
    UIScrollView * scrollView;
    NSArray * countryName,* countryCode;
    NSString * countryNameStr,* countryCodeStr;
    NSUInteger i1,i2,i3,i4,i5;
    NSString *Captcha_string;
}
@property(nonatomic,strong)UITextField * fnameTxt,*lnametxt,*emailtxt,*confirmEmailtxt,*passwordtxt,*confirmPasstxt6,*countrytext,*phoneTxt,*securCodetxt;
@property(nonatomic,strong)UILabel * signupnameLbl,*sexLbl,*emailLabel,*emailconfirmLbl,*confirmpasswordLbl,*passwordLbl,*countryLbl,*phonenumberLbl,*securitycodeLbl;
@property(nonatomic)UIButton * countoryBtn;

@property(nonatomic,strong)UILabel * chk1Lbl,* chk2lbl;

@property(nonatomic,strong)UIButton * checkBoxButton1,* checkBoxButton2,* signupButton,* signUp;

@property(nonatomic,strong)UIPickerView * pickerView;

@end
