//
//  TherapistCell.swift
//  SidebarMenu
//
//  Created by KBS on 23/09/15.
//  Copyright (c) 2015 AppCoda. All rights reserved.
//

import Foundation


class TherapistCell: UITableViewCell

{
    
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var lblTherapist: UILabel!
    @IBOutlet weak var lblAreaTreated: UILabel!
    @IBOutlet weak var lblFE: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        return
        // Configure the view for the selected state
    }
}

