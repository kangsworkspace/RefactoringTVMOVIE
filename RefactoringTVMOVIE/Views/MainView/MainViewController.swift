//
//  ViewController.swift
//  RefactoringTVMOVIE
//
//  Created by Healthy on 6/30/24.
//

import UIKit

import RxSwift
import RxCocoa
import SnapKit
import Then

final class MainViewController: UIViewController {
    // MARK: - Fields
    private let viewModel = MainViewModel()
    private let disposeBag = DisposeBag()
    private let tvTrigger = BehaviorSubject<Int>(value: 1)
    
    // MARK: - Layouts
    // 상단 뷰
    private let topStackView = UIStackView().then {
        $0.axis = .vertical
        $0.spacing = 8
    }
    
    private let buttonView = ButtonView()
    
    private let textField = UITextField().then {
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor.gray.cgColor
        $0.layer.cornerRadius = 5
        let imageView = UIImageView(image: UIImage(systemName: "magnifyingglass"))
        imageView.tintColor = .black
        imageView.frame = CGRect(x: 0, y: 0, width: 20, height: 20)
        $0.leftView = imageView
        $0.leftViewMode = .always
    }
    
    private let collectionView = CollectionView()
    
    // MARK: - Life Cycles
    override func viewDidLoad() {
        super.viewDidLoad()

        setUI()
        bindViewModel()
    }
    
    // MARK: - Functions
    private func setUI() {
        view.backgroundColor = .white
        
        self.view.addSubview(topStackView)
        topStackView.addArrangedSubview(textField)
        topStackView.addArrangedSubview(buttonView)
        self.view.addSubview(collectionView)
        
        topStackView.snp.makeConstraints { make in
            make.top.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(12)
        }

        textField.snp.makeConstraints { make in
            make.height.equalTo(44)
        }
        
        buttonView.snp.makeConstraints { make in
            make.height.equalTo(80)
        }
        
        collectionView.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalToSuperview()
            make.top.equalTo(topStackView.snp.bottom)
        }
    }
    
    private func bindViewModel() {
        let keyword = textField.rx.text.orEmpty.distinctUntilChanged().debounce(.microseconds(200), scheduler: MainScheduler.instance).map({[weak self] keyword in
            self?.tvTrigger.onNext(1)
            return keyword
        })
        
        let input = MainViewModel.Input(tvTrigger: tvTrigger, search: keyword)
        
        let output = viewModel.transform(input: input)
        
        output.tvList
            .asDriver(onErrorJustReturn: [TV]())
            .drive(onNext: { [weak self] tvList in
                var snapshot = NSDiffableDataSourceSnapshot<Section,Item>()
                let items = tvList.map { Item.normal( $0 )}
                let section = Section.double
                snapshot.appendSections([section])
                snapshot.appendItems(items, toSection: section)
                self?.collectionView.applySnapShot(snapShot: snapshot)
            }).disposed(by: disposeBag)
    }
}

