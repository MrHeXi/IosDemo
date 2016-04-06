//
//  ViewController.m
//  ComplexView
//
//  Created by 何溪 on 16/4/6.
//  Copyright © 2016年 何溪. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UIAlertViewDelegate,UIActionSheetDelegate>
- (IBAction)alertViewBtnClick:(id)sender;
- (IBAction)actionSheetBtnClick:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *itemLabel;

@property (weak, nonatomic) IBOutlet UILabel *screenlabel;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    CGSize iosDeviceScreenSize = [UIScreen mainScreen].bounds.size;
    NSLog(@"%f X %f",iosDeviceScreenSize.width,iosDeviceScreenSize.height);
    NSString *screenSize = [NSString stringWithFormat:@"%f X %f",iosDeviceScreenSize.width,iosDeviceScreenSize.height];
    self.screenlabel.text = screenSize;
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)alertViewBtnClick:(id)sender {
//    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"Alert" message:@"AlertView goes here" delegate:self cancelButtonTitle:@"NO" otherButtonTitles:@"YES", nil];
//    [alertView show];
//second implement [第二种实现方法]
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Alert" message:@"Alert goes here" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *noAction = [UIAlertAction actionWithTitle:@"NO" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action){
        NSLog(@"No action");}];
    UIAlertAction *yesAction = [UIAlertAction actionWithTitle:@"YES" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){
        NSLog(@"YES action");}];
    
    [alertController addAction:noAction];
    [alertController addAction:yesAction];
    [self presentViewController:alertController animated:true completion:nil];
}

#pragma mark -- implement UIAlertViewDelegate
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    NSLog(@"buttonIndex = %li",(long)buttonIndex);
}

- (IBAction)actionSheetBtnClick:(id)sender {
//    UIActionSheet *actionSheet = [[UIActionSheet alloc]initWithTitle:nil delegate:self cancelButtonTitle:@"cancel" destructiveButtonTitle:@"destructBtn" otherButtonTitles:@"Facebook",@"Webo",@"QQ", nil];
//    actionSheet.actionSheetStyle = UIActionSheetStyleAutomatic;
//    [actionSheet showInView:self.view];
    //second implement [第二种实现方法]
    UIAlertController *actionSheetController = [[UIAlertController alloc]init];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action){
        NSLog(@"cancel action");}];
    UIAlertAction *destructAction = [UIAlertAction actionWithTitle:@"destruct" style:UIAlertActionStyleDestructive handler:^(UIAlertAction *action){
        NSLog(@"destruct action");}];
    UIAlertAction *facebookAction = [UIAlertAction actionWithTitle:@"facebook" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){
        NSLog(@"facebook action");}];
    UIAlertAction *weboAction = [UIAlertAction actionWithTitle:@"webo" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){
        NSLog(@"webo action");}];
    UIAlertAction *qqAction = [UIAlertAction actionWithTitle:@"QQ" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){
        NSLog(@"QQ action");}];
    
    [actionSheetController addAction:cancelAction];
    [actionSheetController addAction:destructAction];
    [actionSheetController addAction:facebookAction];
    [actionSheetController addAction:weboAction];
    [actionSheetController addAction:qqAction];
    
    [self presentViewController:actionSheetController animated:true completion:nil];
}

#pragma mark -- implement UIActionSheetDelegate
-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    NSLog(@"buttonIndex = %li",(long)buttonIndex);
}

- (IBAction)saveClick:(id)sender {
    UIBarButtonItem *barButtonItem = (UIBarButtonItem*)sender;
    self.itemLabel.text = barButtonItem.title;
}

@end
