//
//  DataModel.swift
//  EarthqukeFollower
//
//  Created by Cengizhan Kervancı on 13.11.2022.
//

import Foundation
import CoreLocation

struct EarthquakeModel: Codable,Identifiable,Hashable {
    let id : String?
    let date : String?
    let time : String?
    let latitude : String?
    let longitude : String?
    let depth : String?
    let intensity : String?
    let region : String?
    let city : String?

}
