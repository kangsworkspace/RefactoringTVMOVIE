//
//  ReviewHeaderCollectionViewCell.swift
//  RefactoringTVMOVIE
//
//  Created by Healthy on 7/1/24.
//

import UIKit

import SnapKit
import Kingfisher
import Then

final class ReviewHeaderCollectionViewCell: UICollectionViewCell {
    // MARK: - Fields
    static let id = "ReviewHeaderCollectionViewCell"
    
    // MARK: - Layouts
    private let image = UIImageView().then {
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 8
        $0.contentMode = .scaleAspectFit
    }
    
    private let titleLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 20, weight: .regular)
    }
    
    // MARK: - Life Cycles
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setUI()
    }
    
    // MARK: - Functions
    private func setUI() {
        addSubview(image)
        addSubview(titleLabel)
        
        snp.makeConstraints { make in
            make.height.equalTo(44)
        }
        
        image.snp.makeConstraints { make in
            make.leading.top.bottom.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.3)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.leading.equalTo(image.snp.trailing).offset(8)
            make.centerY.equalToSuperview()
        }
    }
    
    public func configure(title: String, url: String) {
        if url.isEmpty {
            image.image = UIImage(systemName: "person.fill")
        } else {
            image.kf.setImage(with: URL(string: url))
        }
        
        titleLabel.text = title
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
