//
//  ViewController.m
//  lights
//
//  Created by nipun arora on 10/10/16.
//  Copyright © 2016 nipun arora. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.switch1
     addTarget:self action:@selector(stateChanged:) forControlEvents:UIControlEventValueChanged];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
static NSString * res;
static id json;
static int i;



- (void)stateChanged:(UISwitch *)switchState
{
    if ([switchState isOn]) {
        //self.textview.text = @"The Switch is On";
        NSURLSession *session = [NSURLSession sharedSession];
        [[session dataTaskWithURL:[NSURL URLWithString:@"https://sheets.googleapis.com/v4/spreadsheets/1PsgPVOqRXFj4QQ41S0Xx_eiN6OS3CvRVZno5t2Nk8NQ/values/A1:B2?key=AIzaSyCxr5S6o0eAwNkUB91RYHEenuiQQf51Ylo"]
                completionHandler:^(NSData *data,
                                    NSURLResponse *response,
                                    NSError *error) {
                   
                   json = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
                    res=[json objectForKey:@"values"];
                    NSLog(@"this is the parsed two%@",[json objectForKey:@"values"]);
                    dispatch_async(dispatch_get_main_queue(),^{
                        //perform all UI stuff here
                        self.textview.text=[NSString stringWithFormat:@"%@",res];
                    });
                  
                               }] resume];
        
        //self.textview.text=[NSString stringWithFormat:@"%@",res];

        
    } else {
        self.textview.text = @"The Switch is Off";
    }
}

@end
