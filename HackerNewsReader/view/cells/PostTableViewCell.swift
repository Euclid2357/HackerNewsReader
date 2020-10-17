//
//  PostTableViewCell.swift
//  HackerNewsReader
//
//  Created by Claudio on 10/16/20.
//

import UIKit

class PostTableViewCell: UITableViewCell {
    
    // MARK: - Outlets
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var detailLabel: UILabel!
    
    var viewModel: PostCellViewModel? {
        didSet {
            setupUI()
        }
    }
    fileprivate func setupUI() {
        self.titleLabel.text = viewModel?.title

        self.detailLabel.text = viewModel?.detail      
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
