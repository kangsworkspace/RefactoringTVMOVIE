//
//  ReviewViewModel.swift
//  RefactoringTVMOVIE
//
//  Created by Healthy on 6/30/24.
//

import Foundation

import RxSwift
import RxRelay

final class ReviewViewModel {
    // MARK: - Fields
    private let networkProvider = NetworkProvider.shared
    private let disposeBag = DisposeBag()
    private let reviewResultRelay = PublishRelay<[ReviewModel]>()
    private let id: Int
    
    struct Input {
        
    }
    
    struct Output {
        let reviewResult: Observable<[ReviewModel]>
    }
    
    // MARK: - Life Cycles
    init(id: Int) {
        self.id = id
    }

    // MARK: - Functions
    func transform(input: Input) -> Output {
        networkProvider.fetchReview(reviewRequest: ReviewRequest(id: self.id))
            .asObservable()
            .map { result in
                return result.results
            }
            .subscribe(onNext: { [weak self] reviewModels in
                self?.reviewResultRelay.accept(reviewModels)
            }).disposed(by: disposeBag)
        return Output(reviewResult: reviewResultRelay.asObservable())
    }
}
