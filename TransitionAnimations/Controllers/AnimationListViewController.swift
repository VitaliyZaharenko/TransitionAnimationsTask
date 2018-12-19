//
//  ViewController.swift
//  TransitionAnimations
//
//  Created by vitali on 12/2/18.
//  Copyright © 2018 vitcopr. All rights reserved.
//

import UIKit

fileprivate struct Const {
    
    struct FadeInFadeOutItem {
        static let index = 0
    }
    struct DirectionTransitionItem {
        static let index = 1
        
        static let titleSegmentedControlLeft = "Left"
        static let titleSegmentedControlRight = "Right"
        static let titleSegmentedControlUp = "Up"
        static let titleSegmentedControlDown = "Down"
    }
    
    struct DirectionInteractiveTransitionItem {
        static let index = 2
    }
    
    
}

class AnimationListViewController: UITableViewController {
    
    // MARK: - Views
    
    @IBOutlet weak var directionTransitionSegmentedControl: UISegmentedControl!
    
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.interactivePopGestureRecognizer?.isEnabled = false
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        switch indexPath.row {
        case Const.FadeInFadeOutItem.index:
            showFadeInFadeOut()
        case Const.DirectionTransitionItem.index:
            showDirectionTransition()
        case Const.DirectionInteractiveTransitionItem.index:
            showInteractiveDirectionTransition()
        default:
            return
        }
    }
}


// MARK: - Private Helper Methods

extension AnimationListViewController {
    
    
    func showFadeInFadeOut(){
        let storyboard = UIStoryboard(name: Consts.Controllers.FadeInFadeOutTransition.stryboardName, bundle: Bundle.main)
        let controller = storyboard.instantiateViewController(withIdentifier: Consts.Controllers.FadeInFadeOutTransition.storyboardId)
        navigationController?.pushViewController(controller, animated: true)
    }
    
    func showDirectionTransition(){
        let storyboard = UIStoryboard(name: Consts.Controllers.DirectionTransition.stryboardName, bundle: Bundle.main)
        let controller = storyboard.instantiateViewController(withIdentifier: Consts.Controllers.DirectionTransition.storyboardId) as! DirectionTransitionViewController
        let direction = transitionDirection()
        controller.direction = direction
        navigationController?.pushViewController(controller, animated: true)
    }
    
    
    func transitionDirection() -> TransitionDirection {
        let title = directionTransitionSegmentedControl.titleForSegment(at: directionTransitionSegmentedControl.selectedSegmentIndex)!
        switch title {
        case Const.DirectionTransitionItem.titleSegmentedControlLeft:
            return TransitionDirection.left
        case Const.DirectionTransitionItem.titleSegmentedControlRight:
            return TransitionDirection.right
        case Const.DirectionTransitionItem.titleSegmentedControlUp:
            return TransitionDirection.up
        case Const.DirectionTransitionItem.titleSegmentedControlDown:
            return TransitionDirection.down
        default:
            fatalError("Unknow segmented control title: \(title)")
        }
    }
    
    func showInteractiveDirectionTransition(){
        let storyboard = UIStoryboard(name: Consts.Controllers.DirectionInteractiveTransition.stryboardName, bundle: Bundle.main)
        let controller = storyboard.instantiateViewController(withIdentifier: Consts.Controllers.DirectionInteractiveTransition.storyboardId)
        navigationController?.pushViewController(controller, animated: true)
    }
    
    
}

