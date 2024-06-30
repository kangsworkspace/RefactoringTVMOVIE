//
//  BigImageCollectionViewCell.swift
//  RefactoringTVMOVIE
//
//  Created by Healthy on 6/30/24.
//

import UIKit

import SnapKit
import Kingfisher
import Then

final class BigImageCollectionViewCell: UICollectionViewCell {
    // MARK: - Fields
    static let id = "BigImageCollectionViewCell"
    
    // MARK: - Layouts
    private let posterImage = UIImageView()
    
    private let stackView = UIStackView().then {
        $0.axis = .vertical
    }
    
    private let titleLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 20, weight: .bold)
    }
    
    private let reviewLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 14, weight: .light)
    }
    
    private let descriptionLabel = UILabel().then {
        $0.numberOfLines = 3
        $0.font = .systemFont(ofSize: 14, weight: .light)
    }
    
    // MARK: - Life Cycles
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setUI()
    }
    
    // MARK: - Functions
    private func setUI() {
        addSubview(posterImage)
        addSubview(stackView)
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(reviewLabel)
        stackView.addArrangedSubview(descriptionLabel)
        
        posterImage.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.height.equalTo(500)
        }
        
        stackView.snp.makeConstraints { make in
            make.top.equalTo(posterImage.snp.bottom).offset(12)
            make.leading.equalToSuperview().offset(14)
            make.trailing.bottom.equalToSuperview().offset(-14)
        }
    }
    
    public func configure(title: String, overview: String, review: String, imageURL: String) {
        titleLabel.text = title
        reviewLabel.text = review
        descriptionLabel.text = overview
        posterImage.kf.setImage(with: URL(string: imageURL))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
