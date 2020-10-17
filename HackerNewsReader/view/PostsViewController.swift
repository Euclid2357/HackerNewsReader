//
//  PostsViewController.swift
//  HackerNewsReader
//
//  Created by Claudio on 10/16/20.
//

import UIKit

class PostsViewController: UIViewController {
    
    // MARK: - Outlets

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    // MARK: - Properties
    lazy var viewModel: PostListViewModel = {
        return PostListViewModel()
    }()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.initViewModel()
        
    }
    
    // MARK: - Helpers
    
    func display(alertMessage message: String) {
        let alert = UIAlertController(title: "Alert", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    private func initViewModel() {
        //Initialize closures for binding
        viewModel.showAlertClosure = { [weak self] () in
            DispatchQueue.main.async {
                if let message = self?.viewModel.messageToDisplay {
                    self?.display(alertMessage: message)
                }
            }
        }
        
        viewModel.reloadTableViewClosure = { [weak self] () in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
        
        viewModel.updateLoadingStatusClosure = { [weak self] () in
                    DispatchQueue.main.async {
                        let loading = self?.viewModel.isLoading ?? false
                        if loading {
                   self?.activityIndicator.startAnimating()
                   UIView.animate(withDuration: 0.5, animations: {
                        self?.tableView.alpha = 0.0
                   })
                        } else {

                            self?.activityIndicator.stopAnimating()
                            UIView.animate(withDuration: 0.5, animations: {
                                self?.tableView.alpha = 1.0
                            })
                        }
                    }
                }
        self.navigationItem.title = viewModel.title
        viewModel.initFetch(completionHandler: nil)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension PostsViewController: UITableViewDelegate {
    
}

extension PostsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.numberOfRows
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = self.tableView.dequeueReusableCell(withIdentifier: "PostCell", for: indexPath)
        if let postCell = cell as? PostTableViewCell {
            let  cellViewModel = self.viewModel.cellViewModel(at: indexPath)
            postCell.viewModel = cellViewModel
        }
        return cell
    }
    
    
}
