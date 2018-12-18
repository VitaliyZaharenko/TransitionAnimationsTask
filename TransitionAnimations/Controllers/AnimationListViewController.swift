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
    
    
}

class AnimationListViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        switch indexPath.row {
        case Const.FadeInFadeOutItem.index:
            showFadeInFadeOut()
        default:
            return
        }
    }
}


//MARK: - Private Helper Methods

extension AnimationListViewController {
    
    
    func showFadeInFadeOut(){
        let storyboard = UIStoryboard(name: Consts.Controllers.FadeInFadeOutTransition.stryboardName, bundle: Bundle.main)
        let controller = storyboard.instantiateViewController(withIdentifier: Consts.Controllers.FadeInFadeOutTransition.storyboardId)
        navigationController?.pushViewController(controller, animated: true)
    }
    
}

