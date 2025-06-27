//
//  DetailViewController.swift
//  NetflixStyleLayout
//
//  Created by HYUN SUNG on 6/27/25.
//

import RIBs
import ReactorKit
import RxSwift
import UIKit

protocol DetailPresentableListener: AnyObject {
    // TODO: Declare properties and methods that the view controller can invoke to perform
    // business logic, such as signIn(). This protocol is implemented by the corresponding
    // interactor class.
    func didRequestCloseDetail()
}

final class DetailViewController: BaseViewController {
    // MARK: Constants
    
    // MARK: Properties
    weak var listener: DetailPresentableListener?
    
    // MARK: UI
    
    // MARK: Initializing
    init() {
//        defer { self.reactor = reactor }
        super.init()
    }
    
    required convenience init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

private extension DetailViewController {
    // MARK: - setupUI
    func setupUI() {
        
    }
}

extension DetailViewController: DetailPresentable, DetailViewControllable {
    
}

extension DetailViewController: UIAdaptivePresentationControllerDelegate {
    func presentationControllerDidDismiss(
        _ presentationController: UIPresentationController
    ) {
        print("Dismiss")
        self.listener?.didRequestCloseDetail()
    }
}
