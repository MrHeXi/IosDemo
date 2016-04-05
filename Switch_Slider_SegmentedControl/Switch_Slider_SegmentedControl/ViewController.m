//
//  ViewController.m
//  Switch_Slider_SegmentedControl
//
//  Created by 何溪 on 16/4/5.
//  Copyright © 2016年 何溪. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UISwitch *leftSwitch;

@property (weak, nonatomic) IBOutlet UISwitch *rightSwitch;
@property (weak, nonatomic) IBOutlet UILabel *sliderValue;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

-(IBAction)switchValueChanged:(id)sender{
    UISwitch *witchSwitch = (UISwitch*)sender;
    BOOL setting = witchSwitch.isOn;
    [self.leftSwitch setOn:setting animated:YES];
    [self.rightSwitch setOn:setting animated:YES];
}

- (IBAction)sliderValueChanged:(id)sender {
    UISlider *slider = (UISlider*)sender;
    int progressAsInt = (int)(slider.value);
    NSString *textValue = [[NSString alloc]initWithFormat:@"%d",progressAsInt];
    self.sliderValue.text = textValue;
    
}
- (IBAction)touchDown:(id)sender {
    if (self.leftSwitch.hidden == YES) {
        self.rightSwitch.hidden = NO;
        self.leftSwitch.hidden = NO;
    }else{
        self.leftSwitch.hidden = YES;
        self.rightSwitch.hidden = YES;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
