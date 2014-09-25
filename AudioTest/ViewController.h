//
//  ViewController.h
//  AudioTest
//
//  Created by yousheng chang on 9/24/14.
//  Copyright (c) 2014 InfoTech Inc. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface ViewController : UIViewController
@property (strong, nonatomic) IBOutlet UIButton *audioControlButton;
@property (nonatomic)BOOL isPlaying;

- (IBAction)audioControlButtonPressed:(UIButton *)sender;
- (IBAction)stopButtonPressed:(UIButton *)sender;

@end

