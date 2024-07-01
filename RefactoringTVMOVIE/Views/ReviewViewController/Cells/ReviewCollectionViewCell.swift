//
//  ReviewCollectionViewCell.swift
//  RefactoringTVMOVIE
//
//  Created by Healthy on 7/1/24.
//

import UIKit

import SnapKit
import Kingfisher
import Then

final class ReviewCollectionViewCell: UICollectionViewCell {
    // MARK: - Fields
    static let id = "ReviewCollectionViewCell"
        
    // MARK: - Layouts
    private let contentLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 14, weight: .regular)
        $0.numberOfLines = 0
    }
    
    // MARK: - Life Cycles
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setUI()
    }
    
    // MARK: - Functions
    private func setUI() {
        addSubview(contentLabel)
        
        contentLabel.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().inset(20)
            make.leading.trailing.equalToSuperview().inset(14)
        }
    }
    
    public func configure(content: String) {
        contentLabel.text = content
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
