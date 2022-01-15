//
//  TransitionManager.swift
//  SwiftProjects
//
//  Created by SimonMiao on 2022/1/15.
//

import UIKit

class TransitionManager: NSObject {
    fileprivate var presenting = false
}

extension TransitionManager {
    private func offStage(_ amount: CGFloat) -> CGAffineTransform {
        return CGAffineTransform(translationX: amount, y: 0)
    }
    
    func offStageMenuController(_ menuViewController: TumblrMenuViewController) {
        menuViewController.view.alpha = 0
        // setup paramaters for 2D transitions for animations
        let topRowOffset: CGFloat = 300
        let middleRowOffset: CGFloat = 150
        let bottomRowOffset: CGFloat = 50
        let offsetList = [
            -topRowOffset, topRowOffset,
             -middleRowOffset, middleRowOffset,
             -bottomRowOffset, bottomRowOffset
        ]
        for itemView in menuViewController.itemViewList {
            guard let index = menuViewController.itemViewList.firstIndex(of: itemView) else { continue }
            let offset = offsetList[index]
            itemView.transform = offStage(offset)
        }
    }
    
    func onStageMenuController(_ menuViewController: TumblrMenuViewController) {
        menuViewController.view.alpha = 1
        
        for itemView in menuViewController.itemViewList {
            itemView.transform = CGAffineTransform.identity
        }
    }
}

extension TransitionManager: UIViewControllerAnimatedTransitioning {
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.5
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        // 获取容器view
        let container = transitionContext.containerView
        // 创建控制器元组
        let screens : (from: UIViewController, to: UIViewController) = (
            transitionContext.viewController(forKey: .from)!,
            transitionContext.viewController(forKey: .to)!
        )
        
        let menuCtr = presenting ? screens.to as! TumblrMenuViewController : screens.from as! TumblrMenuViewController
        let bottomCtr = presenting ? screens.from as UIViewController : screens.to as UIViewController
        
        let menuView = menuCtr.view!
        let bottomView = bottomCtr.view!
        
        if presenting {
            offStageMenuController(menuCtr)
        }
        
        container.addSubview(bottomView)
        container.addSubview(menuView)
                                                                      
        let duration = self.transitionDuration(using: transitionContext)
        
        UIView.animate(withDuration: duration, delay: 0.0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.8, options: []) {
            if self.presenting {
                self.onStageMenuController(menuCtr)
            } else {
                self.offStageMenuController(menuCtr)
            }
        } completion: { finished in
            transitionContext.completeTransition(true)
//            UIApplication.msy_keyWindow?.addSubview(screens.to.view)
        }
    }
    
}

extension TransitionManager: UIViewControllerTransitioningDelegate {
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        // present TumblrMenuViewController时
        self.presenting = true
        
        return self
    }
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        // dismiss TumblrMenuViewController时
        self.presenting = false
        
        return self
    }
}
