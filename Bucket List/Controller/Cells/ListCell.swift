//
//  ListCell.swift
//  Bucket List
//
//  Created by amr on 02/06/2022.
//

import UIKit

class ListCell: UITableViewCell {

    @IBOutlet weak var cellView: UIView!
    @IBOutlet weak var itemLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        cellView.layer.cornerRadius = 20
        cellView.layer.cornerCurve = .continuous
//        cellView.backgroundColor = UIColor(red: 224/255, green: 102/255, blue: 237/255, alpha: 0.5)
        cellView.layer.shadowColor = UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.3).cgColor
        cellView.layer.shadowOpacity = 0.5
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
