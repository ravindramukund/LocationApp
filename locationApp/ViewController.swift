//
//  ViewController.swift
//  locationApp
//
//  Created by Ravindra Mukund on 16/03/16.
//  Copyright © 2016 Ravindra Mukund. All rights reserved.
//
//
//  ViewController.swift
//  LocationApp1
//
//  Created by Ravindra Mukund on 09/03/16.
//  Copyright © 2016 Ravindra Mukund. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation
import Foundation

class ViewController: UIViewController, UITableViewDelegate , UITableViewDataSource  {
    
    //variables
    
    var latitude: Double!
    var longitude: Double!
    var placeName: String!
    var latLong: String!
    var r : Int!
    var Result = [Results]()
    var data: NSData?
    
    //response
    
    var icon:String!
    var name:String!
    var rating:String!
    var types:String!
    var vicinity:String!
    var lat:String!
    var lng:String!
    
    //outlets
    
    @IBOutlet weak var latTextField: UITextField!
    @IBOutlet weak var longTextField: UITextField!
    @IBOutlet weak var searchBtn: UIButton!
    @IBOutlet weak var RadiusTextField: UITextField!
    @IBOutlet weak var tableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self

    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let Resultobj = Result[indexPath.row]
        
        if let cell = tableView.dequeueReusableCellWithIdentifier("ResultsCell") as? ResultsCell {
             cell.ConfigureCell(Resultobj)
             return cell
        } else {
            let cell = ResultsCell()
            cell.ConfigureCell(Resultobj)
            return cell
        }
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 44.0
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Result.count
    }
    
    //when search button pressed
    
    @IBAction func SearchBtnPressed(sender: UIButton) {
        
        
        latTextField.resignFirstResponder()
        longTextField.resignFirstResponder()
        RadiusTextField.resignFirstResponder()
        
        
        let r = String(UTF8String:RadiusTextField.text!)!
        print (r)
        
        let lon12:Double = Double(longTextField.text!)!
        let lat12:Double = Double(latTextField.text!)!
    
        let latitude = String(UTF8String:latTextField.text!)!
        let longitude = String(UTF8String:longTextField.text!)!
        
        let latLong = latitude + "," + longitude
        var placeList = [String]() //Array
        placeList.append("\(latLong)")
        
        
        // to send request and get response
        
        let urlString = "https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=\(latLong)&radius=\(r)&key=AIzaSyArhp32pwS15x6xC9JQgKNV8A5_WHNQfOo"
        
        let session =  NSURLSession.sharedSession()
        let url = NSURL(string: urlString)!
        
        session.dataTaskWithURL(url) { (let data: NSData?, response: NSURLResponse?, error: NSError?) -> Void in
            
            if let responseData = data {
                
                do{
                    let json:NSDictionary = try NSJSONSerialization.JSONObjectWithData(responseData, options: NSJSONReadingOptions.AllowFragments) as! NSDictionary
                    
                    
                    //Update your UI
                    
                    dispatch_async(dispatch_get_main_queue(), { () -> Void in
                        
                        self.Result = []
                        
                        let responseString = NSString(data:responseData , encoding: NSUTF8StringEncoding);
                        
                        let resultsArray = json["results"] as! NSArray;
                    
                        for resultsdict in resultsArray
                        {
                            
                            let geometrydict = resultsdict["geometry"] as! NSDictionary;
                            let locationdict = geometrydict["location"] as! NSDictionary;
                            let lat = locationdict["lat"] as! Double;
                            let lng = locationdict["lng"] as! Double;
                            
                            print("\n the user lat long are \(lat12) and \(lon12)")
                            
                            let resultsdictVal: NSDictionary = resultsdict as! NSDictionary;
                            let name = resultsdictVal["name"] as! String;
                            let types = resultsdictVal["types"] as! NSArray;
                            let icon = resultsdictVal["icon"] as! String;
                            
                            // Getting image from url and showing it iconView
                            // this is to convert the string to a url and storing the image in a temp variable and then showing the output on simulator from the image outlet. These 6 lines of code.
                            
                            
                            let iconString = resultsdictVal["icon"]!
                            let iconUrl = NSURL(string: "\(iconString)")!
                            print("url = \(iconUrl)")
//                            
//                            let url = NSURL(string: "\(Result.iconUrl)")
//                            let data = NSData(contentsOfURL: url!)
//                            
//                            iconView.image = UIImage(data: data!)
//

                            
                            print("the lats and longs of place \(name) are \(lat) and \(lng)")
                            
                            
                            
                            //Haversine's formula to calculate radius of earth
                            
                            let lat1 = lat12
                            let lat2 = lat
                            let lon1 = lon12
                            let lon2 = lng

                            let R = 6371.00000 //radius of earth in km
                            let deltaLat = (lat2 - lat1) * M_PI / 180.0
                            let deltaLon = (lon2 - lon1) * M_PI / 180.0
                            let a = sin(deltaLat/2) * sin(deltaLat/2) +
                                  cos(lat1) * cos(lat2) * sin(deltaLon/2) * sin(deltaLon/2)
                            let c = 2 * atan2( sqrt(a), sqrt(1-a) )
                            let d = R * c
                            let distance = d * 1000
                            let d1 = Int(distance)
                            print ("distance between 2 places is \(d1) meters \n\n")
                            let dist = String(d1)
                            
                            // if the result does not contain political in type of place, only then shows results
                            

                            if(!types.containsObject("political"))
                            
                            {
                                let ResultsObj = Results(iconUrl: icon, desc: name, dist: dist);
                                self.Result.append(ResultsObj);
                            }
                        }
                        print("response is \(responseString)")
                        self.tableView.reloadData();
                        
                    })
                } catch {
                    print ("could not serialize")
                }
            }
        }  .resume()
    }
}