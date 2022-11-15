//
//  EarthquakeViewModel.swift
//  EarthqukeFollower
//
//  Created by Cengizhan Kervancı on 13.11.2022.
//

import Foundation
import SwiftUI

class EarthquakeViewModel : ObservableObject
{
    @Published var earthquakeList = [EarthquakeModel]()
    
    init()
    {
        downloadDatas()
    }
    
    func downloadDatas()
    {
        let url = URL(string: "https://deprem.piyanos.com/api")!
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            do{
                if let getData = data{
                    let decodedData = try JSONDecoder().decode([EarthquakeModel].self, from: getData)
                    
                    DispatchQueue.main.async
                    {
                        self.earthquakeList = decodedData
                    }
                }
                else{
                    print("Data Not Found")
                }
            }
            catch{
                print(error.localizedDescription)
            }
        }.resume()
    }
    
    func changeColorText(value type:Float) -> Color{
        switch type{
        case 0...2:
            return .green
        case 3...4:
            return .orange
        case 4...8:
            return .red
        default:
            return .black
        }
    }

}
