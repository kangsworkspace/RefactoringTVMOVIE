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

class MainViewController: UIViewController {
    // MARK: - Fields
    private let viewModel = MainViewModel()
    private let disposeBag = DisposeBag()
    private let tvTrigger = BehaviorSubject<Int>(value: 1)
    
    private let textField = UITextField().then {
        $0.text = ""
    }
    
    // MARK: - Life Cycles
    override func viewDidLoad() {
        super.viewDidLoad()

        setUI()
        bindViewModel()
        tvTrigger.onNext(1)
    }
    
    private func setUI() {
        view.backgroundColor = .white
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
            .drive(onNext: { tvList in
                print(tvList)
            }).disposed(by: disposeBag)
    }
}

