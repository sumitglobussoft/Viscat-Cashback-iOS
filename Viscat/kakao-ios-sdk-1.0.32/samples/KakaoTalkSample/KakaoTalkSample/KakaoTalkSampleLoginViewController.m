/**
* Copyright 2014 Daum Kakao Corp.
*
* Redistribution and modification in source or binary forms are not permitted without specific prior written permission.
*
* Licensed under the Apache License, Version 2.0 (the "License");
* you may not use this file except in compliance with the License.
* You may obtain a copy of the License at
*
*    http://www.apache.org/licenses/LICENSE-2.0
*
* Unless required by applicable law or agreed to in writing, software
* distributed under the License is distributed on an "AS IS" BASIS,
* WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
* See the License for the specific language governing permissions and
* limitations under the License.
*/

#import "KakaoTalkSampleAppDelegate.h"
#import "KakaoTalkSampleLoginViewController.h"

#import <KakaoOpenSDK/KakaoOpenSDK.h>

@implementation KakaoTalkSampleLoginViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"Login";
    }
    return self;
}

- (void)loadView {
    [super loadView];

    // logo display
    int marginBottom = 25;

    UIImage *kakaoLogoImage = [KOImages kakaoLogo];
    UIImageView *kakaoLogoImageView = [[UIImageView alloc] initWithImage:kakaoLogoImage];
    kakaoLogoImageView.frame = CGRectMake((self.view.frame.size.width - kakaoLogoImage.size.width) / 2, (self.view.frame.size.height - kakaoLogoImage.size.width - marginBottom) / 2, kakaoLogoImage.size.width, kakaoLogoImage.size.height);
    kakaoLogoImageView.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin;

    [self.view addSubview:kakaoLogoImageView];
    
    // button display
    UIButton *kakaoAccountConnectButton = [self createKakaoAccountConnectButton];
    [self.view addSubview:kakaoAccountConnectButton];
}

- (UIButton *)createKakaoAccountConnectButton {
    // button position
    int xMargin = 30;
    int marginBottom = 25;
    CGFloat btnWidth = self.view.frame.size.width - xMargin * 2;
    int btnHeight = 42;

    UIButton *btnKakaoLogin
            = [[KOLoginButton alloc] initWithFrame:CGRectMake(xMargin, self.view.frame.size.height - btnHeight - marginBottom, btnWidth, btnHeight)];
    btnKakaoLogin.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleWidth;
    
    // action
    [btnKakaoLogin addTarget:self action:@selector(invokeLoginWithTarget:) forControlEvents:UIControlEventTouchUpInside];

    return btnKakaoLogin;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
    } else {
        return YES;
    }
}

#pragma mark - actions

- (IBAction)invokeLoginWithTarget:(id)sender {
    [[KOSession sharedSession] close];

    [[KOSession sharedSession] openWithCompletionHandler:^(NSError *error) {

        if ([[KOSession sharedSession] isOpen]) {
            // login success.
            NSLog(@"login success.");
            [[[UIApplication sharedApplication] delegate] performSelector:@selector(showMainView)];

        } else {
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"에러"
                                                                message:error.localizedDescription
                                                               delegate:nil
                                                      cancelButtonTitle:@"확인"
                                                      otherButtonTitles:nil];
            [alertView show];
        }

    }];
}

- (IBAction)invokeCancelLoginWithTarget:(id)sender {
    [[KOSession sharedSession] close];
}

- (IBAction)invokeToggleStatusBar:(id)sender {
    [[UIApplication sharedApplication] setStatusBarHidden:![UIApplication sharedApplication].statusBarHidden withAnimation:YES];
}

@end
