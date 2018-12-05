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
        animator.transitionDirection = .random
        return animator
    }()
    
    private var scaleAnimator: ScaleInteractiveAnimator!
    
    
    //MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        scaleAnimator = ScaleInteractiveAnimator(controller: self)
    }
    
    //MARK: - Actions
    
    @IBAction func showSecondController(_ sender: UITapGestureRecognizer) {
        let storyboard = UIStoryboard(name: Consts.Controllers.Second.storyboardName, bundle: Bundle.main)
        let controller = storyboard.instantiateViewController(withIdentifier: Consts.Controllers.Second.storyboardId)
        controller.transitioningDelegate = self
        present(controller, animated: true, completion: nil)
    }
    
}


//MARK: - UIViewControllerTransitioningDelegate

extension FirstViewController : UIViewControllerTransitioningDelegate {
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transitionAnimator.isDismissed = false
        return transitionAnimator
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transitionAnimator.isDismissed = true
        return transitionAnimator
    }
    
//    func interactionControllerForPresentation(using animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
//        <#code#>
//    }
}

