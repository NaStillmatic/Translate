//
//  BookmarkTextStackView.swift
//  Translate
//
//  Created by HwangByungJo  on 2022/08/03.
//

import UIKit
import SnapKit

final class BookmarkTextStackView: UIStackView {
  private let type: Type
  private let language: Language
  private let text: String
  
  private lazy var languageLabel: UILabel = {
    let label = UILabel()
    label.font = .systemFont(ofSize: 13.0, weight: .medium)
    label.textColor = type.color
    label.text = language.title
    return label
  }()
  
  private lazy var textLabel: UILabel = {
    let label = UILabel()
    label.font = .systemFont(ofSize: 16.0, weight: .medium)
    label.textColor = type.color
    label.text = text
    label.numberOfLines = 0
    return label
  }()
  
  init(language: Language, text: String, type: Type) {
    self.language = language
    self.text = text
    self.type = type
    super.init(frame: .zero)
  
    setup()
  }
  
  required init(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  private func setup() {
    
    axis = .vertical
    distribution = .equalSpacing
    spacing = 4.0
    
    [
      languageLabel,
      textLabel
    ].forEach {
      self.addArrangedSubview($0)
    }
  }
}
