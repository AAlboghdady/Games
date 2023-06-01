//
//  BaseVC.swift
//  Games
//
//  Created by Abdurrahman Alboghdady on 01/06/2023.
//

import UIKit

class BaseVC: UIViewController {

    var indicator = UIActivityIndicatorView()
    
    var isLoading: Bool = false {
        didSet {
            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }
                self.isLoading ? self.indicator.startAnimating() : self.indicator.stopAnimating()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        indicator.center = view.center
        view.addSubview(indicator)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
}
