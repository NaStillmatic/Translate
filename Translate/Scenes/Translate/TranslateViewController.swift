//
//  TranslateViewController.swift
//  Translate
//
//  Created by HwangByungJo  on 2022/08/01.
//

import UIKit
import SnapKit

final class TransLateViewController: UIViewController {
      
  private var translateManger = TranslatorManager()

  private let sourceLanguageButton = UIButton()
  private let targetLanguageButton = UIButton()
  private let buttonStackView =  UIStackView()
  private let resultBaseView = UIView()
  private let resultLabel = UILabel()
  private let bookmarkButton = UIButton()
  private let copyButton = UIButton()
  private let sourceLabelBaseButton = UIView()
  private let sourceLabel = UILabel()
  
  override func viewDidLoad() {
    super.viewDidLoad()
        
    attribute()
    layout()
  }
  
  @objc func didTabBookmarkButton() {
    guard let sourceText = sourceLabel.text,
          let translateText = resultLabel.text,
          bookmarkButton.imageView?.image == UIImage(systemName: "bookmark")
    else { return }
    
    bookmarkButton.setImage(UIImage(systemName: "bookmark.fill"), for: .normal)
    
    let currentBookmarks: [Bookmark] = UserDefaults.standard.bookmarks
    let newBookmark = Bookmark(sourceLanguage: translateManger.sourceLanguage,
                               translatedLanguage: translateManger.targetLanguage,
                               sourceText: sourceText,
                               translatedText: translateText)
    UserDefaults.standard.bookmarks = [newBookmark] + currentBookmarks
  }
  
  @objc func didTabCopyButton() {
    UIPasteboard.general.string = resultLabel.text
  }
  
  @objc func didTapSourceLabelBaseButton () {
    let vc = SourceTextViewController(delegate: self)
    present(vc, animated: true)
  }
}

private extension TransLateViewController {
  
  private func attribute() {
    
    view.backgroundColor = .secondarySystemBackground
    
    sourceLanguageButton.setTitle(translateManger.sourceLanguage.title, for: .normal)
    sourceLanguageButton.titleLabel?.font = .systemFont(ofSize: 15.0, weight: .semibold)
    sourceLanguageButton.setTitleColor(.label, for: .normal)
    sourceLanguageButton.backgroundColor = .systemBackground
    sourceLanguageButton.layer.cornerRadius = 9.0
    sourceLanguageButton.addTarget(self, action: #selector(didTabSourceLanguageButton), for: .touchUpInside)
        
    targetLanguageButton.setTitle(translateManger.targetLanguage.title, for: .normal)
    targetLanguageButton.titleLabel?.font = .systemFont(ofSize: 15.0, weight: .semibold)
    targetLanguageButton.setTitleColor(.label, for: .normal)
    targetLanguageButton.backgroundColor = .systemBackground
    targetLanguageButton.layer.cornerRadius = 9.0
    targetLanguageButton.addTarget(self, action: #selector(didTabTargetLanguageButton), for: .touchUpInside)
        
    buttonStackView.distribution = .fillEqually
    buttonStackView.spacing = 8.0
        
    resultBaseView.backgroundColor = .white
        
    resultLabel.font = .systemFont(ofSize: 23.0, weight: .bold)
    resultLabel.textColor = .mainTintColor
    resultLabel.numberOfLines = 0
    
    bookmarkButton.setImage(UIImage(systemName: "bookmark"), for: .normal)
    copyButton.setImage(UIImage(systemName: "doc.on.doc"), for: .normal)
    copyButton.addTarget(self, action: #selector(didTabCopyButton), for: .touchUpInside)
    bookmarkButton.addTarget(self, action: #selector(didTabBookmarkButton), for: .touchUpInside)
    
    sourceLabelBaseButton.backgroundColor = .systemBackground
    let tapGesture = UITapGestureRecognizer(target: self,
                                            action: #selector(didTapSourceLabelBaseButton))
    sourceLabelBaseButton.addGestureRecognizer(tapGesture)
    
    sourceLabel.text = NSLocalizedString("Enter_Text", comment: "텍스트 입력")
    sourceLabel.textColor = .tertiaryLabel
    sourceLabel.numberOfLines = 0
    sourceLabel.font = .systemFont(ofSize: 23.0, weight: .semibold)
  }
  
  private func layout() {
  
    [
      buttonStackView,
      resultBaseView,
      resultLabel,
      bookmarkButton,
      copyButton,
      sourceLabelBaseButton,
      sourceLabel
    ].forEach {
      view.addSubview($0)
    }
    
    [sourceLanguageButton, targetLanguageButton].forEach {
      buttonStackView.addArrangedSubview($0)
    }
    
    let defaultSpacing: CGFloat = 16.0
    
    buttonStackView.snp.makeConstraints {
      $0.top.equalTo(view.safeAreaLayoutGuide)
      $0.leading.trailing.equalToSuperview().inset(defaultSpacing)
      $0.height.equalTo(50)
    }
    
    resultBaseView.snp.makeConstraints {
      $0.leading.trailing.equalToSuperview()
      $0.top.equalTo(buttonStackView.snp.bottom).offset(defaultSpacing)
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

extension TransLateViewController: SourceTextViewControllerDelegate {
  
  func didEnterText(_ sourceText: String) {
    if sourceText == "" { return}
    sourceLabel.text = sourceText
    sourceLabel.textColor = .label
    
    translateManger.translate(from: sourceText) { [weak self] translatedTex in
      self?.resultLabel.text = translatedTex
    }
    bookmarkButton.setImage(UIImage(systemName: "bookmark"), for: .normal)
  }
}

extension TransLateViewController {
  
  @objc func didTabSourceLanguageButton() {
    didTapLanguageButton(type: .source)
  }
  @objc func didTabTargetLanguageButton() {
    didTapLanguageButton(type: .target)
  }
  
  func didTapLanguageButton(type: Type) {
    let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
    Language.allCases.forEach { language in
      let action = UIAlertAction(title: language.title, style: .default) { [weak self] _ in
        switch type {
          case .source:
            self?.translateManger.sourceLanguage = language
            self?.sourceLanguageButton.setTitle(language.title, for: .normal)
          case .target:
            self?.translateManger.targetLanguage = language
            self?.targetLanguageButton.setTitle(language.title, for: .normal)
        }
      }
      alertController.addAction(action)
    }
    let cancelAction = UIAlertAction(title: NSLocalizedString("Cancel", comment: "취소"),
                                     style: .cancel)
    alertController.addAction(cancelAction)
    present(alertController, animated: true)
  }
}


