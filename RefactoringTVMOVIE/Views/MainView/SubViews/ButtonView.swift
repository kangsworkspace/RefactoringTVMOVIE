//
//  ButtonView.swift
//  RefactoringTVMOVIE
//
//  Created by Healthy on 6/30/24.
//

import UIKit

import SnapKit
import Then

final class ButtonView: UIView {
    // MARK: - Layouts
    let tvButton = UIButton().then {
        $0.setTitle("TV", for: .normal)
        $0.setTitleColor(.black, for: .normal)
        $0.configuration = UIButton.Configuration.bordered()
    }
    
    let movieButton = UIButton().then {
        $0.setTitle("MOVIE", for: .normal)
        $0.setTitleColor(.black, for: .normal)
        $0.configuration = UIButton.Configuration.bordered()
    }
    
    // MARK: - Life Cycles
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUI()
    }
    
    // MARK: - Funtions
    private func setUI() {
        self.addSubview(tvButton)
        self.addSubview(movieButton)
        
        tvButton.snp.makeConstraints { make in
            make.centerY.leading.equalToSuperview()
        }
        
        movieButton.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalTo(tvButton.snp.trailing).offset(10)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
