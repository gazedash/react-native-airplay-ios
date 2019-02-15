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
    
    NSURL *url = [NSURL URLWithString:@"https://github.com/gazedash/react-native-airplay-btn/raw/icons/ios/Media.xcassets/Airplay-disabled.imageset/Airplay-disabled.png"];
    NSData *data = [NSData dataWithContentsOfURL:url];

    [volumeView setRouteButtonImage:[[UIImage alloc] initWithData:data] forState:UIControlStateNormal];
    [volumeView setRouteButtonImage:[[UIImage alloc] initWithData:data] forState:UIControlStateHighlighted];
    [volumeView setRouteButtonImage:[[UIImage alloc] initWithData:data] forState:UIControlStateSelected];
    [volumeView setRouteButtonImage:[[UIImage alloc] initWithData:data] forState:UIControlStateFocused];
    [volumeView setRouteButtonImage:[[UIImage alloc] initWithData:data] forState:UIControlStateDisabled];

    return volumeView;

}
@end
