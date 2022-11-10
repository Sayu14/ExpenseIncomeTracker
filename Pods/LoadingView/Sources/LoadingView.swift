//
//  LoadingIndicators.swift
//  InteractiveButtons
//
//  Created by Leoan Ranjit on 5/13/22.
//

import Foundation
import UIKit

enum Color {
    case black
    case white
}

enum Direction: String {
    case inward = "inward"
    case outward = "outward"
}

public enum LoadingType {
    case dots
    case indicator
}

public class LoadingView: UIView {

    @IBInspectable
    var expandSize: CGFloat {
        get {
            return size
        }
        set {
            self.size = newValue
        }
    }

    @IBInspectable
    var cornerRadius: CGFloat {
        get {
            return self.layer.cornerRadius
        }
        set {
            self.layer.cornerRadius = newValue
        }
    }

    @IBInspectable
    var borderWidth: CGFloat {
        get {
            return self.layer.borderWidth
        }
        set {
            self.layer.borderWidth = newValue
        }
    }

    @IBInspectable
    var borderColor: UIColor {
        get {
            return UIColor(cgColor: self.layer.borderColor ?? UIColor(displayP3Red: 0, green: 0, blue: 0, alpha: 0).cgColor)
        }
        set {
            self.layer.borderColor = newValue.cgColor
        }
    }

    @IBInspectable
    var shadowColor: UIColor {
        get {
            return UIColor(cgColor: self.layer.shadowColor ?? UIColor(displayP3Red: 0, green: 0, blue: 0, alpha: 0).cgColor)
        }
        set {
            self.layer.shadowColor = newValue.cgColor
        }
    }

    @IBInspectable
    var shadowOpacity: Float {
        get {
            return self.layer.shadowOpacity
        }
        set {
            self.layer.shadowOpacity = newValue
        }
    }

    @IBInspectable
    var shadowRadius: CGFloat {
        get {
            return self.layer.shadowRadius
        }
        set {
            self.layer.shadowRadius = newValue
        }
    }

    @IBInspectable
    var shadowOffset: CGSize {
        get {
            return self.layer.shadowOffset
        }
        set {
            self.layer.shadowOffset = newValue
        }
    }

    open var dotSize: CGFloat = 6.0
    @IBInspectable
    var _dotSize: CGFloat = 6.0 {
        didSet {
            dotSize = _dotSize
        }
    }

    open var dotOneColor: UIColor = .black
    @IBInspectable
    var _dotOneColor: UIColor = .white {
        didSet {
            dotOneColor = _dotOneColor
        }
    }

    open var dotTwoColor: UIColor = .black
    @IBInspectable
    var _dotTwoColor: UIColor = .white {
        didSet {
            dotTwoColor = _dotTwoColor
        }
    }

    open var dotThreeColor: UIColor = .black
    @IBInspectable
    var _dotThreeColor: UIColor = .white {
        didSet {
            dotThreeColor = _dotThreeColor
        }
    }

    open var spacing: CGFloat = 3
    @IBInspectable
    var _spacing: CGFloat = 3 {
        didSet {
            spacing = _spacing
        }
    }

    open var duration: CGFloat = 0.4
    @IBInspectable
    var _duration: CGFloat = 0.4 {
        didSet {
            duration = _duration
        }
    }

    open var translation: CGFloat = 3
    @IBInspectable
    var _translation: CGFloat = 3 {
        didSet {
            translation = _translation
        }
    }

    var btnTitle = ""
    var btnImage = UIImage()
    var isLoading = false
    var size = 0.97

    let container = UIView(frame: CGRect.zero)
    let spinner = UIActivityIndicatorView(activityIndicatorStyle: .gray)
    let spinnerView = UIView()

    // MARK: - ViewController Functions
    public override func layoutSubviews() {
        super.layoutSubviews()
        self.clipsToBounds = true
        DispatchQueue.main.async {
            self.container.layer.cornerRadius = self.container.bounds.height / 2
            self.container.layer.shadowColor = UIColor.black.cgColor
            self.container.layer.shadowOffset = CGSize(width: 0, height: 0)
            self.container.layer.shadowRadius = 8
            self.container.layer.shadowOpacity = 0.1
            self.container.backgroundColor = .white
            self.container.alpha = 1
        }
    }

    public func startLoading(type: LoadingType) {

        if !isLoading {

            isLoading = true

            switch type {

            case .dots:

                self.addSubview(container)
                container.translatesAutoresizingMaskIntoConstraints = false

                NSLayoutConstraint.activate([
                    container.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height * 0.05),
                    container.widthAnchor.constraint(equalTo: self.container.heightAnchor, multiplier: 1.8),
                    container.topAnchor.constraint(equalTo: self.topAnchor, constant: -container.bounds.height),
                    container.centerXAnchor.constraint(equalTo: self.centerXAnchor),

                    ])

                let loadingView = DotsView(frame: container.frame)
                
                loadingView.dotOneColor = dotOneColor
                
                loadingView.dotTwoColor = dotTwoColor
                
                loadingView.dotThreeColor = dotThreeColor

                loadingView.translatesAutoresizingMaskIntoConstraints = false

                self.container.addSubview(loadingView)

                NSLayoutConstraint.activate([

                    loadingView.centerXAnchor.constraint(equalTo: container.centerXAnchor),

                    loadingView.centerYAnchor.constraint(equalTo: container.centerYAnchor)

                    ])

                UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: CGFloat(0.80), initialSpringVelocity: CGFloat(10), options: UIView.AnimationOptions.allowUserInteraction, animations: {
                        self.container.transform = CGAffineTransform(translationX: 0, y: self.container.bounds.height + 8)
                    })

            case .indicator:

                spinner.backgroundColor = .clear
                spinner.translatesAutoresizingMaskIntoConstraints = false
                self.addSubview(spinnerView)
                spinnerView.addSubview(spinner)
                spinnerView.frame = self.bounds
                spinnerView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
                LoadingView.addConstraints(to: spinnerView, with: spinner)
                spinner.startAnimating()

            }

        }

    }

    public func stopLoading() {
        isLoading = false

        spinnerView.removeFromSuperview()

        UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: CGFloat(0.80), initialSpringVelocity: CGFloat(10), options: UIView.AnimationOptions.allowUserInteraction, animations: {
                self.container.transform = .identity
                self.container.alpha = 0
            }) { completed in
            self.container.removeFromSuperview()
        }

    }

    fileprivate static func addConstraints(to view: UIView, with spinner: UIActivityIndicatorView) {
        spinner.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        spinner.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        spinner.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        spinner.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
    }

}

