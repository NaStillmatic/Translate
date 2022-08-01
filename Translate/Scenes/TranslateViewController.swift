//
//  TranslateViewController.swift
//  Translate
//
//  Created by HwangByungJo  on 2022/08/01.
//

import UIKit
import SnapKit
import SwiftUI

final class TransLateViewController: UIViewController {

  private lazy var sourceLanguageButton: UIButton = {
  
    let button = UIButton()
    button.setTitle("한국어", for: .normal)
    button.titleLabel?.font = .systemFont(ofSize: 15.0, weight: .semibold)
    button.setTitleColor(.label, for: .normal)
    button.backgroundColor = .systemBackground
    button.layer.cornerRadius = 9.0
    return button
  }()
  
  private lazy var targetLanguageButton: UIButton = {
  
    let button = UIButton()
    button.setTitle("영어", for: .normal)
    button.titleLabel?.font = .systemFont(ofSize: 15.0, weight: .semibold)
    button.setTitleColor(.label, for: .normal)
    button.backgroundColor = .systemBackground
    button.layer.cornerRadius = 9.0
    return button
  }()
  
  private lazy var butonStackView: UIStackView = {
    let stackView = UIStackView()
    stackView.distribution = .fillEqually
    stackView.spacing = 8.0
    
    [sourceLanguageButton, targetLanguageButton].forEach {
      stackView.addArrangedSubview($0)
    }
    return stackView
    
  }()
  
  private lazy var resultBaseView: UIView = {
    let view = UIView()
    view.backgroundColor = .white
    return view
  }()
  
  private lazy var resultLabel: UILabel = {
    
    let label = UILabel()
    label.font = .systemFont(ofSize: 23.0, weight: .bold)
    label.textColor = .mainTintColor
    label.text = "Hello"
    label.numberOfLines = 0
    return label
  }()
  
  private lazy var bookmarkButton: UIButton = {
    
    let button = UIButton()
    button.setImage(UIImage(systemName: "bookmark"), for: .normal)
    return button
  }()
  
  private lazy var copyButton: UIButton = {
    
    let button = UIButton()
    button.setImage(UIImage(systemName: "doc.on.doc"), for: .normal)
    return button
  }()
  
  private lazy var sourceLabelBaseButton: UIView = {
    let view = UIView()
    view.backgroundColor = .systemBackground
    return view
  }()
  
  private lazy var sourceLabel: UILabel = {
    let label = UILabel()
    label.text = "텍스트 입력"
    label.textColor = .tertiaryLabel
    label.numberOfLines = 0
    label.font = .systemFont(ofSize: 23.0, weight: .semibold)
    return label
  }()
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    view.backgroundColor = .secondarySystemBackground
    setupViews()
  }
}

private extension TransLateViewController {
  
  func setupViews() {
  
    [
      butonStackView,
      resultBaseView,
      resultLabel,
      bookmarkButton,
      copyButton,
      sourceLabelBaseButton,
      sourceLabel
    ].forEach {
      view.addSubview($0)
    }
    
    let defaultSpacing: CGFloat = 16.0
    
    butonStackView.snp.makeConstraints {
      $0.top.equalTo(view.safeAreaLayoutGuide)
      $0.leading.trailing.equalToSuperview().inset(defaultSpacing)
      $0.height.equalTo(50)
    }
    
    resultBaseView.snp.makeConstraints {
      $0.leading.trailing.equalToSuperview()
      $0.top.equalTo(butonStackView.snp.bottom).offset(defaultSpacing)
      $0.bottom.equalTo(bookmarkButton.snp.bottom).offset(defaultSpacing)
    }
    
    resultLabel.snp.makeConstraints {
      $0.leading.equalTo(resultBaseView.snp.leading).inset(24.0)
      $0.trailing.equalTo(resultBaseView.snp.trailing).inset(24.0)
      $0.top.equalTo(resultBaseView.snp.top).inset(24.0)
    }
    
    bookmarkButton.snp.makeConstraints {
      $0.leading.equalTo(resultLabel.snp.leading)
      $0.top.equalTo(resultLabel.snp.bottom).offset(24.0)
      $0.width.height.equalTo(40.0)
    }
    
    copyButton.snp.makeConstraints {
      $0.leading.equalTo(bookmarkButton.snp.trailing).inset(8.0)
      $0.top.equalTo(bookmarkButton.snp.top)
      $0.width.height.equalTo(40.0)
    }
    
    sourceLabelBaseButton.snp.makeConstraints {
      $0.leading.trailing.equalToSuperview()
      $0.top.equalTo(resultBaseView.snp.bottom).offset(defaultSpacing)
      $0.bottom.equalTo(view.safeAreaLayoutGuide).inset(defaultSpacing)
    }
    
    sourceLabel.snp.makeConstraints {
      $0.leading.equalTo(sourceLabelBaseButton.snp.leading).inset(24.0)
      $0.trailing.equalTo(sourceLabelBaseButton.snp.trailing).inset(24.0)
      $0.top.equalTo(sourceLabelBaseButton.snp.top).inset(24.0)
    }
  }
}

