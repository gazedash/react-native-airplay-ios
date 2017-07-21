#import "RNAirplayManager.h"
#import "RNAirplay.h"
#import <React/RCTBridge.h>
#import <React/UIView+React.h>
#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>
#import <MediaPlayer/MediaPlayer.h>

@implementation RNAirplayManager

RCT_EXPORT_MODULE();

@synthesize bridge = _bridge;

- (UIView *)view {

    MPVolumeView *volumeView = [[MPVolumeView alloc] init];
    volumeView.showsVolumeSlider = false;

    return volumeView;

}
@end
