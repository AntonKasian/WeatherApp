//
//  DetailViewController.swift
//  WeatherApp
//
//  Created by Anton on 23.05.23.
//

import UIKit

import SVGKit

class DetailViewController: UIViewController {
    
    @IBOutlet weak var nameCityLabel: UILabel!
    @IBOutlet weak var viewCity: UIView!
    @IBOutlet weak var conditionLabel: UILabel!
    @IBOutlet weak var tempCity: UILabel!
    
    @IBOutlet weak var pressureLabel: UILabel!
    @IBOutlet weak var windSpeedLabel: UILabel!
    @IBOutlet weak var minTempLabel: UILabel!
    @IBOutlet weak var maxTempLabel: UILabel!
    
    var  weatherModel: Weather?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        refreshLables()
    }
    
    
    func refreshLables() {
        nameCityLabel.text = weatherModel?.name
        
        if let conditionCode = weatherModel?.conditionCode,
           let url = URL(string: "https://yastatic.net/weather/i/icons/funky/dark/\(conditionCode).svg") {
            
            URLSession.shared.dataTask(with: url) { (data, response, error) in
                if let data = data {
                    DispatchQueue.main.async {
                        let parser = SVGKImage(data: data)
                        let weatherImage = UIImageView(image: parser?.uiImage)
                        weatherImage.frame = self.viewCity.bounds
                        self.viewCity.addSubview(weatherImage)
                    }
                }
            }.resume()
        }
        
        conditionLabel.text = weatherModel?.conditionString
                //tempCity.text = "\(weatherModel?.temperature ?? 0)"
        tempCity.text = weatherModel?.temperatureString
                pressureLabel.text = "\(weatherModel?.pressureMm ?? 0)"
                windSpeedLabel.text = "\(weatherModel?.windSpeed ?? 0)"
                minTempLabel.text = "\(weatherModel?.tempMin ?? 0)"
                maxTempLabel.text = "\(weatherModel?.tempMax ?? 0)"
        
    }
}
