//
//  ViewController.m
//  MyLoginDemo
//
//  Created by 何溪 on 16/4/14.
//  Copyright © 2016年 何溪. All rights reserved.
//

#import "ViewController.h"
#import "MainViewController.h"
#define checkLoginStatus [self checkLogin]
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)login:(id)sender {
    if (checkLoginStatus) {
//        UIStoryboard *story = self.storyboard;
//        MainViewController *mainViewController = [story instantiateViewControllerWithIdentifier:@"MainViewController"];
//        [self.navigationController pushViewController:mainViewController animated:YES];
        
        [self performSegueWithIdentifier:@"loginsuccess" sender:self];
    }else{
//        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"警告" message:@"用户名必须包含字母、数字并以字母开头；密码必须包含大写、小写字母和数字，长度必须大于等于8位" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
//        [alert show];
        [self performSegueWithIdentifier:@"loginfaild" sender:self];
    }
}

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    
}

-(Boolean)checkLogin{
    NSString *userName = [self.userName.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];;
    NSString *password = self.password.text;
    
    NSString * regex = @"^[A-Za-z][A-Za-z0-9].*$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    BOOL isMatch = [pred evaluateWithObject:userName];
    NSString * regex1 = @"^(?=.*[0-9].*)(?=.*[A-Z].*)(?=.*[a-z].*).{8,20}$";
    NSPredicate *pred1 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex1];
    BOOL isMatchPwd = [pred1 evaluateWithObject:password];
    
    return isMatch && isMatchPwd;
}
@end
