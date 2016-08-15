//
//  AsteroidDatastore.swift
//  NearbyNasa
//
//  Created by Johann Kerr on 8/10/16.
//  Copyright © 2016 Johann Kerr. All rights reserved.
//

import Foundation


public enum SearchType: Int{
    case LastWeek = 7
    case LastMonth = 30
    case lastYear = 365
    
}
class AsteroidDatastore{

    
    static let sharedDataStore = AsteroidDatastore()
    var nearByAsteroids = [Asteroid]()
    var randomAsteroids = [Asteroid]()
    
    
    
    func getPicsByNumber(by:SearchType, completion:()->()){
        var day = by.rawValue - 1
        print(day)
        NasaApiClient.getPicsByNumberOfDays(day) { (picsArray) in
            print(picsArray)
            for item in picsArray{
                //print(item.url)
            }
            completion()
            
        }
    }
    
    
    func getRandomAsteroids(completion:()->()){
        NasaApiClient.getRandomAsteroids { (randomAsteroids) in
            self.randomAsteroids = randomAsteroids
            completion()
        }
        
    }
    
    
    func getNearbyAsteroids(completion:()->()){
        NasaApiClient.getTodaysAsteroids { (asteroids) in
            self.nearByAsteroids = asteroids
            completion()

        }
    }
    
    func getAsteroid(neoRef:String, completion:()->()){
        NasaApiClient.getAsteroid(neoRef) { (asteroid) in
            
            completion()
        }
    }
    
    
    
}
