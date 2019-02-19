#import "RNAirplayManager.h"
#import "RNAirplay.h"
#import "RNAirplay-swift.h"
#import <React/RCTBridge.h>
#import <React/UIView+React.h>
#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>
#import <MediaPlayer/MediaPlayer.h>

@implementation RNAirplayManager

RCT_EXPORT_MODULE();

- (UIViewController *)view {
    return [RNAirView new];
}

RCT_EXPORT_VIEW_PROPERTY(source, NSDictionary*)

@end
