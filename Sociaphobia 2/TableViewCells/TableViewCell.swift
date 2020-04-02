//
//  TableViewCell.swift
//  Sociaphobia 2
//
//  Created by Evgeniy Uskov on 30.03.2020.
//  Copyright © 2020 Evgeniy Uskov. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    weak var delegate : PlaySoundDelegate?
    
    @IBOutlet weak var soundButton: UIButton!
    
    @IBAction func keyPressed(_ sender: UIButton) {
        delegate?.didPlayedSound(sender)
    }
        
    func setup(soundName: String, title: String, row: Int) {
        contentView.backgroundColor = UIHelper.getViewBackgroundColor()
        if row == 0 || (row + 1) % 3 == 1 {
            soundButton.setBackgroundImage(UIImage(named: "button-back"), for: .normal)
        } else if row == 1 || (row + 1) % 3 == 2 {
            soundButton.setBackgroundImage(UIImage(named: "button-back2"), for: .normal)
        }else if row == 2 || (row + 1) % 3 == 0 {
            soundButton.setBackgroundImage(UIImage(named: "button-back3"), for: .normal)
        }
        soundButton.setTitle(title, for: .normal)
        soundButton.tintColor = UIHelper.getCellBackgroundColor() //TextForegroundColor()
        soundButton.backgroundColor = .clear
        soundButton.layer.cornerRadius = 10
        soundButton.contentEdgeInsets = UIEdgeInsets(top: 8, left: 16, bottom: 8, right: 16)
    }
}
