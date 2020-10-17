//
//  PostListViewModel.swift
//  HackerNewsReader
//
//  Created by Claudio on 10/17/20.
//

import Foundation

class PostListViewModel {

    private let hnService: HackerNewsService
    var title = "Posts"
    private var cellViewModels: [PostCellViewModel] = [PostCellViewModel]() {
        didSet {
            self.reloadTableViewClosure?()
        }
    }
//    private var sortedCellModels: [PostCellViewModel]  {
//        return self.cellViewModels.sorted { (cellModel1, cellModel2) -> Bool in
//            cellModel1.nameText <= cellModel2.nameText
//        }
//    }
//    private var favoriteCellViewModels: [ContactCellViewModel] {
//        return sortedCellModels.filter {
//            $0.isFavorite
//        }
//    }
    
    var messageToDisplay: String? {
        didSet {
            self.showAlertClosure?()
        }
    }
    var isLoading: Bool = false {
        didSet {
            self.updateLoadingStatusClosure?()
        }
    }
    var numberOfSections: Int {
        return 1
    }

    var selectedCellViewModel: PostCellViewModel?
    
    //Closures for easy binding without rx frameworks
    var reloadTableViewClosure: (()->())?
    var showAlertClosure: (()->())?
    var updateLoadingStatusClosure: (()->())?



    init( hnService: HackerNewsService = HnAPIClient()) {
        self.hnService  = hnService
    }
    func initFetch(completionHandler: (() ->())?) {
        self.isLoading = true
        self.hnService.fetchPosts{ [weak self] (success, contacts, error) in
            self?.isLoading = false
            if let error = error {
                print(error)
                self?.messageToDisplay = error.localizedDescription
            } else {
                self?.createdCellViewModels(from: contacts)
            }
            completionHandler?()
        }
    }
    
    
    func cellViewModel( at indexPath: IndexPath ) -> PostCellViewModel {
        return cellViewModels[indexPath.row]
    }
    

    
    func createCellViewModel(from post: Post ) -> PostCellViewModel {

        return PostCellViewModel()
    }
    
    private func createdCellViewModels(from posts: [Post] ) {
        var cellVMs = [PostCellViewModel]()
        for post in posts {
            cellVMs.append( createCellViewModel(from: post) )
        }
        self.cellViewModels = cellVMs
    }
    
    func didTap( at indexPath: IndexPath ){
        self.selectedCellViewModel = self.cellViewModel(at: indexPath)
    }
}