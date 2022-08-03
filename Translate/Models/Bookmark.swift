//
//  Bookmark.swift
//  Translate
//
//  Created by HwangByungJo  on 2022/08/03.
//

import Foundation

struct Bookmark: Codable {
  let sourceLanguage: Language
  let translatedLanguage: Language
  
  let sourceText: String
  let translatedText: String
}

