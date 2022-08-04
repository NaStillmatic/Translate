//
//  TranslateRequestModel.swift
//  Translate
//
//  Created by HwangByungJo  on 2022/08/04.
//

import Foundation

struct TranslateRequestModel: Codable {
  
  let source: String
  let target: String
  let text: String
}
