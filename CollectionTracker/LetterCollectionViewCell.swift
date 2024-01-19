//
//  LetterCollectionViewCell.swift
//  CollectionDemo
//
//  Created by Альберт Хайдаров on 10.01.2024.
//

import UIKit

final class LetterCollectionViewCell: UICollectionViewCell {
    static let reuseIdentifier = "cell"
    
    let titleLabel = UILabel()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        titleLabel.backgroundColor = .blue
        
        contentView.addSubview(titleLabel)
        contentView.backgroundColor = .gray
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
       
       NSLayoutConstraint.activate([
            titleLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            titleLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
