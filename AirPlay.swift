

import Foundation
import MediaPlayer

@objc(AirPlay)
class AirPlay: RCTEventEmitter {

  @objc func startScan() {
      print("init Airplay");
      let currentRoute = AVAudioSession.sharedInstance().currentRoute
      print("currentRoute", currentRoute)
      var isAvailable = false
      if(currentRoute.outputs.count > 0) {
        isAvailable = true
        for output in currentRoute.outputs {
          if output.portType == AVAudioSessionPortAirPlay {
            self.sendEvent(withName: "airplayConnected", body: ["connected": true])
          }
        }
        NotificationCenter.default.addObserver(
          self,
          selector: #selector(AirPlay.airplayChanged(sender:)),
          name: NSNotification.Name.AVAudioSessionRouteChange,
          object: AVAudioSession.sharedInstance())
      }
      self.sendEvent(withName: "airplayAvailable", body: ["available": isAvailable])
    }

  func airplayChanged(sender: NSNotification) {
    let currentRoute = AVAudioSession.sharedInstance().currentRoute
    var isAirPlayPlaying = false

    for output in currentRoute.outputs {
      if output.portType == AVAudioSessionPortAirPlay {
        print("Airplay Device connected with name: \(output.portName)")
        isAirPlayPlaying = true
        break;
      }
    }
    self.sendEvent(withName: "airplayConnected", body: ["connected": isAirPlayPlaying])
    if(!isAirPlayPlaying) {
      startScan()
    }
  }

  @objc func isAlreadyConnected(callback: RCTResponseSenderBlock) -> Void {
    let currentRoute = AVAudioSession.sharedInstance().currentRoute
    for output in currentRoute.outputs {
      if output.portType == AVAudioSessionPortAirPlay {
        print("Airplay Device connected with name: \(output.portName)")
        callback([NSNull(), true])
        //return true
      }
    }
    callback([NSNull(), false])
    //return false
  }
  override func supportedEvents() -> [String]! {
    return ["airplayConnected", "airplayAvailable"]
  }

}

@objc(AirPlayButton)
class AirPlayButton: RCTViewManager {
  override func view() -> UIView! {
    let wrapperView = UIView(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
    wrapperView.translatesAutoresizingMaskIntoConstraints = false
    let volumneView = MPVolumeView(frame: wrapperView.bounds)
    volumneView.showsVolumeSlider = false
    wrapperView.addSubview(volumneView)

    volumneView.sizeToFit()

    return wrapperView
  }
}
