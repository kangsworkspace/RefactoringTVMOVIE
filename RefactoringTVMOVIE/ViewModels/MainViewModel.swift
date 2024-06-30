//
//  MainViewModel.swift
//  RefactoringTVMOVIE
//
//  Created by Healthy on 6/30/24.
//

import Foundation

import RxSwift
import RxRelay

final class MainViewModel: ViewModelType {
    private let networkProvider = NetworkProvider.shared
    private let disposeBag = DisposeBag()
    private let tvListRelay = BehaviorRelay<[TV]>(value: [])
    private let movieResultRelay = PublishRelay<MovieResult>()
    
    struct Input {
        let tvTrigger: Observable<Int>
        let movieTrigger: Observable<Void>
        let search: Observable<String>
    }
    
    struct Output {
        let tvList: Observable<[TV]>
        let movieResult: Observable<MovieResult>
    }
    
    func transform(input: Input) -> Output {
        Observable.combineLatest(input.tvTrigger, input.search)
            .flatMapLatest {[unowned self] (page, query) -> Single<TVListModel> in
                // 리퀘스트 생성
                let request = TVRequest(page: page, query: query)
                // 패치 요청
                return self.networkProvider.fetchTV(tvRequest: request)
            }
            .subscribe(onNext: {[weak self] tvListModel in
                self?.tvListRelay.accept(tvListModel.results)
            }).disposed(by: disposeBag)
        
        
        input.movieTrigger
            .flatMapLatest {[unowned self] _ -> Single<MovieResult> in
                return self.networkProvider.fetchMovie()
            }
            .subscribe(onNext: {[weak self] movieResult in
                self?.movieResultRelay.accept(movieResult)
            }).disposed(by: disposeBag)
        
        return Output(tvList: tvListRelay.asObservable(), movieResult: movieResultRelay.asObservable())
    }
}

