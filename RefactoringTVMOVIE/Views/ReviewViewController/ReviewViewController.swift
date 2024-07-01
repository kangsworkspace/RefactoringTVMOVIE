//
//  ReviewViewController.swift
//  RefactoringTVMOVIE
//
//  Created by Healthy on 6/30/24.
//

import UIKit

import RxSwift

final class ReviewViewController: UIViewController {
    // MARK: - Fields
    let viewModel: ReviewViewModel
    private var dataSource: UICollectionViewDiffableDataSource<ReviewSection,ReviewItem>?
    private let disposeBag = DisposeBag()
    private let collectionView: UICollectionView = {
        let config = UICollectionLayoutListConfiguration(appearance: .plain)
        let layout = UICollectionViewCompositionalLayout.list(using: config)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(ReviewHeaderCollectionViewCell.self, forCellWithReuseIdentifier: ReviewHeaderCollectionViewCell.id)
        collectionView.register(ReviewCollectionViewCell.self, forCellWithReuseIdentifier: ReviewCollectionViewCell.id)
        return collectionView
    }()
    
    // MARK: - Life Cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUI()
        setDataSource()
        bindViewModel()
        bindView()
    }
    
    init(id: Int) {
        self.viewModel = ReviewViewModel(id: id)
        super.init(nibName: nil, bundle: nil)
    }
    
    // MARK: - Functions
    private func setUI() {
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    private func setDataSource() {
        dataSource = UICollectionViewDiffableDataSource<ReviewSection,ReviewItem>(collectionView: collectionView, cellProvider: { collectionView, indexPath, item in
            
            switch item {
            case .header(let header):
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ReviewHeaderCollectionViewCell.id, for: indexPath) as? ReviewHeaderCollectionViewCell
                cell?.configure(title: header.name, url: header.url)
                return cell
            case .content(let content):
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ReviewCollectionViewCell.id, for: indexPath) as? ReviewCollectionViewCell
                cell?.configure(content: content)
                return cell
            }
        })
        
        var dataSourceSnapshot = NSDiffableDataSourceSnapshot<ReviewSection,ReviewItem>()
        dataSourceSnapshot.appendSections([.list])
        dataSource?.apply(dataSourceSnapshot)
    }
    
    private func bindViewModel() {
        let output = viewModel.transform(input: ReviewViewModel.Input())
        
        output.reviewResult
            .bind {[weak self] reviewList in
                guard !reviewList.isEmpty else { return }
                var sectionSnapshot = NSDiffableDataSourceSectionSnapshot<ReviewItem>()
                
                reviewList.forEach { review in
                    let header = ReviewHeader(id: review.id,
                                              name: review.author.name.isEmpty ? review.author.username : review.author.name,
                                              url: review.author.imageURL)
                    
                    let headerItem = ReviewItem.header(header)
                    let contentItem = ReviewItem.content(review.content)
                    sectionSnapshot.append([headerItem])
                    sectionSnapshot.append([contentItem], to: headerItem)
                }
                
                self?.dataSource?.apply(sectionSnapshot, to: .list)
            }.disposed(by: disposeBag)
    }
    
    private func bindView() {
        collectionView.rx.itemSelected.bind {[weak self] indexPath in
            guard let item = self?.dataSource?.itemIdentifier(for: indexPath),
                  var sectionSnapshot = self?.dataSource?.snapshot(for: .list) else { return }
            
            if case .header = item {
                if sectionSnapshot.isExpanded(item) {
                    sectionSnapshot.collapse([item])
                } else {
                    sectionSnapshot.expand([item])
                }
                
                self?.dataSource?.apply(sectionSnapshot, to: .list)
            }
        }.disposed(by: disposeBag)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
