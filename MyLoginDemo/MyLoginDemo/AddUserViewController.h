//
//  AddUserViewController.h
//  MyContacts
//
//  Created by 何溪 on 16/4/12.
//  Copyright © 2016年 何溪. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "User.h"
#import "UserService.h"
#import "Define.h"
@interface AddUserViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *userNameText;
@property (weak, nonatomic) IBOutlet UITextField *tel;
@property (weak, nonatomic) IBOutlet UIImageView *icon;
@property(strong,nonatomic) User* myModifyUser;

- (void)setDetailItem:(User*)user ;
@end
