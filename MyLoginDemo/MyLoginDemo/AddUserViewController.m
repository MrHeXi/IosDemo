//
//  AddUserViewController.m
//  MyContacts
//
//  Created by 何溪 on 16/4/12.
//  Copyright © 2016年 何溪. All rights reserved.
//

#import "AddUserViewController.h"
#import "ActionSheet.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import <AVFoundation/AVCaptureDevice.h>
#import <AVFoundation/AVMediaFormat.h>
@interface AddUserViewController ()
@property(strong,nonatomic) NSString *choosedImg;
@end

@implementation AddUserViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configureView];
    self.icon.userInteractionEnabled=YES;
    UITapGestureRecognizer *singleTap =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(onClickImage)];
    [self.icon addGestureRecognizer:singleTap];
    // Do any additional setup after loading the view.
}

-(void)onClickImage{
    ActionSheet *sheet = [[ActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"拍照" otherButtonTitles:@[@"从相册选择"]];
    [sheet showInView];
    NSLog(@"图片被点击!");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)save:(id)sender {
    NSString *userName = [self.userNameText.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    NSString *tel = [self.tel.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    if ([userName length] == 0) {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"警告" message:@"请填写姓名" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
        return;
    }
    
    
    User* user = [[User alloc]init];
    user.userName = userName;
    user.tel = tel;
    user.age = [NSNumber numberWithInteger:17];
    user.address=@"无";
    user.icon = self.choosedImg == nil ? @"1.jpg" : self.choosedImg;
    UserService* userService = [[UserService alloc]init];
    NSMutableArray *resList;
    if (self.myModifyUser == nil) {
        resList = [userService createUser : user];
    }else{
        user.userId = self.myModifyUser.userId;
        resList = [userService modifyUser: user];
    }
    
    [[NSNotificationCenter defaultCenter]postNotificationName:NOTIFY_ADD_USER object:resList userInfo:nil];
    [self.navigationController popViewControllerAnimated:YES];
}


- (void)setDetailItem:(User*)user {
    if (_myModifyUser != user) {
        _myModifyUser = user;
    }
}

- (void)configureView {
    if (self.myModifyUser) {
        User* user = self.myModifyUser;
        self.userNameText.text = user.userName;
        self.tel.text = user.tel;
        self.icon.image = [UIImage imageWithContentsOfFile:STORE_PATH(user.icon)];
    }else{
        self.title = @"新增联系人";
        self.icon.image = [UIImage imageNamed:@"default.png"];
    }
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
#pragma mark ActionSheetDelegate
- (void)actionSheet:(ActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0)
    {
        //判断是否拥有权限
        AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
        if (authStatus == AVAuthorizationStatusRestricted || authStatus == AVAuthorizationStatusDenied)
        {
            UIAlertView *alterView = [[UIAlertView alloc] initWithTitle:@"相机授权" message:@"没有权限访问您的相机" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alterView show];
            return;
        }
        
        //拍照
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            [self photocamera];
        }];
    }
    else if (buttonIndex == 1)
    {
        //选取图片
        //判断是否拥有权限
        ALAuthorizationStatus author = [ALAssetsLibrary authorizationStatus];
        if (author == ALAuthorizationStatusRestricted || author == ALAuthorizationStatusDenied)
        {
            UIAlertView *alterView = [[UIAlertView alloc] initWithTitle:@"相册授权" message:@"没有权限访问您的相册"  delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alterView show];
            return;
        }
        //选取图片
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            //            [self.navigationItem setBarTintColor:[UIColor redColor]];
            [self photoalbumr];
        }];
    }
    
}//通过拍照获取
-(void)photocamera
{
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
    {
        
        UIImagePickerController* imagepicker = [[UIImagePickerController alloc] init];
        imagepicker.delegate = self;
        imagepicker.allowsEditing = YES;
        imagepicker.sourceType = UIImagePickerControllerSourceTypeCamera;
        imagepicker.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
        [self presentViewController:imagepicker animated:YES completion:nil];
    }
}

//从相册获取
-(void)photoalbumr
{
    if ([UIImagePickerController isSourceTypeAvailable:
         UIImagePickerControllerSourceTypePhotoLibrary])
    {
        UIImagePickerController *picker =
        [[UIImagePickerController alloc] init];
        picker.delegate = self;
        picker.allowsEditing = YES;
        picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        
        //        [self presentViewController:picker animated:YES completion:nil];
        [self presentViewController:picker animated:YES completion:^{
            [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
        }];
        
    }
}
#pragma mark UIImagePickerControllerDelegate
//-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
//{
////[self.navigationItem setBarTintColor:[UIColor redColor]];
//}
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage *image = [info objectForKey:UIImagePickerControllerEditedImage];
    NSData *imgData = UIImageJPEGRepresentation(image, 0.5);
    self.icon.image = image;

    UserService* userService = [[UserService alloc]init];
    NSMutableArray *dataList  = [userService getAll];
    NSString *imgName = [NSString stringWithFormat:@"%@%lu.jpg",self.myModifyUser.userName,(unsigned long)[dataList count] + 1];
    [imgData writeToFile:STORE_PATH(imgName) atomically:YES];
    self.choosedImg = imgName;
    [picker dismissViewControllerAnimated:YES completion:nil];
}
@end
