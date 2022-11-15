//
//  ListView.swift
//  EarthqukeFollower
//
//  Created by Cengizhan Kervancı on 13.11.2022.
//

import SwiftUI

struct ListView: View {
    
    let model : EarthquakeModel
    let viewModel : EarthquakeViewModel
    
    var body: some View
    {
        VStack
        {
            Text(model.region?.capitalized ?? "Null")
                .font(.title2)
        }
    }
}

struct ListView_Previews: PreviewProvider {
    static var previews: some View {
        ListView(model: .init(id: 1, date: "", time: "", latitude: "", longitude: "", depth: "", intensity: "", region: "", city: ""), viewModel: EarthquakeViewModel.init())
    }
}
