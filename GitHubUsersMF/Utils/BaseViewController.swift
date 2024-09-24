//
//  BaseViewController.swift
//  GitHubUsersMF
//
//  Created by Shashi Nishantha on 9/21/24.
//

import UIKit
import SnapKit
import SVProgressHUD

class BaseViewController: UIViewController {
    
    let screenWidth = UIScreen.main.bounds.size.width
    let screenHeight = UIScreen.main.bounds.size.width

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .systemBackground
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    func showProgress(){
        SVProgressHUD.show()
    }
    
    func hideProgress(){
        SVProgressHUD.dismiss()
    }
}
