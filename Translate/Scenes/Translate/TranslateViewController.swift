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

  private lazy var sourceLanguageButton: UIButton = {
  
    let button = UIButton()
    button.setTitle(translateManger.sourceLanguage.title, for: .normal)
    button.titleLabel?.font = .systemFont(ofSize: 15.0, weight: .semibold)
    button.setTitleColor(.label, for: .normal)
    button.backgroundColor = .systemBackground
    button.layer.cornerRadius = 9.0
    button.addTarget(self, action: #selector(didTabSourceLanguageButton), for: .touchUpInside)
    return button
  }()
  
  private lazy var targetLanguageButton: UIButton = {
  
    let button = UIButton()
    button.setTitle(translateManger.targetLanguage.title, for: .normal)
    button.titleLabel?.font = .systemFont(ofSize: 15.0, weight: .semibold)
    button.setTitleColor(.label, for: .normal)
    button.backgroundColor = .systemBackground
    button.layer.cornerRadius = 9.0
    button.addTarget(self, action: #selector(didTabTargetLanguageButton), for: .touchUpInside)
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
    label.numberOfLines = 0
    return label
  }()
  
  private lazy var bookmarkButton: UIButton = {
    
    let button = UIButton()
    button.setImage(UIImage(systemName: "bookmark"), for: .normal)
    button.addTarget(self, action: #selector(didTabBookmarkButton), for: .touchUpInside)
    return button
  }()
  
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
  
  private lazy var copyButton: UIButton = {
    
    let button = UIButton()
    button.setImage(UIImage(systemName: "doc.on.doc"), for: .normal)
    button.addTarget(self, action: #selector(didTabCopyButton), for: .touchUpInside)
    return button
  }()
  
  @objc func didTabCopyButton() {
    UIPasteboard.general.string = resultLabel.text
  }
  
  private lazy var sourceLabelBaseButton: UIView = {
    let view = UIView()
    view.backgroundColor = .systemBackground
    
    let tapGesture = UITapGestureRecognizer(target: self,
                                            action: #selector(didTapSourceLabelBaseButton))
    view.addGestureRecognizer(tapGesture)
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
  
  
  @objc func didTapSourceLabelBaseButton () {
    let vc = SourceTextViewController(delegate: self)
    present(vc, animated: true)
  }
  
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
    let cancelAction = UIAlertAction(title: "취소하기", style: .cancel)
    alertController.addAction(cancelAction)
    present(alertController, animated: true)
  }
}


