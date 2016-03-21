//
//  ResultsCell.swift
//  locationApp
//
//  Created by Ravindra Mukund on 16/03/16.
//  Copyright © 2016 Ravindra Mukund. All rights reserved.
//

import UIKit

class ResultsCell: UITableViewCell {

    
    @IBOutlet weak var iconView: UIImageView!
    @IBOutlet weak var DescriptionLbl: UILabel!
    @IBOutlet weak var DistanceLbl: UILabel!
    
    func ConfigureCell(Result: Results) {
        
        DescriptionLbl.text = Result.desc
        DistanceLbl.text = "\(Result.distance) m"
        
        
        // this is to convert the string to a url and storing the image in a temp variable and then showing the output on simulator from the image outlet. These 6 lines of code.
        
        
//        let iconString = resultsdictVal["icon"]!
//        let iconUrl = NSURL(string: "\(iconString)")!
//        print("url = \(iconUrl)")

        
        let url = NSURL(string: "\(Result.iconUrl)")
        let data = NSData(contentsOfURL: url!)
        iconView.image = UIImage(data: data!)
    }

}