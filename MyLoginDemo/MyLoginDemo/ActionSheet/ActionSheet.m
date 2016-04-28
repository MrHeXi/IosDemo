//
//  ActionSheet.m
//  CloudStudySeal
//
//  Created by liujiafei on 14-8-19.
//  Copyright (c) 2014年 Tbc. All rights reserved.
//

#import "ActionSheet.h"

#define DEVICE_WIDTH  ([[UIScreen mainScreen] bounds].size.width)
#define DEVICE_HEIGHT ([[UIScreen mainScreen] bounds].size.height)
#define WINDOW_COLOR                            [UIColor colorWithRed:0 green:0 blue:0 alpha:0.4]
#define ANIMATE_DURATION                        0.3f

@interface ActionSheet ()

@property (nonatomic, assign) BOOL isHadTitle;
@property (nonatomic, assign) BOOL isHadDestructionButton;
@property (nonatomic, assign) BOOL isHadOtherButton;
@property (nonatomic, assign) BOOL isHadCancelButton;
@property (nonatomic, assign) CGFloat maxHeight;
@property (nonatomic, strong) UIView *backgroundView;

@property (nonatomic, assign) id<ActionSheetDelegate> delegate;

@end

@implementation ActionSheet

- (id)initWithTitle:(NSString *)title delegate:(id<ActionSheetDelegate>)delegate cancelButtonTitle:(NSString *)cancelButtonTitle destructiveButtonTitle:(NSString *)destructiveButtonTitle otherButtonTitles:(NSArray *)otherButtonTitlesArray
{
    self = [super init];
    if (self)
    {
        //初始化背景视图，添加手势
        self.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
        self.backgroundColor = WINDOW_COLOR;
        self.userInteractionEnabled = YES;
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tappedCancel)];
        [self addGestureRecognizer:tapGesture];
        
        if (delegate)
        {
            self.delegate = delegate;
        }
        
        [self creatButtonsWithTitle:title cancelButtonTitle:cancelButtonTitle destructionButtonTitle:destructiveButtonTitle otherButtonTitles:otherButtonTitlesArray];
    }
    return self;
}

- (void)tappedCancel
{
    [UIView animateWithDuration:ANIMATE_DURATION animations:^{
        [self.backgroundView setFrame:CGRectMake(0, [UIScreen mainScreen].bounds.size.height, [UIScreen mainScreen].bounds.size.width, 0)];
        self.alpha = 0;
    } completion:^(BOOL finished) {
        if (finished) {
            [self removeFromSuperview];
        }
    }];
}

- (void)creatButtonsWithTitle:(NSString *)title cancelButtonTitle:(NSString *)cancelButtonTitle destructionButtonTitle:(NSString *)destructiveButtonTitle otherButtonTitles:(NSArray *)otherButtonTitlesArray
{
    _isHadTitle = NO;
    _isHadCancelButton = NO;
    _isHadDestructionButton = NO;
    _isHadOtherButton = NO;
    _maxHeight = 1;
    
    [self initBackgroundView];
    
    if (title != nil && title.length > 0)
    {
        _isHadTitle = YES;
        [self initTitleView:title];
    }
    
    if (destructiveButtonTitle != nil && destructiveButtonTitle.length > 0)
    {
        _isHadDestructionButton = YES;
        [self initDestructiveButton:destructiveButtonTitle];
    }
    
    if (otherButtonTitlesArray != nil && otherButtonTitlesArray.count > 0)
    {
        _isHadOtherButton = YES;
        [self initOtherBtns:otherButtonTitlesArray];
    }
    
    if (cancelButtonTitle != nil && cancelButtonTitle.length > 0)
    {
        _isHadCancelButton = YES;
        [self initCancelBtn:cancelButtonTitle];
    }
    
    [UIView animateWithDuration:ANIMATE_DURATION animations:^{
        self.backgroundView.frame = CGRectMake(CGRectGetMinX(self.backgroundView.frame),DEVICE_HEIGHT-_maxHeight, DEVICE_WIDTH, _maxHeight);
    }];
}

