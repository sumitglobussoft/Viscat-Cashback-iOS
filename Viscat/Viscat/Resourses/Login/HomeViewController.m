//
//  HomeViewController.m
//  Viscat
//
//  Created by Sumit Ghosh on 23/03/15.
//  Copyright (c) 2015 Sumit Ghosh. All rights reserved.
//

#import "HomeViewController.h"
#import "CollectionheaderView.h"
#import "CustomCollectionCell.h"
#import "CustomMenuViewController.h"
#import "LoginViewController.h"
#import "SingletonClass.h"
#import "DetailPageViewController.h"
#import "AppDelegate.h"
#import "UIImageView+WebCache.h"


@interface HomeViewController ()
{
    CollectionheaderView * reuseableView;
    DetailPageViewController * detailVC;
}
@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
    windowSize=[UIScreen mainScreen].bounds.size;
    
    self.activityLoad=[[UIActivityIndicatorView alloc]init];
    self.activityLoad.frame=CGRectMake(windowSize.width/2-20, windowSize.height/2-100, 40, 40);
    self.activityLoad.activityIndicatorViewStyle=UIActivityIndicatorViewStyleWhiteLarge;
    self.activityLoad.alpha=1.0f;
    self.activityLoad.color=[UIColor blackColor];
    [self.view addSubview:self.activityLoad];
    [self.activityLoad startAnimating];
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        
        [self webServiceForHomePageData];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.activityLoad stopAnimating];
            [self creatCollectionView];
        });
    });

   
    
    // Do any additional setup after loading the view from its nib.
}

#pragma  mark- Create  Collection View

