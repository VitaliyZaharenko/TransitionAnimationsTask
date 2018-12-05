//
//  ScaleInteractiveAnimator.swift
//  TransitionAnimations
//
//  Created by vitali on 12/3/18.
//  Copyright © 2018 vitcopr. All rights reserved.
//

import UIKit

class ScaleInteractiveAnimator: UIPercentDrivenInteractiveTransition {
    
    //MARK: - Properties
    
    private weak var controller: UIViewController!
    
    private var inProgress = false
    private var isTransitionTriggered = false
    
    //MARK: - Initialzation
    
    init(controller: UIViewController){
        super.init()
        
        self.controller = controller
        let recognizer =  UIPinchGestureRecognizer(target: self, action: #selector(onPinch(sender:)))
        controller.view.addGestureRecognizer(recognizer)
    }
    
    //MARK: - Callbacks
    
    @objc func onPinch(sender: UIPinchGestureRecognizer){
        
        switch sender.state {
        case .began:
            inProgress = true
        case .changed:
            print(sender.scale)
            isTransitionTriggered = sender.scale > 1.5
        case .ended:
            inProgress = false
            if isTransitionTriggered {
                finish()
            } else {
                cancel()
            }
        case .cancelled:
            cancel()
            
        default:
            return
        }
    }
    
}
