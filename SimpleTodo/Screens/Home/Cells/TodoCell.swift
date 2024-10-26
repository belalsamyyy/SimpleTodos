//
//  TodoCell.swift
//  SimpleTodo
//
//  Created by Belal Samy on 10/26/24.
//

import UIKit

//MARK: - Cell Types

enum TodoType {
    case placeholder
    case addedToMyList
}

enum TodoStatus {
    case completed
    case incomplete
     
    var image: UIImage {
        switch self {
        case .completed:
            return UIImage(systemName: "checkmark.circle.fill")!
        case .incomplete:
            return UIImage(systemName: "circle")!
        }
    }
}

class TodoCell: UITableViewCell {

    //MARK: - Outlets

    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var isCompletedImg: UIImageView!
     
    //MARK: - LifeCycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setupUI()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    //MARK: - Methods
    
    func setupUI() {
        self.backgroundColor = .white
    }
     
    func configure(data: TodoListItemModel, type: TodoType) {
        titleLbl.text = data.title
        isCompletedImg.image = data.completed ? TodoStatus.completed.image : TodoStatus.incomplete.image
         
        switch type {
        case .addedToMyList:
            titleLbl.textColor = UIColor.black
            isCompletedImg.tintColor = UIColor.black
            
        case .placeholder:
            titleLbl.textColor = UIColor.lightGray
            isCompletedImg.tintColor = UIColor.lightGray
        }
    }
    
}
