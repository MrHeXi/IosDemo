//
//  AddNoteViewController.h
//  MyNotes_POOO
//
//  Created by 何溪 on 16/4/11.
//  Copyright © 2016年 何溪. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Note.h"
#import "NoteBL.h"
@interface AddNoteViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextView *myNote;
@property(strong,nonatomic) Note* myModifyNote;
- (void)setDetailItem:(Note*)note ;
@end
