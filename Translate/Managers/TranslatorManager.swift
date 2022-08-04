//
//  TranslatorManager.swift
//  Translate
//
//  Created by HwangByungJo  on 2022/08/04.
//

import Foundation
import Alamofire

struct TranslatorManager {
    
  var sourceLanguage: Language = .ko
  var targetLanguage: Language = .en
  
  func translate(from text: String,
                 completionHandelr: @escaping (String) -> Void) {
    guard let url = URL(string: "https://openapi.naver.com/v1/papago/n2mt") else { return }
    
    let requsetModel = TranslateRequestModel(source: sourceLanguage.languageCode,
                                             target: targetLanguage.languageCode,
                                             text: text)
    
    let headers: HTTPHeaders = [
      "X-Naver-Client-Id": "WrCGCVqjT6ORFZipVl5w",
      "X-Naver-Client-Secret": "mpHJSdbCjB"
    ]
    
    AF.request(url, method: .post, parameters: requsetModel, headers: headers)
      .responseDecodable(of: TranslateResponseModel.self) { response in
        switch response.result {
          case .success(let result):            
            completionHandelr(result.translatedText)
          case .failure(let error):
            print(error.localizedDescription)
        }
      }
  }
}
