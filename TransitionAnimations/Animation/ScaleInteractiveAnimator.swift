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
    
    weak var sourceViewController: UIViewController? {
        didSet {
            addPresentGestureRecognizer()
        }
    }
    
    weak var destinationViewController: UIViewController? {
        didSet {
            destinationViewController?.transitioningDelegate = self
            addDismissGestureRecognizer()
        }
    }
    
    private var animator: DirectionAnimator
    
    private var inProgress = false
    private var shouldComplete = false
    
    //MARK: - Initialzation
    
    init(animator: DirectionAnimator){
        self.animator = animator
        super.init()
    }
    
    //MARK: - Callbacks
    
    @objc func handleGesture(sender: UIScreenEdgePanGestureRecognizer){
        
        let translation = sender.translation(in: sender.view!)
        
        let progressUnclamped = Double(-(translation.x / 200))
        var progress = Float((0.0 ... 1.0).clamped(to: progressUnclamped))
        //progress = CGFloat(fminf(fmaxf(Float(progress), 0.0), 1.0))
        
        switch sender.state {
            
        // 2
        case .began:
            print("Begin")
            inProgress = true
            if let destination = destinationViewController {
                
                sourceViewController?.present(destination, animated: true, completion: nil)//destinationController
            }
            
            //viewController.dismiss(animated: true, completion: nil)
            
        // 3
        case .changed:
            print("Changed, \(shouldComplete), \(progress)")
            shouldComplete = progress > 0.5
            update(progress)
            
        // 4
        case .cancelled:
            inProgress = false
            cancel()
            
        // 5
        case .ended:
            inProgress = false
            if shouldComplete {
                finish()
            } else {
                cancel()
            }
        default:
            break
        }
    }
    
}

//MARK: - Private Helper Methods

extension ScaleInteractiveAnimator {
    
    func addPresentGestureRecognizer(){
        let recognizer =  UIScreenEdgePanGestureRecognizer(target: self, action: #selector(handleGesture(sender:)))
        recognizer.edges = .right
        sourceViewController?.view.addGestureRecognizer(recognizer)
    }
    
    func addDismissGestureRecognizer(){
        
    }
}



//MARK: - UIViewContr
extension ScaleInteractiveAnimator: UIViewControllerTransitioningDelegate {
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        animator.isDismissed = false
        return animator
    }

    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        animator.isDismissed = true
        return animator
    }

    func interactionControllerForPresentation(using animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        return self
    }
    
    func interactionControllerForDismissal(using animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        return self
    }
}

