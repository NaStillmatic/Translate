//
//  Type.swift
//  Translate
//
//  Created by HwangByungJo  on 2022/08/03.
//

import UIKit

enum `Type` {
  case source
  case target
  
  var color: UIColor {
    switch self {
      case .source: return .label
      case .target: return .mainTintColor
    }
  }
}
