
import UIKit
import Foundation


 typealias FinishedFetchingData = () -> ()

class ViewController: UIViewController {

   
    @IBOutlet weak var city_UITextField: UITextField!
    @IBOutlet weak var retrievingInfoMessage_UILabel: UILabel!
    @IBOutlet weak var retrievedInfo_UITextView: UITextView!
    @IBOutlet weak var weatherIcon_UIImageView: UIImageView!
    
    
    
    @IBAction func clickedGetWeather(sender: UIButton) {
        city_UITextField.resignFirstResponder()
        let city_name: String
        city_name = city_UITextField.text!
        print("Selected city: \(city_name)")
        retrievingInfoMessage_UILabel.text = "Fetching information for city \(city_name)"
        
        self.getWeatherInfo(city_name)
    }
    
    
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    
    func getWeatherInfo(city: String) {
        
        let city_id = getCityID(city)
        print("CITY ID: \(city_id)")
      
        if city_id == -1 {
            print("invalid city!")
            dispatch_async(dispatch_get_main_queue(), {
                self.retrievedInfo_UITextView.text = "Couldn't fetch information for the specified city \(city) ¬:("
            })
            return ;
        }
        
        let weather = WeatherRetriever()
        
        weather.getWeather(city_id as Int, completionHandler: { (success) -> Void in
            
            if success {
                print("Success!")
            }
            else {
                print("Error!")
                dispatch_async(dispatch_get_main_queue(), {
                    self.retrievedInfo_UITextView.text = "Couldn't fetch information for the specified city :("
                })
                return ;
            }
            
            print(weather.getWeatherCode())
            print(weather.getCityLatitude())
            print(weather.getCityLongitude())
            print(weather.kelvinToCelsius(weather.getTemperature()))
            print(weather.getHumidity())
            print(weather.getPressure())
            print(weather.kelvinToCelsius(weather.getMinTemperature()))
            print(weather.kelvinToCelsius(weather.getMaxTemperature()))
            
            
            dispatch_async(dispatch_get_main_queue(), {
                self.retrievedInfo_UITextView.text =
                    "Code: \(weather.getWeatherCode())\n" +
                    "Lat: \(weather.getCityLatitude())\n" +
                    "Lon: \(weather.getCityLongitude())\n" +
                    "Temperature: \(weather.kelvinToCelsius(weather.getTemperature()))\n" +
                    "Min temperature: \(weather.kelvinToCelsius(weather.getMinTemperature()))\n" +
                    "Max temperature: \(weather.kelvinToCelsius(weather.getMaxTemperature()))\n" +
                    "Humidity: \(weather.getHumidity())\n" +
                    "Pressure: \(weather.getPressure())\n"
                
                
                let weatherCode = weather.getWeatherCode()
                var weatherIconName:String = "02d" // Should be no weather info here
                
                switch (weatherCode) {
                    case 200, 201, 202, 210, 211, 212, 221, 230, 231, 232:
                        weatherIconName = "11d"
                        break
                    
                    case 300, 301, 302, 310, 311, 312, 313, 314, 321, 520, 521, 522, 531:
                        weatherIconName = "09d"
                        break
                    
                    case 500, 501, 502, 503, 504:
                        weatherIconName = "10d"
                        break
                    
                    case 511, 600, 601, 602, 611, 612, 615, 616, 620, 621, 622:
                        weatherIconName = "13d"
                        break
                    
                    case 701, 711, 721, 731, 741, 751, 761, 762, 771, 781:
                        weatherIconName = "50d"
                        break
                    
                    case 800:
                        weatherIconName = "01d"
                        break
                    
                    case 801:
                        weatherIconName = "02d"
                        break
                    
                    case 802:
                        weatherIconName = "03d"
                        break
                    
                    case 803, 804:
                        weatherIconName = "04d"
                        break
                    
                    case 900, 901, 902, 903, 904, 905, 906:
                        // extreme
                        break
                    
                    case 951, 952, 953, 954, 955, 956, 957, 958, 959, 960, 961, 962:
                        // additional
                        break
                    
                        default:
                            break
                }
                
                
                // if night replace 'd' with 'n'
              
                
                self.weatherIcon_UIImageView.image = UIImage(named: weatherIconName)
                
            })
            
        })
    
    }
    
    
    func getCityID(cityName: String) -> Int {
                let filename = "cities_list"
        
                if let path = NSBundle.mainBundle().pathForResource(filename, ofType: "json") {
                    do {
                        let data = try NSData(contentsOfFile: path, options: NSDataReadingOptions.DataReadingMapped)
                        do {
                            let dictionary: AnyObject? = try NSJSONSerialization.JSONObjectWithData(data,
                                                                                                    options: NSJSONReadingOptions())
                            if let dictionary = dictionary as? Dictionary<String, AnyObject> {
                                let total_records = dictionary["records"]!.count
                                
                                // Should replace this with BinarySearch (after the file is sorted alphabetically by city name)
                                // Must also include Country
                                for index in 0...total_records-1 {
                                    if (dictionary["records"]![index]["n"] as! String) == cityName {
                                        print("found!")
                                    
                                        return dictionary["records"]![index]["id"] as! Int
                                    }
                                }
                                return -1
                                
                            }
                            else {
                                print("Level file '\(filename)' is not valid JSON")
                                return -1
                            }
                        }
                        catch {
                            print("Level file '\(filename)' is not valid JSON: \(error)")
                            return -1
                        }
                        
                        
                    }catch {
                        print("Could not load level file: \(filename), error: \(error)")
                        return -1
                    }
                    
                } else {
                    print("Could not find level file: \(filename)")
                    return -1
                }
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }


}
