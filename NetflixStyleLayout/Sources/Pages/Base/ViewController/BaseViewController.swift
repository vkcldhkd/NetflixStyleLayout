//
//  BaseViewController.swift
//  NetflixStyleLayout
//
//  Created by HYUN SUNG on 6/14/25.
//

import UIKit
import Then
import RxSwift
import PinLayout
import FlexLayout

class BaseViewController: UIViewController {
    
    // MARK: Properties
    lazy private(set) var className: String = {
        return type(of: self).description().components(separatedBy: ".").last ?? ""
    }()
    private var backgroundColor: UIColor
    let navigationBarData: NavigationBarData
    // MARK: Rx
    var disposeBag = DisposeBag()
    
    
    // MARK: Layout Constraints
    private(set) var didSetupConstraints = false
    
    // MARK: - UI
    let loadingView: UIActivityIndicatorView = UIActivityIndicatorView()
    let rootFlexContainer = UIView()
    
    // MARK: Initializing
    init(
        backgroundColor: UIColor = UIColor.white,
        barBackgroundColor: UIColor = UIColor.white,
        prefersHidden: Bool? = nil,
        isTranslucent: Bool? = nil,
        hidesBottomBarWhenPushed: Bool = true
    ) {
        self.backgroundColor = backgroundColor
        self.navigationBarData = type(of: self).navigationBarDataFactory(
            barBackgroundColor: barBackgroundColor,
            prefersHidden: prefersHidden ?? false,
            isTranslucent: isTranslucent ?? true
        )
        super.init(nibName: nil, bundle: nil)
        self.hidesBottomBarWhenPushed = hidesBottomBarWhenPushed
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        self.init()
    }
    
    deinit {
        print("DEINIT: \(self.className)")
    }
    
    
    // MARK: View Lifecycle
    override func viewDidLoad() {
        self.view.setNeedsUpdateConstraints()
        self.view.backgroundColor = self.backgroundColor
        self.view.addSubview(self.rootFlexContainer)
    }
    
    override func updateViewConstraints() {
        if !self.didSetupConstraints {
            self.setupConstraints()
            self.didSetupConstraints = true
        }
        super.updateViewConstraints()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(self.navigationBarData.prefersHidden, animated: true)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        let insets = self.view.safeAreaInsets
        self.rootFlexContainer.pin.all()
        self.rootFlexContainer.flex.padding(insets.top, .zero, insets.bottom, .zero)
        self.rootFlexContainer.flex.layout()
    }
    
    func setupConstraints() {
        // Override point
    }
}

private extension BaseViewController {
    private static func navigationBarDataFactory(
        barBackgroundColor: UIColor?,
        prefersHidden: Bool,
        isTranslucent: Bool
    ) -> NavigationBarData {
        return NavigationBarData(
            barBackgroundColor: barBackgroundColor ?? UIColor.white,
            prefersHidden: prefersHidden,
            isTranslucent: isTranslucent
        )
    }
}

extension BaseViewController {
    @objc func endEditing(){
        self.view.endEditing(true)
    }
    
    func loadingViewAddSubView() {
        self.loadingView.startAnimating()
        self.loadingView.hidesWhenStopped = true
        
        self.view.addSubview(self.loadingView)
    }
    
    func loadingViewConstraints(inset: CGFloat = 0) {
        self.loadingView.translatesAutoresizingMaskIntoConstraints = false

        // centerX 제약
        NSLayoutConstraint.activate([
            self.loadingView.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])

        // centerY 제약
        let centerYOffset = inset > 0 ? -inset : 0
        let centerYConstraint = self.loadingView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: centerYOffset)

        NSLayoutConstraint.activate([centerYConstraint])
    }
}
