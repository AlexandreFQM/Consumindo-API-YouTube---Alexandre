//
//  Tools.swift
//  Alexandre-YouTube
//
//  Created by Alexandre Furquim on 25/10/16.
//
//

import Foundation


//PARAMETERS API
//CHART
let chart = "mostPopular"

//RegionCode
let regionCode = "BR"

//MaxResults
let maxResults = "25"

//API KEY
let apiKey = "AIzaSyCF9eK9E-syQqbRrf5UCblHAXxEckdp9P8"


//URL API
let urlSnippetAPI = "https://www.googleapis.com/youtube/v3/videos?part=snippet&chart=\(chart)&regionCode=\(regionCode)&maxResults=\(maxResults)&key=\(apiKey)"

let urlStaticsAPI = "https://www.googleapis.com/youtube/v3/videos?part=statistics&chart=\(chart)&regionCode=\(regionCode)&maxResults=\(maxResults)&key=\(apiKey)"


//let urlChanelSnippetAPI = "https://www.googleapis.com/youtube/v3/channels?part=snippet&id=UC7i21Xb93NkxhADQ6J2JSMw&key=AIzaSyCF9eK9E-syQqbRrf5UCblHAXxEckdp9P8"


//https://www.googleapis.com/youtube/v3/videos?part=statistics&chart=mostPopular&regionCode=BR&maxResults=25&key=AIzaSyCF9eK9E-syQqbRrf5UCblHAXxEckdp9P8

//"https://www.googleapis.com/youtube/v3/videos?part=snippet&chart=mostPopular&regionCode=BR&maxResults=25&key=AIzaSyCF9eK9E-syQqbRrf5UCblHAXxEckdp9P8"


class Tools: NSObject {
    class func salvarNasPreferencias(value: AnyObject?, forKey: String){
        let userDefaults: UserDefaults = UserDefaults()
        userDefaults.set(value, forKey: forKey)
        userDefaults.synchronize()
    }
    
    class func resgatarDasPreferencias(forKey: String) -> AnyObject?{
        let userDefaults: UserDefaults = UserDefaults()
        return userDefaults.object(forKey: forKey) as AnyObject?
    }
    
    class func removeObjetoDasPreferencia(key k : String){
        let userDefaults: UserDefaults = UserDefaults()
        userDefaults.removeObject(forKey: k)
        userDefaults.synchronize()
    }
    
    class func getDatefromString(data: String) -> NSDate{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        return dateFormatter.date(from: data)! as NSDate
    }
    
    class func getStringfromDateFormated(data: NSDate) -> String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        return dateFormatter.string(from: data as Date)
    }
}

enum stateOfVC {
    case minimized
    case fullScreen
    case hidden
}
enum Direction {
    case up
    case left
    case none
}

