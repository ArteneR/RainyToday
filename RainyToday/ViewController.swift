
import UIKit

 typealias FinishedFetchingData = () -> ()

class ViewController: UIViewController {

   
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
        self.getWeatherInfo()
    
    }
    
    func getWeatherInfo() {
        let city:String = "Timisoara"
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
            
            
            
        })
    
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }


}
