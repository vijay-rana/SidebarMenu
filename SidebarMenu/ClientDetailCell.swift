//
//  ClientDetailCell.swift
//  SidebarMenu
//
//  Created by KBS on 17/09/15.
//  Copyright (c) 2015 AppCoda. All rights reserved.
//

import Foundation

class ClientDetailCell: UITableViewCell


{
    
    @IBOutlet weak var FirstName: UILabel!
    @IBOutlet weak var LastName: UILabel!
    @IBOutlet weak var Telephone: UILabel!
    @IBOutlet weak var DOB: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }

}
