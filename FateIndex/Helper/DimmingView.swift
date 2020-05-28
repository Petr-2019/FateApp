//
//  DimmingView.swift
//  FateIndex
//
//  Created by Peter-Guan on 2020/5/27.
//  Copyright © 2020 管君. All rights reserved.
//

import Foundation
import UIKit

public enum DimmingViewType: Int {
  case white = 1
  case black
  case none
}

public struct DimmingViewConstants {
  static let blackAlphaForLight: CGFloat = 0.4
  static let blackAlphaForDark: CGFloat = 0.6
  static let whiteAlpha: CGFloat = 0.5
  public static let blackBackgroundColor = UIColor(white: 0, alpha: blackAlphaForLight)
  public static let whiteBackgroundColor = UIColor(white: 1, alpha: whiteAlpha)
}

/**
 * DimmingView: Semi-transparent black view.
 * To use when we need a semi transparent black view.
 * If alpha animation needed, just animate alpha from 0 to 1
 */
open class DimmingView: UIView {
  // MARK: - Instance -

  public init(type: DimmingViewType) {
    super.init(frame: .zero)

    switch type {
    case .white:
      backgroundColor = DimmingViewConstants.whiteBackgroundColor
    case .black:
      backgroundColor = DimmingViewConstants.blackBackgroundColor
    case .none:
      backgroundColor = .clear
    }
  }

  public required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

extension DimmingView: Obscurable {
  public var view: UIView {
    return self
  }

  public var isObscuring: Bool {
    get {
      return alpha == 1
    }

    set {
      alpha = newValue ? 1 : 0
    }
  }
}

public protocol Obscurable: AnyObject {
  var view: UIView { get }
  var isObscuring: Bool { get set }
}
