//
//  ListCollectionViewCell.swift
//  RefactoringTVMOVIE
//
//  Created by Healthy on 6/30/24.
//

import UIKit

import SnapKit
import Kingfisher
import Then

final class ListCollectionViewCell: UICollectionViewCell {
    // MARK: - Fields
    static let id = "ListCollectionViewCell"
    
    // MARK: - Layouts
    private let image = UIImageView().then {
        $0.layer.masksToBounds = true
        $0.layer.cornerRadius = 8
    }
    
    private let titleLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 20, weight: .bold)
    }
    
    private let releaseDateLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 14, weight: .regular)
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
        addSubview(releaseDateLabel)
        
        image.snp.makeConstraints { make in
            make.leading.top.bottom.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.3)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.leading.equalTo(image.snp.trailing).offset(8)
            make.top.equalToSuperview()
        }
        
        releaseDateLabel.snp.makeConstraints { make in
            make.leading.equalTo(titleLabel.snp.leading)
            make.top.equalTo(titleLabel.snp.bottom).offset(4)
        }
    }
    
    public func configure(title: String, releaseDate: String, imageURL: String) {
        titleLabel.text = title
        releaseDateLabel.text  = releaseDate
        image.kf.setImage(with: URL(string: imageURL))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
