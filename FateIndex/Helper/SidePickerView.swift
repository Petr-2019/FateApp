//
//  SidePickerView.swift
//  FateIndex
//
//  Created by Peter-Guan on 2020/5/27.
//  Copyright © 2020 管君. All rights reserved.
//

import Foundation
import UIKit

// MARK: - SidePickerViewDelegate

protocol SidePickerViewDelegate: AnyObject {
  func sidePickerView(_ sidePickerView: SidePickerView, dismissedWithGesture: UIGestureRecognizer?)
}

// MARK: - SidePickerView

class SidePickerView: UIView {
  // MARK: Static

  /// Desired width of the side picker
  static var presentedViewWidth: CGFloat {
    return min(ceil(0.88 * UIScreen.main.bounds.size.width), 360)
  }

  /// Desired width of the inner bar of the side picker
  static var presentedViewInnerBarWidth: CGFloat = 70.0

  static var transitionDuration: TimeInterval {
    return 0.2
  }

  // MARK: Public

  weak var delegate: SidePickerViewDelegate?

  var presentedView: UIView? {
    willSet {
      presentedView?.removeFromSuperview()
    }
    didSet {
      if let presentedView = presentedView {
        presentedContainerView.backgroundColor = presentedView.backgroundColor
        presentedContainerView.addSubview(presentedView)
      }
      setNeedsLayout()
    }
  }

  // MARK: Private

  private let presentedContainerView = UIView(frame: .zero)

  private let dimmingView: DimmingView = {
    let view = DimmingView(type: .black)
    return view
  }()

  private var presentXEdge: CGRectEdge {
    switch effectiveUserInterfaceLayoutDirection {
    case .leftToRight: return .minXEdge
    case .rightToLeft: return .maxXEdge
    @unknown default: fatalError()
    }
  }

  private let dismissTapGestureRecognizer = UITapGestureRecognizer()
  private let dismissPanGestureRecognizer = UIPanGestureRecognizer()

  // MARK: Init

  init() {
    super.init(frame: .zero)

    presentedContainerView.backgroundColor = .white

    // Subviews

    addSubview(dimmingView)
    addSubview(presentedContainerView)

    // Gestures

    dismissTapGestureRecognizer.addTarget(self, action: #selector(handleDismissGesture(_:)))
    dimmingView.addGestureRecognizer(dismissTapGestureRecognizer)

    dismissPanGestureRecognizer.addTarget(self, action: #selector(handleDismissGesture(_:)))
    addGestureRecognizer(dismissPanGestureRecognizer)
  }

  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  // MARK: Layout

  override func layoutSubviews() {
    super.layoutSubviews()

    let (slice, _) = bounds.divided(atDistance: SidePickerView.presentedViewWidth, from: presentXEdge)

    dimmingView.frame = bounds

    presentedContainerView.frame = slice
    presentedView?.frame = presentedContainerView.bounds.divided(atDistance: 0.0, from: .minYEdge).remainder
  }

  // MARK: Actions

  @objc private func handleDismissGesture(_ gesture: UIGestureRecognizer) {
    delegate?.sidePickerView(self, dismissedWithGesture: gesture)
  }

  // MARK: Public Helpers

  func setStartState(presented: Bool) {
    presentedContainerView.frame = bounds.divided(atDistance: SidePickerView.presentedViewWidth, from: presentXEdge).slice

    if presented {
      dimmingView.alpha = 1.0
    }
    else {
      let offset = (effectiveUserInterfaceLayoutDirection == .leftToRight) ? -presentedContainerView.width : presentedContainerView.width
      presentedContainerView.frame = presentedContainerView.frame.offsetBy(dx: offset, dy: 0)
      dimmingView.alpha = 0.0
    }
  }

  func animateToEndState(presented: Bool, interactive: Bool, completion: @escaping ((_ success: Bool) -> Void)) {
    if let presentedView = presentedView as? MailboxChooserView, presentedView.transitionMode == .elevator, !presented, !interactive {
      // Mailbox chooser elevator dismissal animation
      elevatorAnimateToEndState(presentedView, completion: completion)
      return
    }

    // Regular presentation or dismissal animation
    UIView.animate(withDuration: SidePickerView.transitionDuration, delay: 0.0, options: interactive ? .curveLinear : .curveEaseOut, animations: {
      self.presentedContainerView.frame = self.bounds.divided(atDistance: SidePickerView.presentedViewWidth, from: self.presentXEdge).slice

      if presented {
        self.dimmingView.alpha = 1.0
      }
      else {
        let offset = (self.effectiveUserInterfaceLayoutDirection == .leftToRight) ? -self.presentedContainerView.width : self.presentedContainerView.width
        self.presentedContainerView.frame = self.presentedContainerView.frame.offsetBy(dx: offset, dy: 0)
        self.dimmingView.alpha = 0.0
      }
    }, completion: completion)
  }

  func elevatorAnimateToEndState(_ mailboxChooserView: MailboxChooserView, completion: @escaping ((_ success: Bool) -> Void)) {
    // Only call completion handler upon successful completion of the following 2 animations
    var mailboxChooserAnimationCompleted = false
    var dimmingViewAnimationCompleted = false

    // Slide out folder chooser
    UIView.animate(withDuration: MailboxChooserView.elevatorFolderChooserTransitionDuration, delay: 0.0, options: [.curveEaseIn], animations: {
//      switch self.effectiveUserInterfaceLayoutDirection {
//      case .leftToRight:
//        mailboxChooserView.folderChooserContainerView.left -= mailboxChooserView.folderChooserContainerView.width
//      case .rightToLeft:
//        mailboxChooserView.folderChooserContainerView.left += mailboxChooserView.folderChooserContainerView.width
//      @unknown default:
//        fatalError()
//      }
    }, completion: { _ in
      // Slide out account chooser
      UIView.animate(withDuration: MailboxChooserView.elevatorAccountChooserTransitionDuration, delay: 0.0, options: [.curveEaseOut], animations: {
//        switch self.effectiveUserInterfaceLayoutDirection {
//        case .leftToRight:
//          self.presentedContainerView.left -= mailboxChooserView.accountChooserContainerView.width
//        case .rightToLeft:
//          self.presentedContainerView.left += mailboxChooserView.accountChooserContainerView.width
//        @unknown default:
//          fatalError()
//        }
      }, completion: { success in
        mailboxChooserAnimationCompleted = true

        guard dimmingViewAnimationCompleted else {
          return
        }

        completion(success)
      })
    })

    // Fade out dimming view
    UIView.animate(withDuration: MailboxChooserView.elevatorFolderChooserTransitionDuration + MailboxChooserView.elevatorAccountChooserTransitionDuration, delay: 0.0, options: [.curveEaseOut], animations: {
        self.dimmingView.alpha = 0.0
    }, completion: { success in
      dimmingViewAnimationCompleted = true

      guard mailboxChooserAnimationCompleted else {
        return
      }

      completion(success)
    })
  }
}

extension UIView {
  /// Override this method if the presentedView don't want a topMargin
  @objc func respectSidePickerViewTopMargin() -> Bool {
    return true
  }
}
