//
//  TranslateResponseModel.swift
//  Translate
//
//  Created by HwangByungJo  on 2022/08/04.
//

import Foundation

struct TranslateResponseModel: Decodable {
  
  let message: Message
  var translatedText: String { message.result.translatedText }
  
  struct Message: Decodable {
    let result: Result
  }
  
  struct Result: Decodable {
    let translatedText: String
  }  
}
