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
    }
    
    struct DirectionSegmentedControl {
        static let leftTitle = "Left"
        static let rightTitle = "Right"
        static let upTitle = "Up"
        static let downTitle = "Down"
    }
    
    
}

class AnimationListViewController: UITableViewController {
    
    // MARK: - Views
    
    @IBOutlet weak var directionTransitionSegmentedControl: UISegmentedControl!
    
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        switch indexPath.row {
        case Const.FadeInFadeOutItem.index:
            showFadeInFadeOut()
        case Const.DirectionTransitionItem.index:
            showDirectionTransition()
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
        case Const.DirectionSegmentedControl.leftTitle:
            return TransitionDirection.left
        case Const.DirectionSegmentedControl.rightTitle:
            return TransitionDirection.right
        case Const.DirectionSegmentedControl.upTitle:
            return TransitionDirection.up
        case Const.DirectionSegmentedControl.downTitle:
            return TransitionDirection.down
        default:
            fatalError("Unknow segmented control title: \(title)")
        }
        
    }
    
}

