//
//  SourceTextViewController.swift
//  Translate
//
//  Created by HwangByungJo  on 2022/08/02.
//

import UIKit

protocol SourceTextViewControllerDelegate: AnyObject {
  func didEnterText(_ sourceText: String)
}

final class SourceTextViewController: UIViewController {
 
  private let placeHolderText = "텍스트 입력"
  
  private weak var delegate: SourceTextViewControllerDelegate?
  
  
  init(delegate: SourceTextViewControllerDelegate?) {
    self.delegate = delegate
    super.init(nibName: nil, bundle: nil)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  
  private lazy var textView: UITextView = {
    let textView = UITextView()
    textView.text = placeHolderText
    textView.textColor = .secondaryLabel
    textView.font = .systemFont(ofSize: 18.0, weight: .semibold)
    textView.returnKeyType = .done
    textView.delegate = self
    return textView
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    view.backgroundColor = .systemBackground
    
    view.addSubview(textView)
    textView.snp.makeConstraints {
      $0.edges.equalToSuperview().inset(16.0)
    }
  }
}

extension SourceTextViewController: UITextViewDelegate {
  
  func textViewDidBeginEditing(_ textView: UITextView) {
    guard textView.textColor == .secondaryLabel else { return }
    
    textView.text = nil
    textView.textColor = .black
  }

  func textView(_ textView: UITextView,
                shouldChangeTextIn range: NSRange,
                replacementText text: String) -> Bool {
    
    guard text == "\n" else { return true }
    delegate?.didEnterText(textView.text)
    dismiss(animated: true)
    return true
  }

}


