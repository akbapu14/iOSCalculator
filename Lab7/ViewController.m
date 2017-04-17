//
//  ViewController.m
//  Lab7
//
//  Created by Akilesh Bapu on 4/16/17.
//  Copyright © 2017 org.iosdecal. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (strong, nonatomic) IBOutlet UILabel *calculationView;
@property NSString *calculationString;
@property NSString *savedOperand;
typedef enum actionType : long {
    multiply = 0,
    subtract,
    add,
    equal
} actionType;
@property actionType currentAction;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    _calculationString = @"0.0";
    _savedOperand = @"0.0";
    _currentAction = multiply;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)updatecalculationView {
    _calculationView.text = _calculationString;
}
- (void)saveOperand {
    _savedOperand = _calculationString;
    _calculationString = @"0.0";
}

- (IBAction)numberPressed:(id)sender {
    UIButton *pressedButton = (UIButton *)sender;
    if (pressedButton.tag == 11) {
        if ([_calculationString containsString:@"."] && !([_calculationString doubleValue] == 0)) {
            return;
        }
        if ([_calculationString intValue] == 0) {
            _calculationString = @"0.";
        } else {
            _calculationString = [_calculationString stringByAppendingString:@"."];
        }
    } else {
        if ([_calculationString doubleValue] == 0 && ![_calculationString isEqualToString:@"0."]) {
            if (pressedButton.tag == 0) {
                
            } else {
            _calculationString = [NSString stringWithFormat:@"%ld",(long)pressedButton.tag];
            }

        } else {
            _calculationString = [_calculationString stringByAppendingString:[NSString stringWithFormat:@"%ld",(long)pressedButton.tag]];
        }
    }
    [self updatecalculationView];
}
- (IBAction)clearPressed:(id)sender {
    _calculationString = @"0.0";
    [self updatecalculationView];
}
- (IBAction)plusMinusPressed:(id)sender {
    if([_calculationString hasPrefix:@"-"]) {
        _calculationString = [_calculationString substringFromIndex:1];
    } else {
        _calculationString = [@"-" stringByAppendingString:_calculationString];
    }
    [self updatecalculationView];
}
- (BOOL)hasDecimalPlaces: (double)operand1 _:(double)operand2 {
    if ((int)operand1 != operand1) {
        return true;
    }
    if ((int)operand2 != operand2) {
        return true;
    }
    return false;
}
- (IBAction)tangent:(id)sender {
    double input = [_calculationString doubleValue];
    _calculationString = [NSString stringWithFormat:@"%.02f",tan(input) ];
    [self updatecalculationView];
}
- (void)commitAction {
    double operand1 = [_savedOperand doubleValue];
    double operand2 = [_calculationString doubleValue];
    double total = 0;
    switch (_currentAction) {
        case multiply: {
            total = operand1 * operand2;
            break;
        }
        case subtract:
            total = operand1 - operand2;
            break;
        case add:
            total = operand1 + operand2;
            break;
        default:
            break;
    }
    if ([self hasDecimalPlaces:operand1 _:operand2]) {
        _calculationString = [NSString stringWithFormat:@"%.02f", total];
    } else {
        _calculationString = [NSString stringWithFormat:@"%d", (int)total];
    }
    [self updatecalculationView];
}
- (IBAction)actionPressed:(id)sender {
    switch (((UIButton *)sender).tag) {
        case equal:
            [self commitAction];
            break;
        default:
            [self saveOperand];
            _currentAction = ((UIButton *)sender).tag;
            break;
    }
}

@end
