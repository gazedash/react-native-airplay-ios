import Foundation
import UIKit
import MediaPlayer

extension UIView {
    var parentViewController: UIViewController? {
        var parentResponder: UIResponder? = self
        while parentResponder != nil {
            parentResponder = parentResponder!.next
            if let viewController = parentResponder as? UIViewController {
                return viewController
            }
        }
        return nil
    }
}

@objc(RNAirView) class RNAirView:UIView {
    var _volumeView: MPVolumeView? = nil
    var source: String?

    @objc public func setSource(_ source: String?) {
        let url = URL(string: source ?? "")
        let imageData = try? Data(contentsOf: url!)
        let image = UIImage(data:imageData!)
        self.source = source
        if let vv = self._volumeView {
        vv.setRouteButtonImage(image, for: .normal)
        vv.setRouteButtonImage(image, for: .highlighted)
        vv.setRouteButtonImage(image, for: .selected)
                    if #available(iOS 9.0, *) {
                vv.setRouteButtonImage(image, for: .focused)
                    }
        vv.setRouteButtonImage(image, for: .disabled)
        }
    }

        override func layoutSubviews() {
        super.layoutSubviews()

        if _volumeView == nil {
            embed()
        }
        // } else {
        //     _volumeView?.frame = bounds
        // }
    }

    private func embed() {
        let volumeView = MPVolumeView()
        // volumeView.frame = bounds
        volumeView.showsVolumeSlider = false;
        // volumeView.layer.borderWidth = 1
        // volumeView.layer.borderColor = UIColor(red:222/255, green:225/255, blue:227/255, alpha: 1).cgColor
        volumeView.sizeToFit()
        self._volumeView = volumeView

        setSource(self.source)
        addSubview(volumeView)
        self.frame = volumeView.frame;
        // self.sizeToFit()
    }

     override init(frame: CGRect) {
        super.init(frame: frame)
        print("hahahahahahahahaha init")

    }
     required init?(coder aDecoder: NSCoder) { fatalError("nope") }
    
    // override func viewDidLoad() {
    //     super.viewDidLoad()
    // }

//         override func viewDidAppear(_ animated: Bool) {
//         super.viewDidAppear(animated)
// print("hahahahahahahahaha view did appear hahah")
//     }
}
