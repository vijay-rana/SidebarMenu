//
//  ClientDetailCell.swift
//  SidebarMenu
//
//  Created by KBS on 17/09/15.
//  Copyright (c) 2015 AppCoda. All rights reserved.
//

import Foundation

class UserCell: UITableViewCell
    
    
{
    
    @IBOutlet weak var UserName: UILabel!
    @IBOutlet weak var Password: UILabel!
    @IBOutlet weak var Role: UILabel!
    @IBOutlet weak var QuickAccess: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
