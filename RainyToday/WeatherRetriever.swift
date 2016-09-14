
import Foundation



typealias CompletionHandler = (success: Bool) -> Void




class WeatherRetriever {

    private let openWeatherMapBaseURL:String
    private let openWeatherMapAPIKey:String
    private var retrievedData:String?
    private var retrievedDataDictionary:[String:AnyObject]?
    
    
    init() {
        //self.openWeatherMapBaseURL = "http://api.openweathermap.org/data/2.5/weather"
        self.openWeatherMapBaseURL = "http://api.openweathermap.org/data/2.5/weather"
        self.openWeatherMapAPIKey = "8f54199ad9a312cd87c0d0adcffcc85d"
        self.retrievedData = nil
        self.retrievedDataDictionary = nil
    }
    
    func getWeather(city_id: Int, completionHandler: CompletionHandler) {
        
        let session = NSURLSession.sharedSession()
        print("ID is \(city_id)")
        
        let weatherRequestURL = NSURL(string: "\(openWeatherMapBaseURL)?APPID=\(openWeatherMapAPIKey)&id=\(city_id)")!
        
        _ = session.dataTaskWithURL(weatherRequestURL, completionHandler:
            { (data: NSData?, response: NSURLResponse?, error: NSError?) -> Void in
        
                do {
                    if NSString(data: data!, encoding: NSUTF8StringEncoding) != nil {
                        self.retrievedDataDictionary = try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableContainers) as! NSDictionary as? [String : AnyObject]
                    
                        let flag = true
                        completionHandler(success: flag)
                        
                    }
                    
                    
                }
                catch {
                    print("Error")
                }
        
        }).resume()
     
    }
    
    func kelvinToCelsius(temp_kelvin:Float) -> Float {
        let temp_celsius = temp_kelvin - 273.15
        return temp_celsius
    }
    
    
    func getCityLongitude() -> Float {
        return self.retrievedDataDictionary!["coord"]!["lon"] as! Float
    }
    
    func getCityLatitude() -> Float {
        return self.retrievedDataDictionary!["coord"]!["lat"] as! Float
    }
    
    func getWeatherId() -> Int {
        return self.retrievedDataDictionary!["weather"]![0]!["id"] as! Int
    }
    
    func getWeatherMain() -> String {
        return self.retrievedDataDictionary!["weather"]![0]!["main"] as! String
    }
    
    func getWeatherDescription() -> String {
        return self.retrievedDataDictionary!["weather"]![0]!["description"] as! String
    }
    
    func getTemperature() -> Float {
        return self.retrievedDataDictionary!["main"]!["temp"] as! Float
    }
    
    func getMinTemperature() -> Float {
        return self.retrievedDataDictionary!["main"]!["temp_min"] as! Float
    }
    
    func getMaxTemperature() -> Float {
        return self.retrievedDataDictionary!["main"]!["temp_max"] as! Float
    }
    
    func getPressure() -> Float {
        return self.retrievedDataDictionary!["main"]!["pressure"] as! Float
    }

    func getHumidity() -> Float {
        return self.retrievedDataDictionary!["main"]!["humidity"] as! Float
    }
    
    func getWindSpeed() -> Float {
        return self.retrievedDataDictionary!["wind"]!["speed"] as! Float
    }
    
    func getClouds() -> Int {
        return self.retrievedDataDictionary!["clouds"]!["all"] as! Int
    }
    
    func getCity() -> String {
        return self.retrievedDataDictionary!["name"] as! String
    }
    
    func getCountryCode() -> String {
        return self.retrievedDataDictionary!["sys"]!["country"] as! String
    }
    
    
    
    
    
    
}