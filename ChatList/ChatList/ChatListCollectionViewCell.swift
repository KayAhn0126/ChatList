//
//  ChatListCollectionViewCell.swift
//  ChatList
//
//  Created by Kay on 2022/08/16.
//

import UIKit

class ChatListCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var thumbnailImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var conversationLabel: UILabel!
    @IBOutlet weak var dataLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        thumbnailImageView.layer.cornerRadius = 10
    }
    
    func configure(_ chatModel: ChatModel) {
        thumbnailImageView.image = UIImage(named: chatModel.name)
        nameLabel.text = chatModel.name
        conversationLabel.text = chatModel.chat
        dataLabel.text = formattedDateString(dateString: chatModel.date)
    }
    
    func formattedDateString(dateString: String) -> String {
        // String -> Date -> String
        // 2022-04-01 > 4/1
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        
        // 문자열 -> date
        if let date = formatter.date(from: dateString) {
            formatter.dateFormat = "M/d"
            return formatter.string(from: date)
        } else {
            return ""
        }
    }
}
