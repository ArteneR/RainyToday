
import UIKit

 typealias FinishedFetchingData = () -> ()

class ViewController: UIViewController {

   
    @IBOutlet weak var city_UITextField: UITextField!
    @IBOutlet weak var retrievingInfoMessage_UILabel: UILabel!
    @IBOutlet weak var retrievedInfo_UITextView: UITextView!
    
    @IBAction func clickedGetWeather(sender: UIButton) {
        let city_name: String
        city_name = city_UITextField.text!
        print("Selected city: \(city_name)")
        retrievingInfoMessage_UILabel.text = "Fetching information for city \(city_name)"
        
        self.getWeatherInfo(city_name)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func getWeatherInfo(city: String) {
        let weather = WeatherRetriever()
        
        // weather.getWeather(city)
        
        weather.getWeather(city, completionHandler: { (success) -> Void in
            
            if success {
                print("Success!")
            }
            else {
                print("Error!")
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
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }


}
