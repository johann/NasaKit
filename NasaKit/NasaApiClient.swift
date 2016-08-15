//
//  NasaApiClient.swift
//  NearbyNasa
//
//  Created by Johann Kerr on 8/9/16.
//  Copyright © 2016 Johann Kerr. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class NasaApiClient{
    
    class func getPicOfTheDay(completion:(APOD)->()){
        let url = "\(Constants.URL.apiPicURL)\(Constants.apiKey)"
        Alamofire.request(.GET, url).responseJSON { (response) in
            guard let jsonData = response.data else{ assertionFailure("no json");return }
            let json = JSON(data:jsonData)
            let newPic = APOD(dict: json)
            completion(newPic)
        }
    }
    
    class func getPicsByNumberOfDays(numberOfDays:Int, completion:[APOD]->()){
        let url = "\(Constants.URL.apiPicURL)\(Constants.apiKey)"
        var apodArray = [APOD]()
        var operationArray = [NSOperation]()
        
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let queue = NSOperationQueue()
        
        queue.qualityOfService = .Background
  
        for i in 0...numberOfDays{
            var date : NSDate!
            if i == 0{
                date = NSDate()
            }else{
                date = NSCalendar.currentCalendar().dateByAddingUnit(.Day,
                                                                     value: -i, toDate: NSDate(), options: [])!
            }
            var dateString = dateFormatter.stringFromDate(date)
            var photoOperation = NSBlockOperation{
                Alamofire.request(.GET, url, parameters: ["date":dateString]).responseJSON { (response) in
                    guard let jsonData = response.data else{ assertionFailure("no json");return }
                    let json = JSON(data:jsonData)
                    //print(json)
                    let newPic = APOD(dict: json)
                    apodArray.append(newPic)
                    print("running")
                    
                }
                
            }
            
            operationArray.append(photoOperation)
        }
        let completionOperation = NSOperation()
        
//        let completionOperation = NSBlockOperation{
//            completion(apodArray)
//        }
        
        operationArray.append(completionOperation)
        queue.addOperations(operationArray, waitUntilFinished: true)
        
        
        
        
        
    }
    
    
    class func getPicsOfTheWeek(completion:[APOD]->()){
        let url = "\(Constants.URL.apiPicURL)\(Constants.apiKey)"
        var apodArray = [APOD]()
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        var queue = NSOperationQueue()
        
        queue.qualityOfService = .Background
        for i in 0...30{
            var date : NSDate!
            if i == 0{
                date = NSDate()
            }else{
                date = NSCalendar.currentCalendar().dateByAddingUnit(.Day,
                                                                         value: -i, toDate: NSDate(), options: [])!
            }
            var dateString = dateFormatter.stringFromDate(date)
            var photoOperation = NSBlockOperation{
                Alamofire.request(.GET, url, parameters: ["date":dateString]).responseJSON { (response) in
                    guard let jsonData = response.data else{ assertionFailure("no json");return }
                    let json = JSON(data:jsonData)
                    //print(json)
                    let newPic = APOD(dict: json)
                    apodArray.append(newPic)
                }
                
            }
            queue.addOperation(photoOperation)

        }
        
        completion(apodArray)
        
      
        
    }
   
    

    class func getAsteroid(value:String, completion:(Asteroid)->()){
        let url = "\(Constants.apiItemURL)\(value)?api_key=\(Constants.apiKey)"
        
        Alamofire.request(.GET, url).responseJSON { (response) in
            guard let jsonData = response.data else{ assertionFailure("no json");return }
            let json = JSON(data:jsonData)
            let newAsteroid = Asteroid(dict: json)
            completion(newAsteroid)
           
        }
    }
    class func getTodaysAsteroids(completion:([Asteroid])->()){
        var date = NSDate()
        let dateFormatter = NSDateFormatter()
        var asteroidDataArray = [Asteroid]()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        var todayString = dateFormatter.stringFromDate(date)
        var oneDayfromNow: NSDate {
            return NSCalendar.currentCalendar().dateByAddingUnit(.Day,
                                                                 value: 1, toDate: NSDate(), options: [])!
        }
        let tomorrowString = dateFormatter.stringFromDate(oneDayfromNow)
        let url = "\(Constants.apiFeedURL)?start_date=\(todayString)&end_date=\(tomorrowString)&api_key=\(Constants.apiKey)"
        
        Alamofire.request(.GET, url).responseJSON { (response) in
            guard let jsonData = response.data else{ assertionFailure("no json");return }
            let json = JSON(data:jsonData)
            
            guard let asteroidArray = json["near_earth_objects"][todayString].array else{assertionFailure("Failed to set asteroid");return}
            
            for asteroid in asteroidArray{
                let newAsteroid = Asteroid(dict: asteroid)
                asteroidDataArray.append(newAsteroid)
            }
            
            completion(asteroidDataArray)
        }
        
    }
    class func getRandomAsteroids(completion:([Asteroid])->()){
        var asteroidDataArray = [Asteroid]()
        let url = "\(Constants.apiRandomURL)\(Constants.apiKey)"
        Alamofire.request(.GET, url).responseJSON { (response) in
            guard let jsonData = response.data else{ assertionFailure("no json");return }
            let json = JSON(data:jsonData)
            guard let asteroidArray = json["near_earth_objects"].array else{assertionFailure("Failed to set asteroid");return}
            for asteroid in asteroidArray{
                let newAsteroid = Asteroid(dict: asteroid)
                asteroidDataArray.append(newAsteroid)
            }
            completion(asteroidDataArray)
        }
    }
    
    
}