- (void)initBackgroundView
{
    self.backgroundView = [[UIView alloc] initWithFrame:CGRectMake(0, DEVICE_HEIGHT, DEVICE_WIDTH, _maxHeight)];
    self.backgroundView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bg.png"]];
    [self addSubview:self.backgroundView];
    
    UIImageView *lineImgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, DEVICE_WIDTH, 2)];
    lineImgView.image = [UIImage imageNamed:@"red_line.png"];
    [self.backgroundView addSubview:lineImgView];
    
    _maxHeight = CGRectGetMaxY(lineImgView.frame);
}

- (void)initTitleView:(NSString *)title
{
    CGSize titleSize = [title sizeWithFont:[UIFont systemFontOfSize:15] constrainedToSize:CGSizeMake(DEVICE_WIDTH, MAXFLOAT) lineBreakMode:NSLineBreakByWordWrapping];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, _maxHeight, DEVICE_WIDTH, titleSize.height)];
    label.backgroundColor = [UIColor clearColor];
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = [UIColor blackColor];
    label.text = title;
    [self.backgroundView addSubview:label];
    
    _maxHeight = CGRectGetMaxY(label.frame) + 5;
}

- (void)initDestructiveButton:(NSString *)destructiveButtonTitle
{
    UIButton *btn = [self initbuttonWithTitle:destructiveButtonTitle IsCancelBtn:NO];
    btn.tag = 0;
}

- (void)initOtherBtns:(NSArray *)otherButtonTitles
{
    [otherButtonTitles enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        UIButton *btn = [self initbuttonWithTitle:obj IsCancelBtn:NO];
        if (_isHadDestructionButton)
        {
            btn.tag = idx+1;
        }
        else{
            btn.tag = idx;
        }
    }];
}

- (void)initCancelBtn:(NSString *)title
{
    UIButton *btn = [self initbuttonWithTitle:title IsCancelBtn:YES];
    btn.tag = 1000;
}

- (UIButton *)initbuttonWithTitle:(NSString*)title IsCancelBtn:(BOOL)isCancelBtn
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, _maxHeight, DEVICE_WIDTH, 44);
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
    if (isCancelBtn)
    {
        [btn setBackgroundImage:[UIImage imageNamed:@"cancel_btn_n.png"] forState:UIControlStateNormal];
        [btn setBackgroundImage:[UIImage imageNamed:@"cancel_btn_p.png"] forState:UIControlStateHighlighted];
        [btn setBackgroundImage:[UIImage imageNamed:@"cancel_btn_p.png"] forState:UIControlStateDisabled];
        btn.frame = CGRectMake(0, CGRectGetMinY(btn.frame) + 10, CGRectGetWidth(btn.frame), CGRectGetHeight(btn.frame));
    }
    else
    {
        [btn setBackgroundImage:[UIImage imageNamed:@"btn_n.png"] forState:UIControlStateNormal];
        [btn setBackgroundImage:[UIImage imageNamed:@"btn_p.png"] forState:UIControlStateHighlighted];
        [btn setBackgroundImage:[UIImage imageNamed:@"btn_p.png"] forState:UIControlStateDisabled];
    }
    [self.backgroundView addSubview:btn];
    
    _maxHeight = CGRectGetMaxY(btn.frame);
    return btn;
}

- (void)buttonPressed:(UIButton *)sender
{
    [self tappedCancel];
    if (self.delegate && [self.delegate respondsToSelector:@selector(actionSheet:clickedButtonAtIndex:)])
    {
        [self.delegate actionSheet:self clickedButtonAtIndex:sender.tag];
    }
}

- (void)showInView
{
    [[UIApplication sharedApplication].delegate.window.rootViewController.view addSubview:self];
}

@end
