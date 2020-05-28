//
//  UIView+Framing.swift
//  FateIndex
//
//  Created by Peter-Guan on 2020/5/27.
//  Copyright © 2020 管君. All rights reserved.
//

import Foundation
import UIKit

public extension UIView {
  func center(inSuperview centering: [ACCenteringType]) {
    guard let superview = self.superview, !centering.isEmpty else {
      return
    }

    for type in centering {
      switch type {
      case .horizontal:
        self.frame.origin.x = CGFloat(floorf(0.5 * Float(superview.frame.size.width - self.frame.size.width)))
      case .vertical:
        self.frame.origin.y = CGFloat(floorf(0.5 * Float(superview.frame.size.height - self.frame.size.height)))
      }
    }
  }

  func center(inSuperview centering: ACCenteringType) {
    guard let superview = self.superview else {
      return
    }

    switch centering {
    case .horizontal:
      self.frame.origin.x = CGFloat(floorf(0.5 * Float(superview.frame.size.width - self.frame.size.width)))
    case .vertical:
      self.frame.origin.y = CGFloat(floorf(0.5 * Float(superview.frame.size.height - self.frame.size.height)))
    }
  }

  var width: CGFloat {
    get {
      return self.frame.size.width
    }
    set {
      var frame = self.frame
      frame.size.width = newValue
      self.frame = frame
    }
  }

  var height: CGFloat {
    get {
      return self.frame.size.height
    }
    set {
      var frame = self.frame
      frame.size.height = newValue
      self.frame = frame
    }
  }

  var left: CGFloat {
    get {
      return self.frame.origin.x
    }
    set {
      var frame = self.frame
      frame.origin.x = newValue
      self.frame = frame
    }
  }

  var right: CGFloat {
    get {
      return self.frame.origin.x + self.frame.size.width
    }
    set {
      var frame = self.frame
      frame.origin.x = newValue - self.frame.size.width
      self.frame = frame
    }
  }

  var top: CGFloat {
    get {
      return self.frame.origin.y
    }
    set {
      var frame = self.frame
      frame.origin.y = newValue
      self.frame = frame
    }
  }

  var bottom: CGFloat {
    get {
      return self.frame.origin.y + self.frame.size.height
    }
    set {
      var frame = self.frame
      frame.origin.y = newValue - self.frame.size.height
      self.frame = frame
    }
  }
}

public enum ACCenteringType: Int {
  case horizontal
  case vertical
}
