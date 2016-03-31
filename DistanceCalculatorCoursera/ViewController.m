//
//  ViewController.m
//  DistanceCalculatorCoursera
//
//  Created by Cenker Demir on 3/29/16.
//  Copyright © 2016 Cenker Demir. All rights reserved.
//

#import "ViewController.h"
#import "DistanceGetter/DGDistanceRequest.h"

@interface ViewController ()

@property DGDistanceRequest *req;

@property (weak, nonatomic) IBOutlet UITextField *startLocation;

@property (weak, nonatomic) IBOutlet UITextField *endLocationA;
@property (weak, nonatomic) IBOutlet UILabel *distanceA;

@property (weak, nonatomic) IBOutlet UITextField *endLocationB;
@property (weak, nonatomic) IBOutlet UILabel *distanceB;

@property (weak, nonatomic) IBOutlet UITextField *endLocationC;
@property (weak, nonatomic) IBOutlet UILabel *distanceC;

@property (weak, nonatomic) IBOutlet UIButton *calculateButton;

@property (weak, nonatomic) IBOutlet UISegmentedControl *unitController;

@end

@implementation ViewController

- (IBAction)calculateButtonTapped:(id)sender {

    self.calculateButton.enabled = NO;
    
    self.req = [DGDistanceRequest alloc];
    NSString *start = self.startLocation.text;
    NSString *desA = self.endLocationA.text;
    NSString *desB = self.endLocationB.text;
    NSString *desC = self.endLocationC.text;
  
    
    NSArray *dests = @[desA, desB, desC];
   
    self.req = [self.req initWithLocationDescriptions:dests sourceDescription:start];
    
    __weak ViewController *weakSelf = self;
    
    self.req.callback = ^void(NSArray *responses){
        ViewController *strongSelf = weakSelf;
        if(!strongSelf) return;
        
        NSNull *badResult = [NSNull null];
        
        NSNumber *selected = [[NSNumber alloc] init];
        NSString *unit = [[NSString alloc] init];
        
        switch (strongSelf.unitController.selectedSegmentIndex) {
            case 0:
                selected = @1.00;
                unit = @"mt";
                break;
            case 1:
                selected = @1000.00;
                unit = @"km";
                break;
            case 2:
                selected = @1609.34;
                unit = @"mil";
                break;
            default:
                break;
        }
        
        if (responses[0] != badResult)
        {
            double num = ([responses[0] floatValue]/[selected floatValue]);
            NSString *x = [NSString stringWithFormat:@"%.2f %@", num, unit];
            strongSelf.distanceA.text = x;
        }
        else
        {
            strongSelf.distanceA.text = @"Error";
        }
        if (responses[1] != badResult)
        {
            double num = ([responses[1] floatValue]/[selected floatValue]);
            NSString *x = [NSString stringWithFormat:@"%.2f %@", num, unit];
            strongSelf.distanceB.text = x;
        }
        else
        {
            strongSelf.distanceB.text = @"Error";
        }
        if (responses[2] != badResult)
        {
            double num = ([responses[2] floatValue]/[selected floatValue]);
            NSString *x = [NSString stringWithFormat:@"%.2f %@", num, unit];
            strongSelf.distanceC.text = x;
        }
        else
        {
            strongSelf.distanceC.text = @"Error";
        }
        
        strongSelf.calculateButton.enabled = YES;
    };
    
    [self.req start];
}

@end






































