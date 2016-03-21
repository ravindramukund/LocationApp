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
        DistanceLbl.text = Result.distance
        iconView.image = DataService.instance.imageForPath(Results.iconUrl)
    }

}