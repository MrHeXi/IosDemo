//
//  DetailViewController.h
//  NavigationView
//
//  Created by 何溪 on 16/4/7.
//  Copyright © 2016年 何溪. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIWebView *myWebView;
@property(strong,nonatomic) NSString *url;
@end
