
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
        
        weather.getWeather(city)
    
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }


}
