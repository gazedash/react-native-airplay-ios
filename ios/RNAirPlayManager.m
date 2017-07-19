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
    
    CGRect viewRect = CGRectMake(0, 0, 40, 40);
    
    UIView* wrapperView = [[UIView alloc] initWithFrame: viewRect];
    
    wrapperView.translatesAutoresizingMaskIntoConstraints = false;
    MPVolumeView *volumeView = [[MPVolumeView alloc] initWithFrame: wrapperView.bounds];
    volumeView.showsVolumeSlider = false;
    [wrapperView addSubview: volumeView];
    [volumeView sizeToFit];
    
    return wrapperView;
    
}
@end
