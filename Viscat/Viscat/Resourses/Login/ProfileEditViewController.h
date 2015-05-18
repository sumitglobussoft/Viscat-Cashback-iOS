//
//  ProfileEditViewController.h
//  Viscat
//
//  Created by Sumit Ghosh on 17/03/15.
//  Copyright (c) 2015 Sumit Ghosh. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProfileEditViewController : UIViewController<UITextFieldDelegate,UIPickerViewDelegate,UIPickerViewDataSource>
{
    CGSize windowSize;
    UILabel * myProfileEdit,*requiredLbl,*bottomLbl;
    UIImageView * imageView;
    UIButton * updateButton,*cancel1,*cancel2,*changePass;
    
}
@property(nonatomic,strong)UITextField * userNameTXt,*nameTxt,*emailTxt,*address,*postalCode,* streeTxt,*phoneNoTxt,*oldPasswordTxt,* passwordTxt,* confimPassTxt;
@property(nonatomic,strong)UILabel * userNameLbl,*nameLbl,*emailLbl,*addressLbl,*postalCodeLbl,* streeLbl,*phoneNoLbl,*oldPasswordLbl,* passwordLbl,* confimPassLbl;
@property(nonatomic,strong)UIScrollView * scrollView;
@property(nonatomic)UIPickerView * pickerView;

@end
