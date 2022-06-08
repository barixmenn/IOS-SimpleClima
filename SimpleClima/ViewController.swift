//
//  ViewController.swift
//  SimpleClima
// barixmen
//  Created by macbook on 16.05.2022.
//

import UIKit

class ViewController: UIViewController {
    
    let api = "c4abe3f92b640f3c65ba8816e5861933"
    let lat = "37.051393"
    let lon = "35.223240"
    
    @IBOutlet weak var WindSpeedLabel: UILabel!
    @IBOutlet weak var FeelsLabel: UILabel!
    @IBOutlet weak var tempLabel: UILabel!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        //MARK: - WeatherJsonApi
        let url = URL(string: "https://api.openweathermap.org/data/2.5/weather?lat=\(lat)&lon=\(lon)&appid=\(api)")
        let session = URLSession.shared
        let task = session.dataTask(with: url!) { data, response, error in
            
            if error != nil {
                print("Error")
                return
            } else {
                
            }
            if data != nil {
                do {
                    let jsonResponse = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as? [String:Any]
                    
                    DispatchQueue.main.async {
                        if let main = jsonResponse!["main"] as? [String:Any]{
                            if let temp = main["temp"] as? Double {
                                self.tempLabel.text = String(Int(temp-275.15))
                            }
                            if let wells = main["feels_like"] as? Double {
                                self.FeelsLabel.text = String(Int(wells-275.15))
                            }
                        }
                        if let wind = jsonResponse!["wind"] as? [String:Any] {
                            if let speed = wind["speed"] as? Double {
                                self.WindSpeedLabel.text = String(speed)
                            }
                        }
                        
                    }
                    
                } catch  {
                    print("Error")
                }
            }
            
        }
        
        task.resume()
    }
}

