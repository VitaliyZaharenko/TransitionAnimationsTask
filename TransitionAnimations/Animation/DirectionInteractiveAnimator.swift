//
//  ScaleInteractiveAnimator.swift
//  TransitionAnimations
//
//  Created by vitali on 12/3/18.
//  Copyright © 2018 vitcopr. All rights reserved.
//

import UIKit

fileprivate struct Const {
    
    static let panLenght: CGFloat = 0.3
}

class DirectionInteractiveAnimator: UIPercentDrivenInteractiveTransition {
    
    enum Direction {
        case left, right
        
        fileprivate var maskTuple: (CGFloat, CGFloat) {
            get {
                switch self {
                case .left:
                    return (-1.0, 0)
                case .right:
                    return (1.0, 0)
                }
            }
        }
        
        var opposite: Direction {
            get {
                switch self {
                case .left:
                    return .right
                case .right:
                    return .left
                }
            }
        }
        
        var title: String {
            get {
                switch self {
                case .left:
                    return "Left"
                case .right:
                    return "Right"
                }
            }
        }
    }
    
    //MARK: - Properties
    
    weak var sourceViewController: UIViewController? {
        didSet {
            addPresentGestureRecognizer()
        }
    }
    
    private var presentGestureRecognizer: UIScreenEdgePanGestureRecognizer?
    
    weak var destinationViewController: UIViewController? {
        didSet {
            destinationViewController?.transitioningDelegate = self
            addDismissGestureRecognizer()
        }
    }
    
    var direction: Direction = .left {
        didSet {
            setupDirection()
        }
    }
    
    private var animator: DirectionAnimator
    
    private var inProgress = false
    private var shouldComplete = false
    
    //MARK: - Initialzation
    
    override init(){
        self.animator = DirectionAnimator()
        super.init()
    }
    
    //MARK: - Callbacks
    
    @objc func handleGesture(sender: UIScreenEdgePanGestureRecognizer){
        
        let translation = sender.translation(in: sender.view!)
        
        let (multX, multY) = direction.maskTuple
        let (width, height) = (sender.view!.frame.width, sender.view!.frame.height)
        let (xLength, yLength): (CGFloat, CGFloat) = (width * Const.panLenght, height * Const.panLenght)
        
        let progressUnclamped = (multX * translation.x / xLength) + (multY * translation.y / yLength)
        
        var progress = Double(progressUnclamped)
        progress = Double.maximum(0.0, progress)
        progress = Double.minimum(1.0, progress)
        
        switch sender.state {
            
        case .began:
            
            inProgress = true
            if let destination = destinationViewController {
                sourceViewController?.present(destination, animated: true, completion: nil)//destinationController
            }
            
        
        case .changed:
            shouldComplete = progress > 0.5
            update(CGFloat(progress))
            
        case .cancelled:
            inProgress = false
            cancel()
            
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

extension DirectionInteractiveAnimator {
    
    func addPresentGestureRecognizer(){
        presentGestureRecognizer =  UIScreenEdgePanGestureRecognizer(target: self, action: #selector(handleGesture(sender:)))
        setupDirection()
        sourceViewController?.view.addGestureRecognizer(presentGestureRecognizer!)
    }
    
    func addDismissGestureRecognizer(){
        
    }
    
    func setupDirection(){
        switch self.direction {
        case .left:
            animator.transitionDirection = .left
            presentGestureRecognizer?.edges = .right
        case .right:
            animator.transitionDirection = .right
            presentGestureRecognizer?.edges = .left
        }
    }
}



//MARK: - UIViewContr
extension DirectionInteractiveAnimator: UIViewControllerTransitioningDelegate {
    
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

