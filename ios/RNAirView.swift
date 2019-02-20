import Foundation
import UIKit
import MediaPlayer

@objc(RNAirView) class RNAirView:UIView {
    var _volumeView: MPVolumeView? = nil
    var source: Dictionary<String, String>?

    @objc public func setSource(_ source: Dictionary<String, String>) {
        self.source = source
        let normal = source["normal"]
        let highlighted = source["highlighted"]
        let selected = source["selected"]
        let focused = source["focused"]
        let disabled = source["disabled"]

        if let vv = self._volumeView {
            if let normalImage = self.getImage(source: normal) {
                vv.setRouteButtonImage(normalImage, for: .normal)
            }
            if let highlightedImage = self.getImage(source: highlighted) {
                vv.setRouteButtonImage(highlightedImage, for: .highlighted)
            }
            if let selectedImage = self.getImage(source: selected) {
                vv.setRouteButtonImage(selectedImage, for: .selected)
            }
            if let focusedImage = self.getImage(source: focused) {
                if #available(iOS 9.0, *) {
                    vv.setRouteButtonImage(focusedImage, for: .focused)
                }
            }
            if let disabledImage = self.getImage(source: disabled) {
                vv.setRouteButtonImage(disabledImage, for: .disabled)
            }
        }
    }

    func getImage(source: String?) -> UIImage? {
        if source == nil {
            return nil
        }
        let data : Data = Data(base64Encoded: source!, options: .ignoreUnknownCharacters)!

        return UIImage(data:data)
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        if _volumeView == nil {
            embed()
        }
    }

    private func embed() {
        let volumeView = MPVolumeView()
        volumeView.showsVolumeSlider = false;
        volumeView.sizeToFit()
        self._volumeView = volumeView
        if (source != nil) {
            setSource(self.source!)
        }
        addSubview(volumeView)
        self.frame = volumeView.frame;
    }

     override init(frame: CGRect) {
        super.init(frame: frame)
    }

     required init?(coder aDecoder: NSCoder) { fatalError("nope") }
     
}
