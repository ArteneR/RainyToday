
import Foundation


class WeatherRetriever {

    private let openWeatherMapBaseURL:String
    private let openWeatherMapAPIKey:String
    private var retrievedData:String?
    private var retrievedDataDictionary:[String:AnyObject]?
    
    
    init() {
        self.openWeatherMapBaseURL = "http://api.openweathermap.org/data/2.5/weather"
        self.openWeatherMapAPIKey = "8f54199ad9a312cd87c0d0adcffcc85d"
        self.retrievedData = nil
        self.retrievedDataDictionary = nil
    }
    
    func getWeather(city: String) {
        
        let session = NSURLSession.sharedSession()
        
        let weatherRequestURL = NSURL(string: "\(openWeatherMapBaseURL)?APPID=\(openWeatherMapAPIKey)&q=\(city)")!
        
        let dataTask = session.dataTaskWithURL(weatherRequestURL) {
            (data: NSData?, response: NSURLResponse?, error: NSError?) in
            if let error = error {
                // Case 1: Error
                // We got some kind of error while trying to get data from the server.
                print("Error:\n\(error)")
            }
            else {
                // Case 2: Success
                // We got a response from the server!
                print("Raw data:\n\(data!)\n")
                self.retrievedData = String(data: data!, encoding: NSUTF8StringEncoding)!
                print("Human-readable data:\n\(self.retrievedData)")
                
                self.retrievedDataDictionary = self.convertStringToDictionary(self.retrievedData!)!
            }
        }
        
        // The data task is set up...launch it!
        dataTask.resume();
        
    }
    
    
    func convertStringToDictionary(text: String) -> [String:AnyObject]? {
        if let data = text.dataUsingEncoding(NSUTF8StringEncoding) {
            do {
                return try NSJSONSerialization.JSONObjectWithData(data, options: []) as? [String:AnyObject]
            }
            catch let error as NSError {
                print(error)
            }
        }
        return nil
    }
    
    
    func getWeatherCode() {
        print("HERE")
        print(self.retrievedDataDictionary);
    }
    
    
}