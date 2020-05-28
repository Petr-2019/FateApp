//
//  SidePickerInteractiveTransition.swift
//  FateIndex
//
//  Created by Peter-Guan on 2020/5/27.
//  Copyright © 2020 管君. All rights reserved.
//

import Foundation
import UIKit

class SidePickerInteractiveTransition: UIPercentDrivenInteractiveTransition, UIViewControllerAnimatedTransitioning {
  // MARK: Static

  enum SidePickerInteractiveTransitionDirection {
    case present, dismiss

    fileprivate func sidePickerViewInTransitionContext(_ transitionContext: UIViewControllerContextTransitioning) -> SidePickerView? {
      switch self {
      case .present:
        return transitionContext.view(forKey: UITransitionContextViewKey.to) as? SidePickerView
      case .dismiss:
        return transitionContext.view(forKey: UITransitionContextViewKey.from) as? SidePickerView
      }
    }
  }

  // MARK: Public

  var interactiveStartPoint: CGPoint?

  var interactiveTransitioning: UIViewControllerInteractiveTransitioning? {
    guard interactiveStartPoint != nil else {
      return nil
    }
    return self
  }

  // MARK: Private

  fileprivate let direction: SidePickerInteractiveTransitionDirection

  // MARK: Init

  init(direction: SidePickerInteractiveTransitionDirection) {
    self.direction = direction
  }

  // MARK: Transition

  func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
    return SidePickerView.transitionDuration
  }

  func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
    if let sidePickerView = direction.sidePickerViewInTransitionContext(transitionContext) {
      switch direction {
      case .present:
        sidePickerView.setStartState(presented: false)
        sidePickerView.animateToEndState(presented: true, interactive: transitionContext.isInteractive) { success in
          transitionContext.completeTransition(success && !transitionContext.transitionWasCancelled)
        }
      case .dismiss:
        sidePickerView.setStartState(presented: true)
        sidePickerView.animateToEndState(presented: false, interactive: transitionContext.isInteractive) { success in
          transitionContext.completeTransition(success && !transitionContext.transitionWasCancelled)
        }
      }
    }
  }
}
