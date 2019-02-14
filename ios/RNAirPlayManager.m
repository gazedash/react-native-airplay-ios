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

    [volumeView setRouteButtonImage:[UIImage imageNamed:@"Airplay-normal"] forState:UIControlStateNormal];
    [volumeView setRouteButtonImage:[UIImage imageNamed:@"Airplay-highlighted"] forState:UIControlStateHighlighted];
    [volumeView setRouteButtonImage:[UIImage imageNamed:@"Airplay-selected"] forState:UIControlStateSelected];
    [volumeView setRouteButtonImage:[UIImage imageNamed:@"Airplay-focused"] forState:UIControlStateFocuesd];
    [volumeView setRouteButtonImage:[UIImage imageNamed:@"Airplay-disabled"] forState:UIControlStateDisabled];

    return volumeView;

}
@end
