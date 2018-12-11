//
//  ViewController.swift
//  TransitionAnimations
//
//  Created by vitali on 12/2/18.
//  Copyright © 2018 vitcopr. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController {
    
    //MARK: - Properties
    
    private let transitionAnimator: DirectionAnimator = {
        let animator = DirectionAnimator()
        animator.transitionDirection = .right
        return animator
    }()
    
    private var scaleAnimator: ScaleInteractiveAnimator!
    
    private var destinationController: UIViewController!
    
    
    //MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        destinationController = createDestinationController()
        scaleAnimator = ScaleInteractiveAnimator(animator: transitionAnimator)
        scaleAnimator.sourceViewController = self
        scaleAnimator.destinationViewController = destinationController
    }
    
    //MARK: - Actions
    
    @IBAction func showSecondController(_ sender: UITapGestureRecognizer) {
        present(destinationController, animated: true, completion: nil)
    }
    
    private func createDestinationController() -> UIViewController {
        let storyboard = UIStoryboard(name: Consts.Controllers.Second.storyboardName, bundle: Bundle.main)
        let controller = storyboard.instantiateViewController(withIdentifier: Consts.Controllers.Second.storyboardId)
        return controller
    }
    
}


//MARK: - UIViewControllerTransitioningDelegate

//extension FirstViewController : UIViewControllerTransitioningDelegate {
//    
//    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
//        transitionAnimator.isDismissed = false
//        print("Non Interactive")
//        return transitionAnimator
//    }
//    
//    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
//        transitionAnimator.isDismissed = true
//        return transitionAnimator
//    }
//    
//    func interactionControllerForPresentation(using animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
//        print("Interactive")
//        return scaleAnimator
//    }
//}

