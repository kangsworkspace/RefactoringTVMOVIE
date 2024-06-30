//
//  HeaderView.swift
//  RefactoringTVMOVIE
//
//  Created by Healthy on 6/30/24.
//

import UIKit

import SnapKit
import Then

final class HeaderView: UICollectionReusableView {
    // MARK: - Fields
    static let id = "HeaderView"
    
    // MARK: - Layouts
    private let titleLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 20, weight: .bold)
    }
    
    // MARK: - Life Cycles
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setUI()
    }
    
    // MARK: - Functions
    private func setUI() {
        self.addSubview(titleLabel)
        
        titleLabel.snp.makeConstraints { make in
            make.leading.trailing.top.equalToSuperview()
        }
    }
    
    public func configure(title: String) {
        titleLabel.text = title
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
