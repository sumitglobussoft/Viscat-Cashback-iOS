//
//  WebViewViewController.h
//  Viscat
//
//  Created by Sumit Ghosh on 21/04/15.
//  Copyright (c) 2015 Sumit Ghosh. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WebViewViewController : UIViewController{
    
    UIWebView * webView;
    CGSize  windowSize;
}

@property(nonatomic,strong)NSString * retailerID;
@end
