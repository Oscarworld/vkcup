import UIKit

class SpinnerView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    private func setupView() {
        backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.12)
        let ai = UIActivityIndicatorView(style: .whiteLarge)
        ai.startAnimating()
        ai.center = center
        addSubview(ai)
    }
}

extension UIViewController {
    func showSpinner(onView : UIView) {
        guard onView.subviews.first(where: { $0 is SpinnerView }) == nil else { return }
            
        DispatchQueue.main.async {
            let spinnerView = SpinnerView(frame: onView.bounds)
            onView.addSubview(spinnerView)
        }
    }
    
    func removeSpinner(fromView: UIView) {
        if let spinnerView = fromView.subviews.first(where: { $0 is SpinnerView }) {
            spinnerView.removeFromSuperview()
        }
    }
}
