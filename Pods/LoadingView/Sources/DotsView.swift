//
//  DotsView.swift
//  LoadingView
//
//  Created by Leoan Ranjit on 8/19/22.
//

import UIKit

public class DotsView: UIView {

    //MARK: - Variables
    open var dotSize: CGFloat = UIScreen.main.bounds.height * 0.009
    @IBInspectable
    var _dotSize: CGFloat = UIScreen.main.bounds.height * 0.009 {
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

    open var spacing: CGFloat = UIScreen.main.bounds.width * 0.009
    @IBInspectable
    var _spacing: CGFloat = UIScreen.main.bounds.height * 0.009 {
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

    open var translation: CGFloat = (UIScreen.main.bounds.height * 0.01) / 2
    @IBInspectable
    var _translation: CGFloat = (UIScreen.main.bounds.height * 0.01) / 2 {
        didSet {
            translation = _translation
        }
    }

    let view1 = UIView()
    let view2 = UIView()
    let view3 = UIView()

    lazy var stackView: UIStackView = {
        let stk = UIStackView()
        stk.translatesAutoresizingMaskIntoConstraints = false
        stk.axis = .horizontal
        stk.distribution = .equalSpacing
        stk.alignment = .center
        stk.spacing = spacing
        stk.addArrangedSubview(view1)
        stk.addArrangedSubview(view2)
        stk.addArrangedSubview(view3)
        return stk
    }()

    // MARK: - Initializer Functions
    override init(frame: CGRect) {
        super.init(frame: frame)
        setDesign()
    }

    public override func willMove(toWindow newWindow: UIWindow?) {
        super.willMove(toWindow: newWindow)
        startAnimation()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setDesign()
        fatalError("init(coder:) has not been implemented")
    }

    public override func layoutSubviews() {
        super.layoutSubviews()
        setDesign()
    }

    func setDesign() {

        DispatchQueue.main.async {
            self.view1.layer.cornerRadius = self.view1.layer.frame.width / 2
            self.view1.clipsToBounds = true
            self.view2.layer.cornerRadius = self.view2.layer.frame.width / 2
            self.view2.clipsToBounds = true
            self.view3.layer.cornerRadius = self.view3.layer.frame.width / 2
            self.view3.clipsToBounds = true
        }

        //View 1
        view1.backgroundColor = dotOneColor
        view1.heightAnchor.constraint(equalToConstant: dotSize).isActive = true
        view1.widthAnchor.constraint(equalToConstant: dotSize).isActive = true
        view1.alpha = 0

        //View 2
        view2.backgroundColor = dotTwoColor
        view2.heightAnchor.constraint(equalToConstant: dotSize).isActive = true
        view2.widthAnchor.constraint(equalToConstant: dotSize).isActive = true
        view2.alpha = 0

        //View 3
        view3.backgroundColor = dotThreeColor
        view3.heightAnchor.constraint(equalToConstant: dotSize).isActive = true
        view3.widthAnchor.constraint(equalToConstant: dotSize).isActive = true
        view3.alpha = 0

        setLayout()

    }

    func setLayout() {

        self.addSubview(stackView)
        //Layout for Stack View
        stackView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        stackView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true

        startAnimation()

    }

    func startAnimation() {

        //Animating Views
        UIView.animate(withDuration: 0.2) {
            self.view1.alpha = 1
            self.view2.alpha = 1
            self.view3.alpha = 1
        }

        UIView.animate(withDuration: TimeInterval(duration), delay: 0, options: [.repeat, .autoreverse], animations: {
                self.view1.transform = CGAffineTransform(translationX: 0, y: -self.translation / 2)
                self.view1.transform = CGAffineTransform(translationX: 0, y: self.translation / 2)
            })

        UIView.animate(withDuration: TimeInterval(self.duration), delay: self.duration / 2, options: [.repeat, .autoreverse], animations: {
                self.view2.transform = CGAffineTransform(translationX: 0, y: -self.translation / 2)
                self.view2.transform = CGAffineTransform(translationX: 0, y: self.translation / 2)
            })

        UIView.animate(withDuration: TimeInterval(self.duration), delay: self.duration, options: [.repeat, .autoreverse], animations: {
                self.view3.transform = CGAffineTransform(translationX: 0, y: -self.translation / 2)
                self.view3.transform = CGAffineTransform(translationX: 0, y: self.translation / 2)
            })

    }

}
