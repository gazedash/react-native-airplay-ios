#ifndef RNAirplay_RCTViewManager_h
#define RNAirplay_RCTViewManager_h

#import <React/RCTViewManager.h>
#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <MediaPlayer/MediaPlayer.h>

@interface RNAirplayManager : RCTViewManager

@property (nonatomic, assign) NSString *src;
@property (nonatomic, strong) MPVolumeView *volumeView;

@end

#endif
