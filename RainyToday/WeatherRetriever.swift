
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
    
    func getWeather(city: String, completionHandler: CompletionHandler) {
        
        let session = NSURLSession.sharedSession()
        
        let weatherRequestURL = NSURL(string: "\(openWeatherMapBaseURL)?APPID=\(openWeatherMapAPIKey)&q=\(city)")!
        
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
    
    
    func getCityLongitude() -> Float {
        return self.retrievedDataDictionary!["coord"]!["lon"] as! Float
    }
    
    func getCityLatitude() -> Float {
        return self.retrievedDataDictionary!["coord"]!["lat"] as! Float
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
    
    
    func getWeatherCode() -> Int {
        return self.retrievedDataDictionary!["cod"] as! Int
    }
    
    
    
    
}