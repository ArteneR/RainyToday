
import UIKit
import Foundation


 typealias FinishedFetchingData = () -> ()

class ViewController: UIViewController {

   
    @IBOutlet weak var city_UITextField: UITextField!
    @IBOutlet weak var retrievingInfoMessage_UILabel: UILabel!
    @IBOutlet weak var retrievedInfo_UITextView: UITextView!
    
    @IBAction func clickedGetWeather(sender: UIButton) {
        city_UITextField.resignFirstResponder()
        let city_name: String
        city_name = city_UITextField.text!
        print("Selected city: \(city_name)")
        retrievingInfoMessage_UILabel.text = "Fetching information for city \(city_name)"
        
        self.getWeatherInfo(city_name)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func getWeatherInfo(city: String) {
        
        let city_id = getCityID(city)
        print("CITY ID: \(city_id)")
        
        
        let weather = WeatherRetriever()
        
        // weather.getWeather(city)
        
        weather.getWeather(city, completionHandler: { (success) -> Void in
            
            if success {
                print("Success!")
            }
            else {
                print("Error!")
                dispatch_async(dispatch_get_main_queue(), {
                    self.retrievedInfo_UITextView.text = "Couldn't fetch information for the specified city :(d"
                })
                return ;
            }
            
            print(weather.getCity())
            if weather.getCity() != "" {
                print("invalid city!")
            }
            
            print(weather.getWeatherCode())
            print(weather.getCityLatitude())
            print(weather.getCityLongitude())
            print(weather.getTemperature())
            print(weather.getHumidity())
            print(weather.getPressure())
            print(weather.getMinTemperature())
            print(weather.getMaxTemperature())
            
            
            dispatch_async(dispatch_get_main_queue(), {
                self.retrievedInfo_UITextView.text =
                    "Code: \(weather.getWeatherCode())\n" +
                    "Lat: \(weather.getCityLatitude())\n" +
                    "Lon: \(weather.getCityLongitude())\n" +
                    "Temperature: \(weather.getTemperature())\n" +
                    "Min temperature: \(weather.getMinTemperature())\n" +
                    "Max temperature: \(weather.getMaxTemperature())\n" +
                    "Humidity: \(weather.getHumidity())\n" +
                    "Pressure: \(weather.getPressure())\n"
            })
            
        })
    
    }
    
    func getCityID(cityName: String) -> String {
        
                let filename = "cities_list"
        
                if let path = NSBundle.mainBundle().pathForResource(filename, ofType: "json") {
                    
                    
                    do{
                        let data = try NSData(contentsOfFile: path, options: NSDataReadingOptions.DataReadingMapped)
                        do{
                            let dictionary: AnyObject? = try NSJSONSerialization.JSONObjectWithData(data,
                                                                                                    options: NSJSONReadingOptions())
                            if let dictionary = dictionary as? Dictionary<String, AnyObject> {
                                print("I HATE SWIFT!")
                                print(dictionary["records"]![0]["id"] as! Int)
                                
                            }
                            else {
                                print("Level file '\(filename)' is not valid JSON")
                                return "NULL"
                            }
                        }
                        catch {
                            print("Level file '\(filename)' is not valid JSON: \(error)")
                            return "NULL"
                        }
                        
                        
                    }catch {
                        print("Could not load level file: \(filename), error: \(error)")
                        return "NULL"
                    }
                    
                } else {
                    print("Could not find level file: \(filename)")
                    return "NULL"
                }
       
        
        
        
        
        
        return "CITY_NAME"
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }


}
