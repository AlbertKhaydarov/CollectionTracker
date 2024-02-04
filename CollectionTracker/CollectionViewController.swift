//
//  CollectionViewController.swift
//  CollectionDemo
//
//  Created by Admin on 10.01.2024.
//

import UIKit

class CollectionViewController: UIViewController {
    
    private let letters = [
        "🙂", "😻", "🌺", "🐶", "❤️", "😱",
        "😇", "😡", "🥶", "🤔", "🙌", "🍔",
        "🥦", "🏓", "🥇", "🎸", "🏝", "😪"
    ]
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
      
        return collection
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .lightGray
        
        collectionView.register(LetterCollectionViewCell.self, forCellWithReuseIdentifier: LetterCollectionViewCell.reuseIdentifier)
        collectionView.dataSource = self
        collectionView.delegate = self
        
        collectionView.register(SupplementaryView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "header")
        collectionView.register(SupplementaryView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: "footer")
        
        setup()
        
        collectionView.allowsMultipleSelection = false
    }
    
    private func setup() {
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(collectionView)
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
}

extension CollectionViewController: UICollectionViewDataSource {
    
    
//    func numberOfSections(in collectionView: UICollectionView) -> Int {
//        return letters.count
//    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return letters.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: LetterCollectionViewCell.reuseIdentifier, for: indexPath) as? LetterCollectionViewCell else {return UICollectionViewCell()}
        cell.titleLabel.text = letters[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        var id: String
        switch kind {
        case UICollectionView.elementKindSectionHeader:
            id = "header"
           
        case UICollectionView.elementKindSectionFooter:
            id = "footer"
           
        default:
            id = ""
        }
        
    let view = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: id, for: indexPath) as! SupplementaryView
        if id == "header" {
            view.titleLabel.text = letters[indexPath.section]
        } else if id == "footer"{
            view.titleLabel.text = "\(indexPath.section + 1)"
        }
        return view
    }
}

extension CollectionViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        
        let indexPath = IndexPath(row: 0, section: section)
        let headerView = self.collectionView(collectionView, viewForSupplementaryElementOfKind: UICollectionView.elementKindSectionHeader, at: indexPath)
        
        return headerView.systemLayoutSizeFitting(CGSize(width: collectionView.frame.width,
                                                         height: UIView.layoutFittingExpandedSize.height),
                                                  withHorizontalFittingPriority: .required,
                                                  verticalFittingPriority: .fittingSizeLevel)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        let indexPath = IndexPath(row: 0, section: section)
        let footerView = self.collectionView(collectionView, viewForSupplementaryElementOfKind: UICollectionView.elementKindSectionFooter, at: indexPath)
        
        return footerView.systemLayoutSizeFitting(CGSize(width: collectionView.frame.width,
                                                         height: UIView.layoutFittingExpandedSize.height),
                                                  withHorizontalFittingPriority: .required,
                                                  verticalFittingPriority: .fittingSizeLevel)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (collectionView.bounds.width - 15) / 4, height: 50)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
     
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as? LetterCollectionViewCell
            cell?.titleLabel.font = UIFont.boldSystemFont(ofSize: 17)
        }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as? LetterCollectionViewCell
        cell?.titleLabel.font = UIFont.systemFont(ofSize: 17, weight: .regular)
    }
// MARK: - iOS 16+
    func collectionView(_ collectionView: UICollectionView, contextMenuConfigurationForItemsAt indexPaths: [IndexPath], point: CGPoint) -> UIContextMenuConfiguration? {
        guard indexPaths.count > 0 else {
                   return nil
               }
        let indexPath = indexPaths[0]
               
               return UIContextMenuConfiguration(actionProvider: { actions in    // 4
                   return UIMenu(children: [                                     // 5
                       UIAction(title: "Bold") { [weak self] _ in                // 6
                           self?.makeBold(indexPath: indexPath)
                       },
                       UIAction(title: "Italic") { [weak self] _ in              // 7
                           self?.makeItalic(indexPath: indexPath)
                       },
                   ])
               })
    }
    
    private func makeBold(indexPath: IndexPath) {
            let cell = collectionView.cellForItem(at: indexPath) as? LetterCollectionViewCell
            cell?.titleLabel.font = UIFont.boldSystemFont(ofSize: 17)
        }
        
    private func makeItalic(indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as? LetterCollectionViewCell
        cell?.titleLabel.font = UIFont.italicSystemFont(ofSize: 17)
    }

    // MARK: - iOS <16
//    func collectionView(_ collectionView: UICollectionView, contextMenuConfigurationForItemsAt indexPaths: IndexPath, point: CGPoint) -> UIContextMenuConfiguration? {
//        return nil
//    }
    
}

