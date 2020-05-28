//
//  SidePickerTransition.swift
//  FateIndex
//
//  Created by Peter-Guan on 2020/5/27.
//  Copyright © 2020 管君. All rights reserved.
//

import Foundation
import UIKit

public enum SidePickerTransitionEvent {
  case openWithPanGesture
  case closeWithPanGesture
  case closeWithTapGesture
  case closeWithTwoFingerScrub
}

// MARK: - SidePickerTransitionDelegate

protocol SidePickerTransitionDelegate: AnyObject {
  /*
   The SidePickerTransitionDelegate may present a view controller either when called directly or when initiated by a gesture.
   */
  func presentedViewControllerForSidePickerTransition(_ sidePickerTransition: SidePickerTransition) -> UIViewController?
  func sidePickerPresentViewController(_ presentedViewController: UIViewController, animated: Bool, completion: (() -> Void)?)

  func sidePickerTransition(_ sidePickerTransition: SidePickerTransition, didPerformTransition transitionEvent: SidePickerTransitionEvent)
}

// MARK: - SidePickerTransition

class SidePickerTransition: NSObject {
  enum SidePickerTransitionDirection {
    case present, dismiss
  }

  // MARK: Public

  weak var delegate: SidePickerTransitionDelegate?
  let presentationPanGestureRecognizer = UIScreenEdgePanGestureRecognizer()
  var isShowing: Bool {
    guard let presentedViewController = presentedViewController else {
      return false
    }
    return presentedViewController.isViewLoaded && presentedViewController.view.window != nil
  }

  // MARK: Private

  fileprivate var presentedViewController: UIViewController?

  fileprivate let presentedViewLayoutDirection = UIApplication.shared.userInterfaceLayoutDirection

  fileprivate let presentTransition = SidePickerInteractiveTransition(direction: .present)
  fileprivate let dismissTransition = SidePickerInteractiveTransition(direction: .dismiss)

  // MARK: Init

  override init() {
    super.init()

    presentationPanGestureRecognizer.addTarget(self, action: #selector(handlePresentationPanned(_:)))
    switch presentedViewLayoutDirection {
    case .leftToRight: presentationPanGestureRecognizer.edges = .left
    case .rightToLeft: presentationPanGestureRecognizer.edges = .right
    @unknown default: fatalError()
    }
  }

  // MARK: Public

  @objc func presentViewController(_ completion: (() -> Void)?) {
    presentedViewController = delegate?.presentedViewControllerForSidePickerTransition(self)

    guard let presentedViewController = presentedViewController else {
      completion?()
      return
    }

    presentedViewController.modalPresentationStyle = .custom
    presentedViewController.transitioningDelegate = self

    delegate?.sidePickerPresentViewController(presentedViewController, animated: true, completion: completion)
  }

  func dismissViewController() {
    presentedViewController?.dismiss(animated: true, completion: nil)
  }

  // MARK: Private

  fileprivate func handlePanGesture(_ gesture: UIPanGestureRecognizer, direction: SidePickerTransitionDirection) {
    let transition: SidePickerInteractiveTransition = {
      switch direction {
      case .present:
        return presentTransition
      case .dismiss:
        return dismissTransition
      }
    }()

    let directionFactor: CGFloat = {
      switch (direction, presentedViewLayoutDirection) {
      case (.present, .leftToRight), (.dismiss, .rightToLeft): return 1
      case (.dismiss, .leftToRight), (.present, .rightToLeft): return -1
      @unknown default: fatalError()
      }
    }()

    let translation: CGPoint = {
      let translationInView = gesture.translation(in: gesture.view)

      guard let interactiveStartPoint = transition.interactiveStartPoint else {
        return translationInView
      }

      return CGPoint(x: (translationInView.x - interactiveStartPoint.x) * directionFactor, y: (translationInView.y - interactiveStartPoint.y) * directionFactor)
    }()

    let progress = max(0, min(0.999, translation.x / SidePickerView.presentedViewWidth))

    switch gesture.state {
    case .began:
      transition.interactiveStartPoint = translation

      switch direction {
      case .present:
        presentViewController(nil)

        delegate?.sidePickerTransition(self, didPerformTransition: .openWithPanGesture)
      case .dismiss:
        dismissViewController()

        delegate?.sidePickerTransition(self, didPerformTransition: .closeWithPanGesture)
      }

    case .changed where transition.interactiveStartPoint != nil:
      transition.update(progress)

    case .ended where transition.interactiveStartPoint != nil:
      // Compute final progress
      let velocity = gesture.velocity(in: gesture.view).x * directionFactor

      let timeFactor: CGFloat = 0.2 // Increase this to decrease the required thumb velocity
      let minimumCompletionDuration: TimeInterval = SidePickerView.transitionDuration / 2
      let finalProgress = max(0, min(1, (translation.x + velocity * timeFactor) / SidePickerView.presentedViewWidth))

      if finalProgress > 0.5 {
        // Set a lower limit for the completion duration to avoid "blinking"
        transition.completionSpeed = min(1, CGFloat(SidePickerView.transitionDuration / minimumCompletionDuration) * (1 - progress))
        transition.finish()
      }
      else {
        // Set a lower limit for the completion duration to avoid "blinking"
        transition.completionSpeed = min(1, CGFloat(SidePickerView.transitionDuration / minimumCompletionDuration) * progress)
        transition.cancel()
      }

      transition.interactiveStartPoint = nil

    case .cancelled, .failed:
      transition.interactiveStartPoint = nil
      transition.cancel()

    default:
      break
    }
  }

  // MARK: Actions

  @objc fileprivate func handlePresentationPanned(_ gesture: UIScreenEdgePanGestureRecognizer) {
    handlePanGesture(gesture, direction: .present)
  }
}

// MARK: - UIViewControllerTransitioningDelegate

extension SidePickerTransition: UIViewControllerTransitioningDelegate {
  func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
    let sidePickerPresentationController = SidePickerPresentationController(presentedViewController: presented, presenting: presenting)
    sidePickerPresentationController.sidePickerView.delegate = self
    return sidePickerPresentationController
  }

  func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
    return presentTransition
  }

  func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
    return dismissTransition
  }

  func interactionControllerForPresentation(using animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
    return presentTransition.interactiveTransitioning
  }

  func interactionControllerForDismissal(using animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
    return dismissTransition.interactiveTransitioning
  }
}

// MARK: - SidePickerViewDelegate

extension SidePickerTransition: SidePickerViewDelegate {
  func sidePickerView(_ sidePickerView: SidePickerView, dismissedWithGesture gesture: UIGestureRecognizer?) {
    switch gesture {
    case let panGesture as UIPanGestureRecognizer:
      handlePanGesture(panGesture, direction: .dismiss)

    case _ as UITapGestureRecognizer:
      dismissViewController()

      delegate?.sidePickerTransition(self, didPerformTransition: .closeWithTapGesture)

    default:
      dismissViewController()

      delegate?.sidePickerTransition(self, didPerformTransition: .closeWithTwoFingerScrub)
    }
  }
}
