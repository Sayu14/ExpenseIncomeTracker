//
//  SpinnerView.swift
//  LoadingView
//
//  Created by Leoan Ranjit on 8/20/22.
//

import UIKit

class SpinnerView: UIView {

    let spinner = UIActivityIndicatorView(activityIndicatorStyle: .gray)

    // MARK: - Initializer Functions
    override init(frame: CGRect) {
        super.init(frame: CGRect.zero)
        setDesign()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setDesign() {

        spinner.backgroundColor = .clear
        spinner.startAnimating()

        setLayout()

    }

    func setLayout() {

        self.addSubview(spinner)
        spinner.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            spinner.topAnchor.constraint(equalTo: self.topAnchor),
            spinner.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            spinner.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            spinner.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            ])

    }

}
