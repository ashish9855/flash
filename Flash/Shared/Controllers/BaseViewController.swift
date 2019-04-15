//
//  BaseViewController.swift
//  Flash
//
//  Created by Ashish Maheshwari on 10.04.19.
//  Copyright © 2019 Ashish Maheshwari. All rights reserved.
//

import UIKit

var usingMocksForApi = UserDefaults.standard.bool(forKey: "useMockApi")

class BaseViewController: UIViewController {
    
    var showsNavigationBar: Bool = true
    let businessLayer = BusinessLayer()
    enum PresentationType {
        case present
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateNavigationBar()
    }
    
    private func updateNavigationBar() {
        navigationController?.isNavigationBarHidden = !showsNavigationBar
    }
    
    func showCloseButton() {
        let rightBarButton = UIBarButtonItem.init(barButtonSystemItem: .cancel, target: self, action: #selector(popViewController) )
        self.navigationItem.rightBarButtonItem = rightBarButton
    }
    
    @objc func popViewController() {
        self.dismiss(animated: true, completion: nil)
    }
    
    override func motionEnded(_ motion: UIEventSubtype, with event: UIEvent?) {
        if motion == .motionShake {
            UserDefaults.standard.set(!usingMocksForApi, forKey: "useMockApi")
            let title = usingMocksForApi ? "Switched to real API" : "Switched to Mock API"
            let alert = UIAlertController.init(title: title, message: "Please restart app", preferredStyle: .alert)
            present(alert, animated: true, completion: nil)
        }
    }
}
