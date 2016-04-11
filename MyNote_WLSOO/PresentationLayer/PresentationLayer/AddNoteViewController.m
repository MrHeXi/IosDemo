//
//  AddNoteViewController.m
//  MyNotes_POOO
//
//  Created by 何溪 on 16/4/11.
//  Copyright © 2016年 何溪. All rights reserved.
//

#import "AddNoteViewController.h"

@interface AddNoteViewController ()

@end

@implementation AddNoteViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configureView];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)cancel:(id)sender {
    [self dismissViewControllerAnimated:YES completion:^{
        NSLog(@"click cancel save");
    }];
}

- (IBAction)save:(id)sender {
    NSString *contents = [self.myNote.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    if ([contents length] == 0) {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"警告" message:@"请填写内容" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
        return;
    }
    
    [self dismissViewControllerAnimated:YES completion:^{
        NSLog(@"click cancel save");
            Note* note = [[Note alloc]init];
            note.createTime = [[NSDate alloc]init];
            note.contents = contents;
            NoteBL* bl = [[NoteBL alloc]init];
        NSMutableArray *resList;
        if (self.myModifyNote == nil) {
            resList = [bl createNote: note];
        }else{
            note.noteId = self.myModifyNote.noteId;
            resList = [bl modifyNote: note];
        }
        
        [[NSNotificationCenter defaultCenter]postNotificationName:@"addNewNote" object:resList userInfo:nil];
    }];
}



- (void)setDetailItem:(Note*)note {
    if (_myModifyNote != note) {
        _myModifyNote = note;
    }
}

- (void)configureView {
    if (self.myModifyNote) {
        Note* note = self.myModifyNote;
        self.myNote.text = note.contents;
        NSLog(@"%@---contents",note.contents);
        NSLog(@"%@---self.myNote",self.myNote);
        NSLog(@"%@---self.myNote.text",self.myNote.text);
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

@end
