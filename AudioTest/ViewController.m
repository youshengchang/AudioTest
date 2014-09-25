//
//  ViewController.m
//  AudioTest
//
//  Created by yousheng chang on 9/24/14.
//  Copyright (c) 2014 InfoTech Inc. All rights reserved.
//

#import "ViewController.h"
#import <AVFoundation/AVFoundation.h>

@interface ViewController ()<AVAudioPlayerDelegate>


@property (strong, nonatomic) AVAudioPlayer *audioPlayer;

@property (strong, nonatomic) NSData *songData;
@property (nonatomic) dispatch_queue_t myQueue;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    NSBundle *mainBundle = [NSBundle mainBundle];
    
    NSString *filePath = [mainBundle pathForResource:@"MySong" ofType:@"mp3"];
    
    NSData *fileData = [NSData dataWithContentsOfFile:filePath];
    
    self.songData = fileData;
    
    dispatch_queue_t dispatchQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    
    self.myQueue = dispatchQueue;
    
    dispatch_async(self.myQueue, ^{
 
        
        NSError *error = nil;
        
        //Start the audio player
        self.audioPlayer = [[AVAudioPlayer alloc]initWithData:self.songData error:&error];
        
      });
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag
{
    NSLog(@"Finishing playing the song");
    
    if([player isEqual:self.audioPlayer]){
        self.audioPlayer = nil;
    }else{
        //?
    }
}

-(void)audioPlayerBeginInterruption:(AVAudioPlayer *)player{
    //audio session is interrupted. The player will paused here
}

-(void)audioPlayerEndInterruption:(AVAudioPlayer *)player withFlags:(NSUInteger)flags
{
    if(flags == AVAudioSessionInterruptionOptionShouldResume && player != nil){
        [player play];
    }
}

- (IBAction)audioControlButtonPressed:(UIButton *)sender {
    
    if(self.audioPlayer == nil){
        dispatch_async(self.myQueue, ^{
            
            NSError *error = nil;
            
            //Start the audio player
            self.audioPlayer = [[AVAudioPlayer alloc]initWithData:self.songData error:&error];
            if(error){
                NSLog(@"%@", error);
            }
            
        });
        
        self.audioPlayer.delegate = self;
        while (!([self.audioPlayer prepareToPlay] && [self.audioPlayer play]));
        
        if([self.audioPlayer prepareToPlay] && [self.audioPlayer play]){
            //start to play
            [self.audioControlButton setTitle:@"Pause" forState:UIControlStateNormal];
            
            
        }else{
            //fail to play
            NSLog(@"fail to play after instantiate the audioPlayer");
            
        }

        
    }else{
        if(![self.audioPlayer isPlaying])
        {
            //did we get an instance of AudioPlayer
            if(self.audioPlayer != nil)
            {
                //set the delegate and start playing
                self.audioPlayer.delegate = self;
                if([self.audioPlayer prepareToPlay] && [self.audioPlayer play]){
                    //start to play
                    [self.audioControlButton setTitle:@"Pause" forState:UIControlStateNormal];
                    
                }else{
                    //fail to play
                    NSLog(@"fail to play but audioPlayer is there");
                }
            }
            else
            {
                //fail to instantiate AVAudioPlayer
                
                
                
            }
            
        }else{
            
                [self.audioPlayer pause];
                [self.audioControlButton setTitle:@"Play" forState:UIControlStateNormal];
                
        }

        
        
    }

 }

- (IBAction)stopButtonPressed:(UIButton *)sender {
    
    if([self.audioPlayer isPlaying]){
       
        [self.audioControlButton setTitle:@"Play" forState:UIControlStateNormal];
        [self.audioPlayer stop];
        self.audioPlayer = nil;
        
    }
}
@end
