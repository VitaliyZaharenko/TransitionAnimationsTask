//
//  ViewController.swift
//  TransitionAnimations
//
//  Created by vitali on 12/2/18.
//  Copyright © 2018 vitcopr. All rights reserved.
//

import UIKit

fileprivate struct Const {
    static let hintStringFormat = "Pan from %s edge to start transition"
}

class DirectionInteractiveTransitionViewController: UIViewController {
    
    //MARK: - Views
    
    @IBOutlet weak var switchTransitionDirectionBarButton: UIBarButtonItem!
    @IBOutlet weak var hintLabel: UILabel!
    
    //MARK: - Properties
    
    private let transitionAnimator: DirectionAnimator = {
        let animator = DirectionAnimator()
        animator.transitionDirection = .left
        return animator
    }()
    
    private var interactiveAnimator: DirectionInteractiveAnimator!
    
    private var destinationController: UIViewController!
    
    
    //MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        destinationController = createDestinationController()
        interactiveAnimator = DirectionInteractiveAnimator()
        interactiveAnimator.sourceViewController = self
        interactiveAnimator.destinationViewController = destinationController
        interactiveAnimator.direction = .left
        setupSwitchBarButtonTitle()
        setupHintLabel()
        
    }
    
    //MARK: - Actions
    
    
    @IBAction func switchTransitionDirection(_ sender: UIBarButtonItem) {
        switch interactiveAnimator.direction {
        case .left:
            interactiveAnimator.direction = .right
        case .right:
            interactiveAnimator.direction = .left
        }
        setupSwitchBarButtonTitle()
        setupHintLabel()
    }
    
    @IBAction func showSecondController(_ sender: UITapGestureRecognizer) {
        present(destinationController, animated: true, completion: nil)
    }
    
    private func createDestinationController() -> UIViewController {
        let storyboard = UIStoryboard(name: Consts.Controllers.Second.storyboardName, bundle: Bundle.main)
        let controller = storyboard.instantiateViewController(withIdentifier: Consts.Controllers.Second.storyboardId)
        return controller
    }
    
}

//MARK: - Private Helper Methods

extension DirectionInteractiveTransitionViewController {
    func setupSwitchBarButtonTitle() {
        switchTransitionDirectionBarButton.title = interactiveAnimator.direction.title
    }
    
    func setupHintLabel(){
        let directionTitle = interactiveAnimator.direction.opposite.title.lowercased()
        directionTitle.withCString {
            hintLabel.text = String(format: Const.hintStringFormat, arguments: [$0])
        }
        
    }
}
