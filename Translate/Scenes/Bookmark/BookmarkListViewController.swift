//
//  BookmarkListViewController.swift
//  Translate
//
//  Created by HwangByungJo  on 2022/08/03.
//

import UIKit
import SnapKit

final class BookmakrListViewController: UIViewController {
  
  private var bookmark: [Bookmark] = []
  
  private lazy var collectionView: UICollectionView = {
    let layout = UICollectionViewFlowLayout()
    layout.scrollDirection = .vertical
    
    let inset: CGFloat = 16.0
    layout.estimatedItemSize = CGSize(width: view.frame.width - inset * 2, height: 100.0)
    layout.sectionInset = UIEdgeInsets(top: inset, left: inset, bottom: inset, right: inset)
    
    let collectionview = UICollectionView(frame: .zero,
                                          collectionViewLayout: layout)
    collectionview.register(BookmarkCollectionViewCell.self,
                            forCellWithReuseIdentifier: BookmarkCollectionViewCell.identifier)
    collectionview.backgroundColor = .secondarySystemBackground
    collectionview.dataSource = self
    return collectionview
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    navigationItem.title = "즐겨찾기"
    navigationController?.navigationBar.prefersLargeTitles = true
    
    layout()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    
    bookmark = UserDefaults.standard.bookmarks
    collectionView.reloadData()
  }
}

extension BookmakrListViewController {
  
  func layout() {
    view.addSubview(collectionView)
    collectionView.snp.makeConstraints {
      $0.edges.equalToSuperview()
    }
  }
}

extension BookmakrListViewController: UICollectionViewDataSource {
  
  func collectionView(_ collectionView: UICollectionView,
                      numberOfItemsInSection section: Int) -> Int {
    return bookmark.count
  }
  
  func collectionView(_ collectionView: UICollectionView,
                      cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BookmarkCollectionViewCell.identifier,
                                                        for: indexPath) as? BookmarkCollectionViewCell else { return UICollectionViewCell() }
    
    let data = bookmark[indexPath.row]
    cell.setup(from: data)
    
    return cell
  }
}

