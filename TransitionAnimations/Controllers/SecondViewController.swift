//
//  SecondViewController.swift
//  TransitionAnimations
//
//  Created by vitali on 12/2/18.
//  Copyright © 2018 vitcopr. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    //MARK: - Actions
    
    @IBAction func dismissController(_ sender: UITapGestureRecognizer) {
        dismiss(animated: true, completion: nil)
    }
    

}
