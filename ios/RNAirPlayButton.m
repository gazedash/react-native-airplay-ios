#import "RNAirplay.h"
#import "RNAirplayButton.h"
#import <React/RCTBridge.h>
#import <MediaPlayer/MediaPlayer.h>

@implementation RNAirplayButton

RCT_EXPORT_MODULE();

- (UIView *)view {
    
    CGRect viewRect = CGRectMake(0, 0, 40, 40);

    UIView* wrapperView = [[UIView alloc] initWithFrame: viewRect];
    
    wrapperView.translatesAutoresizingMaskIntoConstraints = false;
    wrapperView.backgroundColor = [UIColor clearColor];
    MPVolumeView *volumeView = [[MPVolumeView alloc] initWithFrame: wrapperView.bounds];
    volumeView.showsVolumeSlider = false;
    [wrapperView addSubview: volumeView];
    [volumeView sizeToFit];
    
    return wrapperView;

}
@end
