
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
                    if let pString = NSString(data: data!, encoding: NSUTF8StringEncoding) {
                        self.retrievedDataDictionary = try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableContainers) as! NSDictionary as? [String : AnyObject]
                        
                        let longitude = self.retrievedDataDictionary!["base"] as! String
                        let code = self.retrievedDataDictionary!["cod"] as! Int
                        
                        
                        print("LONGITUDE: ")
                        print(longitude)
                        print(code)
                        
                        let flag = true
                        completionHandler(success: flag)
                        
                    }
                    
                    
                }
                catch {
                    print("Error")
                }
        
        }).resume()
     
    }
    
    
    func getWeatherCode() {
        print(self.retrievedDataDictionary!["cod"] as! Int);
    }
    
    
}