extension UIViewController {

    public func startLoadingLeft(color: UIColor) {
        if #available(iOS 13.0, *) {
            let indicator = UIActivityIndicatorView(activityIndicatorStyle: .medium)
            indicator.color = color
            indicator.startAnimating()
            let barButton = UIBarButtonItem(customView: indicator)
            self.navigationItem.setLeftBarButton(barButton, animated: true)
        } else {
            let indicator = UIActivityIndicatorView(activityIndicatorStyle: .gray)
            indicator.color = color
            indicator.startAnimating()
            let barButton = UIBarButtonItem(customView: indicator)
            self.navigationItem.setLeftBarButton(barButton, animated: true)
        }
    }

    public func startLoadingRight(color: UIColor) {
        if #available(iOS 13.0, *) {
            let indicator = UIActivityIndicatorView(activityIndicatorStyle: .medium)
            indicator.color = color
            indicator.startAnimating()
            let barButton = UIBarButtonItem(customView: indicator)
            self.navigationItem.setRightBarButton(barButton, animated: true)
        } else {
            let indicator = UIActivityIndicatorView(activityIndicatorStyle: .gray)
            indicator.color = color
            indicator.startAnimating()
            let barButton = UIBarButtonItem(customView: indicator)
            self.navigationItem.setRightBarButton(barButton, animated: true)
        }
    }

    public func stopLoadingRight() {
        self.navigationItem.setRightBarButton(UIBarButtonItem(), animated: true)
    }

    public func stopLoadingLeft() {
        self.navigationItem.setLeftBarButton(UIBarButtonItem(), animated: true)
    }

}

extension UIView {

    public func startShimmering() {

        let light = UIColor(white: 0, alpha: 0.1).cgColor
        let dark = UIColor.black.cgColor

        let gradient: CAGradientLayer = CAGradientLayer()
        gradient.colors = [dark, light, dark]
        gradient.frame = CGRect(x: -bounds.size.width, y: 0, width: 3 * bounds.size.width, height: bounds.size.height)

        gradient.startPoint = CGPoint(x: 0.0, y: 0.5)
        gradient.endPoint = CGPoint(x: 1.0, y: 0.525)
        gradient.locations = [0.4, 0.5, 0.6]

        layer.mask = gradient

        let animation: CABasicAnimation = CABasicAnimation.init(keyPath: "locations")
        animation.fromValue = [0.0, 0.1, 0.2]
        animation.toValue = [0.8, 0.9, 1.0]

        animation.duration = 1.5
        animation.repeatCount = Float.greatestFiniteMagnitude
        animation.isRemovedOnCompletion = false

        gradient.add(animation, forKey: "shimmer")
    }

    public func stopShimmering() {
        layer.mask = nil
    }

    public func startSpinning(color: UIColor) {

        let spinners = self.subviews.filter { $0 is SpinnerView }
        if spinners.count < 1 {
            let view = SpinnerView()
            view.spinner.color = color
            self.addSubview(view)
            view.frame = self.bounds
            view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        }

    }

    public func startLoading(color: UIColor) {

        let dots = self.subviews.filter { $0 is DotsView }
        if dots.count < 1 {
            let view = DotsView()
            view.translatesAutoresizingMaskIntoConstraints = false
            view.dotOneColor = color
            view.dotTwoColor = color
            view.dotThreeColor = color
            self.addSubview(view)
            NSLayoutConstraint.activate([
                view.centerXAnchor.constraint(equalTo: centerXAnchor),
                view.centerYAnchor.constraint(equalTo: centerYAnchor)
            ])
        }

    }

    public func stopSpinning() {

        let spinners = self.subviews.filter { $0 is SpinnerView }
        let dots = self.subviews.filter { $0 is DotsView }
        if spinners.count > 0 {
            spinners[0].removeFromSuperview()
        }
        if dots.count > 0 {
            dots[0].removeFromSuperview()
        }

    }

}

extension UITableView {

    public func startLoading() {

        let loadingView = DotsView()

        self.backgroundView = loadingView

        NSLayoutConstraint.activate([

            loadingView.topAnchor.constraint(equalTo: self.topAnchor),

            loadingView.bottomAnchor.constraint(equalTo: self.bottomAnchor),

            loadingView.leadingAnchor.constraint(equalTo: self.leadingAnchor),

            loadingView.trailingAnchor.constraint(equalTo: self.trailingAnchor),

            ])

    }

    public func stopLoading() {

        UIView.transition(with: self, duration: 0.1, options: .transitionCrossDissolve, animations: {

            self.backgroundView = nil

        }, completion: nil)

    }

}



