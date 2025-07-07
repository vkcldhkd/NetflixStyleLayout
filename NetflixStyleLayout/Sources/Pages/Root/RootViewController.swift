//
//  RootViewController.swift
//  NetflixStyleLayout
//
//  Created by HYUN SUNG on 6/14/25.
//

import RIBs
import RxSwift
import RxCocoa
import UIKit

protocol RootPresentableListener: AnyObject {
}

final class RootViewController: BaseViewController {

    // MARK: - Properties
    weak var listener: RootPresentableListener?
    private var currentViewController: ViewControllable?
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        currentViewController?.uiviewController.view.pin.all()
        currentViewController?.uiviewController.view.flex.layout()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // MARK: - Test
//        CoreDataManager.shared.saveDummyRecentKeywords()
    }
}

extension RootViewController: RootPresentable, RootViewControllable {
    
}

extension RootViewController {
    func replaceScreen(viewController: ViewControllable) {
        let newVC = viewController.uiviewController
        let naviVC = BaseNavigationController(rootViewController: newVC)
        self.addChild(naviVC)
        self.view.addSubview(naviVC.view)
        
        // 2. PinLayout + Flex로 레이아웃 설정
        newVC.view.pin.all()
        newVC.view.flex.layout()
        
        // 3. 이전 VC 정리
        if let current = self.currentViewController?.uiviewController {
            current.willMove(toParent: nil)
            current.view.removeFromSuperview()
            current.removeFromParent()
        }
        
        // 4. 마무리
        newVC.didMove(toParent: self)
        self.currentViewController = viewController
    }
    
    func test() {
        let subject = PublishSubject<String>()
        subject.flatMapLatest { keyword in
            Observable<Int>.interval(.seconds(1), scheduler: MainScheduler.asyncInstance)
                .map { "\(keyword): \($0)" }
        }
        subject
            .asDriver(onErrorDriveWith: .empty())
            .drive(self.rx.title)
            .disposed(by: self.disposeBag)
        
    }
}
