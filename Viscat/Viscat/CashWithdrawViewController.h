//
//  CashWithdrawViewController.h
//  Viscat
//
//  Created by Sumit Ghosh on 17/03/15.
//  Copyright (c) 2015 Sumit Ghosh. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CashWithdrawViewController : UIViewController<UITextFieldDelegate,UIPickerViewDataSource,UIPickerViewDelegate>
{
    CGSize windowSize;
    UILabel * topLabel,*bottomLbl,*userName;
    UIImageView * imgView;
    NSArray * pickerViewData;
    NSString * defaultStr;
}


@property(nonatomic,strong)UITextField * userText;
@property(nonatomic,strong)UIButton * loginButton,* passwordbtn;
@property(nonatomic)UIPickerView * pickerView;
@end
