//
//  Asteroid.swift
//  NearbyNasa
//
//  Created by Johann Kerr on 8/10/16.
//  Copyright © 2016 Johann Kerr. All rights reserved.
//

import Foundation
import SwiftyJSON


class Asteroid{
    var diameter: Double
    var isHazardous: Bool
    var neoRef: String!
    var velocity: Double!
    var missDistanceInKilometers: Double!
    var name:String!
    var date: String!
    
    
    init(dict: JSON){
        
        diameter = dict["estimated_diameter"]["kilometers"]["estimated_diameter_max"].double!
        isHazardous = dict["is_potentially_hazardous_asteroid"].bool!
        neoRef = dict["neo_reference_id"].string
        velocity = Double(dict["close_approach_data"][0]["relative_velocity"]["kilometers_per_second"].string!)
        missDistanceInKilometers = Double(dict["close_approach_data"][0]["miss_distance"]["kilometers"].string!)
        name = dict["name"].string
        date = dict["close_approach_data"][0]["close_approach_date"].string
   
    }
    
    
}
