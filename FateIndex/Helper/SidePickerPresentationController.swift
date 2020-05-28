//
//  SidePickerPresentationController.swift
//  FateIndex
//
//  Created by Peter-Guan on 2020/5/27.
//  Copyright © 2020 管君. All rights reserved.
//

import UIKit

class SidePickerPresentationController: UIPresentationController {
  // MARK: Public

  let sidePickerView = SidePickerView()

  // MARK: Presentation

  override var presentedView: UIView? {
    // The presented view must contain the dimming view otherwise
    // VoiceOver reads the text behind
    return sidePickerView
  }

  override func presentationTransitionWillBegin() {
    // Add views
    sidePickerView.presentedView = presentedViewController.view
    sidePickerView.frame = frameOfPresentedViewInContainerView
    containerView?.addSubview(sidePickerView)
  }

  override func presentationTransitionDidEnd(_ completed: Bool) {
    // Remove views
    if !completed {
      sidePickerView.removeFromSuperview()
      sidePickerView.presentedView = nil
    }
  }

  override func dismissalTransitionDidEnd(_ completed: Bool) {
    if completed {
      sidePickerView.removeFromSuperview()
      sidePickerView.presentedView = nil
    }
  }

  // MARK: Layout

  override func containerViewDidLayoutSubviews() {
    super.containerViewDidLayoutSubviews()
    sidePickerView.frame = frameOfPresentedViewInContainerView
  }

  // MARK: Transition

  private func relayoutContainerView() {
    containerView?.setNeedsLayout()
    containerView?.layoutIfNeeded()
  }

  override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
    super.viewWillTransition(to: size, with: coordinator)
    relayoutContainerView()
  }

  override func willTransition(to newCollection: UITraitCollection, with coordinator: UIViewControllerTransitionCoordinator) {
    super.willTransition(to: newCollection, with: coordinator)
    relayoutContainerView()
  }
}
