//
//  ViewController.m
//  DMTButton
//
//  Created by intMax on 16/4/10.
//  Copyright © 2016年 intMax. All rights reserved.
//

#import "ViewController.h"

#define FULL_WIDTH [UIScreen mainScreen].bounds.size.width
#define FULL_HEIGHT [UIScreen mainScreen].bounds.size.height
#define BUTTON_WIDTH 200

static CGFloat y = 20.;

@interface ViewController ()<UITextFieldDelegate>
{
    NSInteger v;
    NSInteger h;
}

@property (nonatomic, strong) UIButton *button;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    v = 0;
    h = 0;
    
    [self addSegmentedControls];
    [self.view addSubview:self.button];
    [self addTextFields];
    [self addLabels];
    
    
}

- (void)addSegmentedControls
{
    UISegmentedControl *segV = [[UISegmentedControl alloc] initWithItems:@[@"V:center", @"V:top", @"V:bottom", @"V:fill"]];
    segV.frame = CGRectMake(15, y, FULL_WIDTH-30, 30);
    segV.selectedSegmentIndex = 0;
    [segV addTarget:self action:@selector(changeAlignment:) forControlEvents:UIControlEventValueChanged];
    segV.tag = 1000;
    [self.view addSubview:segV];
    y +=(30+10);
    
    UISegmentedControl *segH = [[UISegmentedControl alloc] initWithItems:@[@"H:center", @"H:left", @"H:right", @"H:fill"]];
    segH.frame = CGRectMake(15, y, FULL_WIDTH-30, 30);
    segH.selectedSegmentIndex = 0;
    [segH addTarget:self action:@selector(changeAlignment:) forControlEvents:UIControlEventValueChanged];
    segH.tag = 2000;
    [self.view addSubview:segH];
    y +=(30+10);
}

- (void)addTextFields
{
    UITextField *textFieldForImageInsets = [[UITextField alloc] initWithFrame:CGRectMake(15, y, FULL_WIDTH-30, 30)];
    textFieldForImageInsets.placeholder = @"input image insets, separate with space";
    textFieldForImageInsets.tag = 10000;
    textFieldForImageInsets.delegate = self;
    textFieldForImageInsets.layer.borderColor = [UIColor grayColor].CGColor;
    textFieldForImageInsets.layer.borderWidth = 1.;
    [textFieldForImageInsets addTarget:self action:@selector(changeInsets:) forControlEvents:UIControlEventEditingChanged];
    [self.view addSubview:textFieldForImageInsets];
    y +=(30+10);
    
    UITextField *textFieldForTitleInsets = [[UITextField alloc] initWithFrame:CGRectMake(15, y, FULL_WIDTH-30, 30)];
    textFieldForTitleInsets.placeholder = @"input title insets, separate with space";
    textFieldForTitleInsets.tag = 20000;
    textFieldForTitleInsets.delegate = self;
    textFieldForTitleInsets.layer.borderColor = [UIColor grayColor].CGColor;
    textFieldForTitleInsets.layer.borderWidth = 1.;
    [textFieldForTitleInsets addTarget:self action:@selector(changeInsets:) forControlEvents:UIControlEventEditingChanged];
    [self.view addSubview:textFieldForTitleInsets];
    y +=(30+10);
}

- (void)addLabels
{
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, y, FULL_WIDTH, 100)];
    label.numberOfLines = 0;
    label.text = @"button: 200x100, image: 60x60, title:54x22";
    label.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:label];
}

- (void)changeAlignment:(UISegmentedControl *)sender
{
    switch (sender.tag) {
        case 1000:
            v = sender.selectedSegmentIndex;
            break;
        case 2000:
            h = sender.selectedSegmentIndex;
            break;
        default:
            break;
    }
    
    self.button.contentVerticalAlignment = v;
    self.button.contentHorizontalAlignment = h;
    
    [self.button layoutSubviews];
}

- (void)changeInsets:(UITextField *)sender
{
    NSArray *array = [sender.text componentsSeparatedByString:@" "];
    if(array && array.count == 4){
        switch (sender.tag) {
            case 10000:
            {
                self.button.imageEdgeInsets = UIEdgeInsetsMake([array[0] floatValue], [array[1] floatValue], [array[2] floatValue], [array[3] floatValue]);
            }
                break;
            case 20000:
            {
                self.button.titleEdgeInsets = UIEdgeInsetsMake([array[0] floatValue], [array[1] floatValue], [array[2] floatValue], [array[3] floatValue]);
            }
                break;
            default:
                break;
        }
    }
}

- (UIButton *)button
{
    if(!_button){
        _button = [[UIButton alloc] initWithFrame:CGRectMake((FULL_WIDTH-BUTTON_WIDTH)/2, y, BUTTON_WIDTH, 100)];
        _button.layer.borderColor = [UIColor grayColor].CGColor;
        _button.layer.borderWidth = 1.;
        _button.imageView.layer.borderColor = [UIColor redColor].CGColor;
        _button.imageView.layer.borderWidth = 1.;
        _button.titleLabel.layer.borderColor = [UIColor blueColor].CGColor;
        _button.titleLabel.layer.borderWidth = 1.;
        [_button setImage:[UIImage imageNamed:@"face_180x180_alpha"] forState:UIControlStateNormal];
        [_button setTitle:@"intMax" forState:UIControlStateNormal];
        [_button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        y +=(100+10);
    }
    return _button;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
