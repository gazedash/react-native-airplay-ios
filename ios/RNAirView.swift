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

    @objc public func setSource(_ source: String) {
        let url = URL(string: source ?? "")
        let imageData = try? Data(contentsOf: url!)
        let image = UIImage(data:imageData!)
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
        } else {
            _volumeView?.view.frame = bounds
        }
    }

    private func embed() {
    //  guard
            let parentVC = parentViewController,
        //     else {
        //     return
        // }

        let volumeView = MPVolumeView()
        let doc = PSPDFDocument(url: documentURL)
        let vc = volumeView
        parentVC.addChild(vc)
        addSubview(vc.view)
        vc.view.frame = bounds
        vc.didMove(toParentViewController: parentVC)
        self._volumeView = vc

        vc.showsVolumeSlider = true;
        vc.layer.borderWidth = 1
        vc.frame = bounds
        vc.layer.borderColor = UIColor(red:222/255, green:225/255, blue:227/255, alpha: 1).cgColor
        // self.addSubview(volumeView)
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
