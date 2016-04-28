//
//  ActionSheet.h
//  CloudStudySeal
//
//  Created by liujiafei on 14-8-19.
//  Copyright (c) 2014年 Tbc. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ActionSheet;

@protocol ActionSheetDelegate <NSObject>

@optional
- (void)actionSheet:(ActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex;

@end

@interface ActionSheet : UIView

- (id)initWithTitle:(NSString *)title delegate:(id<ActionSheetDelegate>)delegate cancelButtonTitle:(NSString *)cancelButtonTitle destructiveButtonTitle:(NSString *)destructiveButtonTitle otherButtonTitles:(NSArray *)otherButtonTitlesArray;
- (void)showInView;

@end
