//
//  MailboxChooserView.swift
//  FateIndex
//
//  Created by Peter-Guan on 2020/5/27.
//  Copyright © 2020 管君. All rights reserved.
//

import UIKit

class MailboxChooserView: UIView {
  // MARK: - Class

  enum TransitionDirection {
    case up
    case down
  }

  enum TransitionMode {
    case `default`
    case elevator
  }

  fileprivate struct Constants {
    static let extrasViewHeightDefault: CGFloat = 110.0
  }

  // Used during elevator slide
  static let elevatorAccountChooserTransitionDuration: TimeInterval = 0.08
  static let elevatorFolderChooserTransitionDuration: TimeInterval = 0.16

  // MARK: - Instance

  var transitionMode: TransitionMode = .default

    let theView = UIView(frame: .zero)

  // MARK: Init

  init(accountChooserView: UITableView, folderChooserView: UITableView) {
    super.init(frame: .zero)

    backgroundColor = .clear

    addSubview(theView)
    theView.backgroundColor = .red
  }

  required init?(coder aDecoder: NSCoder) {
    fatalError()
  }

  // MARK: Superclass overrides

  override func respectSidePickerViewTopMargin() -> Bool {
    return false
  }

  // MARK: Layout

  override func layoutSubviews() {
    super.layoutSubviews()

    theView.frame = bounds
  }

  // MARK: Animations

  func fadeOutFolderChooserView(_ direction: TransitionDirection, completion: (() -> Void)? = nil) {
    //folderChooserContainerView.fadeOut(direction, completion: completion)
  }

  func fadeInFolderChooserView(_ direction: TransitionDirection, completion: (() -> Void)? = nil) {
    //folderChooserContainerView.fadeIn(direction, completion: completion)
  }

  func resetView() {
    transitionMode = .default
    setNeedsLayout()
  }
}
