//
//  BrightnessViewController.h
//  AudioLab
//
//  Created by Austin Chen on 9/22/17.
//  Copyright © 2017 Eric Larson. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#ifndef BrightnessViewController_h
#define BrightnessViewController_h
@interface BrightnessViewController : NSObject

-(void)initialize;
-(void)start;
-(void)playAudio;
-(bool)getAlarmToggle;


@end
#endif /* BrightnessViewController */