-(void)creatCollectionView{
    
    UICollectionViewFlowLayout * flowLayout=[[UICollectionViewFlowLayout alloc]init];
    flowLayout.minimumInteritemSpacing=2.0;
    flowLayout.minimumLineSpacing=10.0;
    flowLayout.sectionInset=UIEdgeInsetsMake(30, 10, 10, 10);
    
    if ([UIScreen mainScreen].bounds.size.height==480) {
        
       self.mainCollectionView=[[UICollectionView alloc]initWithFrame:CGRectMake(0, 5, windowSize.width, windowSize.height+60) collectionViewLayout:flowLayout];
    }
    else{
        self.mainCollectionView=[[UICollectionView alloc]initWithFrame:CGRectMake(0, 5, windowSize.width, windowSize.height-20) collectionViewLayout:flowLayout];
    }
    self.mainCollectionView.delegate=self;
    self.mainCollectionView.dataSource=self;
    self.mainCollectionView.backgroundColor=[UIColor clearColor];
    self.mainCollectionView.autoresizingMask=UIViewAutoresizingFlexibleHeight;
    self.mainCollectionView.showsVerticalScrollIndicator=NO;
    [self.mainCollectionView registerClass:[CustomCollectionCell class] forCellWithReuseIdentifier:@"CustomCollectionCell"];
    [self.view addSubview: self.mainCollectionView];
    
    
    [self.mainCollectionView registerClass:[CollectionheaderView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HeaderView"];
    
    [self.mainCollectionView registerClass:[CollectionheaderView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"FooterView"];
    
   
    
}

#pragma mark- CollectionDelegate methods

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    NSLog(@"number of images count %ld",[SingletonClass sharedSingleton].imageUrl.count);
    //return 15;
   return  [SingletonClass sharedSingleton].imageUrl.count;
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    CustomCollectionCell *customCell=(CustomCollectionCell*)[collectionView dequeueReusableCellWithReuseIdentifier:@"CustomCollectionCell" forIndexPath:indexPath];
   
    [customCell.profileImageView sd_setImageWithURL: [[SingletonClass sharedSingleton].imageUrl objectAtIndex:indexPath.row]];
    NSString * str=[[SingletonClass sharedSingleton].dataArr objectAtIndex:indexPath.row];
    customCell.nameLabel.text=[NSString stringWithFormat:@" %@ ",str];
  
    return customCell;
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(85,73);
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    
    CGSize size = CGSizeMake(self.view.frame.size.width, 25);
    return size;
    
}

/*- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section{
    
    CGSize size=CGSizeMake(self.view.frame.size.width, 25);
    return size;
}*/

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    
   // [NSThread detachNewThreadSelector:@selector(recomendedService) toTarget:self withObject:nil];
    
   /* if ([SingletonClass sharedSingleton].isLogin==NO) {
        [SingletonClass sharedSingleton].isFromHome=YES;
        LoginViewController * loginView=[[LoginViewController alloc]init];
        [self.navigationController pushViewController:loginView animated:YES];

    }
    else{*/
        if (detailVC) {
            detailVC=nil;
        }
        detailVC =[[DetailPageViewController alloc]initWithNibName:@"DetailPageViewController" bundle:nil];
        
        [SingletonClass sharedSingleton].topTitle=[[SingletonClass sharedSingleton].detail_title objectAtIndex:indexPath.row];
        [SingletonClass sharedSingleton].detail_description=[[SingletonClass sharedSingleton].detailDescription objectAtIndex:indexPath.row];
        [SingletonClass sharedSingleton].detailImgUrl=[[SingletonClass sharedSingleton].imageUrl objectAtIndex:indexPath.row];
        [SingletonClass sharedSingleton].cashBackStr=[[SingletonClass sharedSingleton].dataArr objectAtIndex:indexPath.row];
    [SingletonClass sharedSingleton].fav=[NSString stringWithFormat:@"%@",[favArr objectAtIndex:indexPath.row]];
    [SingletonClass sharedSingleton].coupns=[NSString stringWithFormat:@"%@",[coupnArr objectAtIndex:indexPath.row]];
    [SingletonClass sharedSingleton].added=[NSString stringWithFormat:@"%@",[addedArr objectAtIndex:indexPath.row]];
    [SingletonClass sharedSingleton].reviews =[NSString stringWithFormat:@"%@",[reviewArr objectAtIndex:indexPath.row]];
    
   detailVC.retailId=[NSString stringWithFormat:@"%@",[retailerId objectAtIndex: indexPath.row]];
    
    [SingletonClass sharedSingleton].webUrl=[storeUrl objectAtIndex:indexPath.row];
    [self.navigationController pushViewController:detailVC animated:YES];
    //}
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    reuseableView = nil;
    if (kind == UICollectionElementKindSectionHeader){
        
        
        
        if (indexPath.section==0) {
            reuseableView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HeaderView" forIndexPath:indexPath];
        }
        
        
            reuseableView.headrLabel.text = @"Header";
            reuseableView.subHeader.text=@"Sub Header";
        return reuseableView;
        
    }//End Header Kind Check
    
  /*  if (kind==UICollectionElementKindSectionFooter) {
        
        if (indexPath.section==0) {
            reuseableView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"FooterView" forIndexPath:indexPath];
        }

        reuseableView.footerLabel.text = @"Footer";
            return reuseableView;
    }// End of footer section*/
    return nil;
}


#pragma mark- Web service for getting all home page data

-(void)webServiceForHomePageData{
    
    [SingletonClass sharedSingleton].imageUrl=[[NSMutableArray alloc]init];
    [SingletonClass sharedSingleton].detailDescription=[[NSMutableArray alloc]init];
    [SingletonClass sharedSingleton].detail_title=[[NSMutableArray alloc]init];
    
    [SingletonClass sharedSingleton].dataArr=[[NSMutableArray alloc]init];
    storeUrl=[[NSMutableArray alloc]init];
    
    coupnArr=[[NSMutableArray alloc]init];
    addedArr=[[NSMutableArray alloc]init];
    favArr=[[NSMutableArray alloc]init];
    reviewArr=[[NSMutableArray alloc]init];
    retailerId=[[NSMutableArray alloc]init];
    
    NSError * error;
    NSURLResponse * urlResponse;
    
    NSString * getUrlStr=[NSString stringWithFormat:@"http://www.biscash.com/windex.php?method=getfeaturedstores"];
    NSURL * getUrl=[NSURL URLWithString:getUrlStr];
    
    NSMutableURLRequest * request=[[NSMutableURLRequest alloc]initWithURL:getUrl cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:50];
    [request setHTTPMethod:@"GET"];
    [request addValue:@"application/x-www-form-urlencoded; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    NSData * data=[NSURLConnection sendSynchronousRequest:request returningResponse:&urlResponse error:&error];
    if (data==nil) {
        return;
    }
    id json=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
    //NSLog(@"data for home page %@",json);
    if ([[json objectForKey:@"status"] isEqualToString:@"1"]) {
        NSArray * results=[json objectForKey:@"result"];
        NSMutableDictionary * dict=[NSMutableDictionary dictionary];
        for (int i=0; i<results.count; i++) {
            dict=[results objectAtIndex:i];
            [[SingletonClass sharedSingleton].imageUrl addObject:[dict objectForKey:@"image"]];
            
            [[SingletonClass sharedSingleton].detail_title addObject:[dict objectForKey:@"title"]];
            
            NSString * description=[dict objectForKey:@"description"];
            description =[description stringByReplacingOccurrencesOfString:@"<p>" withString:@""];
            description=[description stringByReplacingOccurrencesOfString:@"</p>" withString:@""];
            description=[description stringByReplacingOccurrencesOfString:@"\n" withString:@""];
            
            description=[description stringByReplacingOccurrencesOfString:@"\t" withString:@""];
            description=[description stringByReplacingOccurrencesOfString:@"&nbsp" withString:@""];
            description=[description stringByReplacingOccurrencesOfString:@" " withString:@""];
            
            NSString * cashBack=[NSString stringWithFormat:@"%@ 캐시백",[dict objectForKey:@"cashback"]];
            
            NSString * addedStr=[dict objectForKey:@"added"];
            NSRange  range=NSMakeRange(11, 8);
            addedStr =[addedStr stringByReplacingCharactersInRange:range withString:@""];
            [addedArr addObject:addedStr];
            
            NSString * favStr=[dict objectForKey:@"fav"];
            [favArr addObject:favStr];
            
            NSString * couponStr=[dict objectForKey:@"coupons"];
            [coupnArr addObject:couponStr];
            
            NSString *reviewStr=[dict objectForKey:@"reviews"];
            reviewStr=[reviewStr stringByReplacingOccurrencesOfString:@" review" withString:@""];
            [reviewArr addObject:reviewStr];
            
            [retailerId addObject:[dict objectForKey:@"retailer_id"]];
            
            [storeUrl addObject:[dict objectForKey:@"url"]];
            
            [[SingletonClass sharedSingleton].dataArr addObject:cashBack];
            [[SingletonClass sharedSingleton].detailDescription addObject:description];
        }
    }
    
  
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
