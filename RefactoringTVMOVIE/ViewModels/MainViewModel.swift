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
    private(set) var currentContentType: ContentType = .tv

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
            .flatMapLatest {[weak self] (page, query) -> Single<TVListModel> in
                guard let self = self else { return Single.never() }
                
                if page == 1 { self.tvListRelay.accept([]) }
                self.currentContentType = .tv
                
                // 리퀘스트 생성
                let request = TVRequest(page: page, query: query)
                // 패치 요청
                return self.networkProvider.fetchTV(tvRequest: request)
            }
            .subscribe(onNext: {[weak self] tvListModel in
                var value = self?.tvListRelay.value ?? []
                let newItems = tvListModel.results
                
                // 중복 항목 제거
                let uniqueItems = newItems.filter { newItem in
                    !value.contains { $0.id == newItem.id }
                }
                
                value += uniqueItems
                self?.tvListRelay.accept(value)
            }).disposed(by: disposeBag)
        
        
        input.movieTrigger
            .flatMapLatest {[weak self] _ -> Single<MovieResult> in
                guard let self = self else { return Single.never() }
                self.currentContentType = .movie
                return self.networkProvider.fetchMovie()
            }
            .subscribe(onNext: {[weak self] movieResult in
                self?.movieResultRelay.accept(movieResult)
            }).disposed(by: disposeBag)
        
        return Output(tvList: tvListRelay.asObservable(), movieResult: movieResultRelay.asObservable())
    }
}

