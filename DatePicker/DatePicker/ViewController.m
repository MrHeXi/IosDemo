//
//  ViewController.m
//  DatePicker
//
//  Created by 何溪 on 16/4/6.
//  Copyright © 2016年 何溪. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UIPickerViewDelegate,UIPickerViewDataSource>
@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;
@property (weak, nonatomic) IBOutlet UILabel *datePickerLabel;
@property (weak, nonatomic) IBOutlet UIPickerView *provincePickerView;
@property (weak, nonatomic) IBOutlet UILabel *provincePickerLabel;

@property(strong,nonatomic) NSDictionary *provinceData;
@property(strong,nonatomic) NSArray *pickerProvinceData;
@property(strong,nonatomic) NSArray *pickerCityData;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSBundle *bundle = [NSBundle mainBundle];
    NSString *provinceDataPath = [bundle pathForResource:@"provinces_cities" ofType:@"plist"];
    NSDictionary *dict = [[NSDictionary alloc]initWithContentsOfFile:provinceDataPath];
    self.provinceData = dict;
    self.pickerProvinceData = [self.provinceData allKeys];
    NSString *selectedProvince = [self.pickerProvinceData objectAtIndex:0];
    self.pickerCityData = [self.provinceData objectForKey:selectedProvince];
    // Do any additional setup after loading the view, typically from a nib.
    self.provincePickerView.dataSource = self;//important [重要]
    self.provincePickerView.delegate = self;//important [重要]
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)showBtnClick:(id)sender {
    NSDate *theDate = self.datePicker.date;
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    formatter.dateFormat=@"YYYY-MM-dd";
    self.datePickerLabel.text = [formatter stringFromDate:theDate];
    
    NSInteger row1 = [self.provincePickerView selectedRowInComponent:0];
    NSInteger row2 = [self.provincePickerView selectedRowInComponent:1];
    NSString *selected1 = [self.pickerProvinceData objectAtIndex:row1];
    NSString *selected2 = [self.pickerCityData objectAtIndex:row2];
    self.provincePickerLabel.text = [[NSString alloc]initWithFormat:@"%@,%@",selected1,selected2];
}

#pragma mark UIPickerViewDataSource
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 2;
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    if (component == 0) {
        return [self.pickerProvinceData count];
    }else{
        return [self.pickerCityData count];
    }
}

#pragma mark UIPickerViewDelegate
-(NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    if (component == 0) {
        return [self.pickerProvinceData objectAtIndex:row];
    }else{
        return [self.pickerCityData objectAtIndex:row];
    }
}

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    if (component == 0) {
        NSString *selectedProvince = [self.pickerProvinceData objectAtIndex:row];
        NSArray *cities = [self.provinceData objectForKey:selectedProvince];
        self.pickerCityData =cities;
        [self.provincePickerView reloadComponent:1];
    }
}

@end
