//
//  Results.swift
//  locationApp
//
//  Created by Ravindra Mukund on 16/03/16.
//  Copyright © 2016 Ravindra Mukund. All rights reserved.
//

import Foundation

class Results {
    
    private var _iconUrl: String
    private var _desc: String
    private var _dist: String
    
    
    var iconUrl: String {
        return _iconUrl
    }
    
    var desc:String {
        return _desc
    }
    var distance: String {
        return _dist
    }
    
    
    init(iconUrl:String, desc:String ,dist:String) {
        self._iconUrl = iconUrl
        self._desc = desc
        self._dist = dist
    }
}