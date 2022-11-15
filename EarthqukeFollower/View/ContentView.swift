//
//  ContentView.swift
//  EarthqukeFollower
//
//  Created by Cengizhan Kervancı on 13.11.2022.
//

import SwiftUI
import CoreLocation

struct ContentView: View
{
    @ObservedObject var earthquakeData = EarthquakeViewModel()
    
    //Search
    @State private var searchText = ""
    var filter : [EarthquakeModel]
    {
        if searchText == "" {return earthquakeData.earthquakeList}
        return
        earthquakeData.earthquakeList.filter{$0.region?.lowercased()
            .contains(searchText.lowercased()) ?? false}
    }
    
    var body: some View
    {
        NavigationView
        {
            List {
                    HStack
                    {
                        Text("Location")
                            .foregroundColor(.secondary)
                        Spacer()
                        Text("Intensity")
                            .foregroundColor(.secondary)
                    }
                    ForEach(filter,id: \.self) { datas in
                        NavigationLink {
                            TopCircleWithMap(model: datas, coordinate: CLLocationCoordinate2D.init(latitude: Double(datas.latitude!)!, longitude: Double(datas.longitude!)!))
                        } label: {
                            HStack{
                                Text(datas.region ?? "Null")
                                    .font(.title3)
                                Spacer()
                                Text(datas.intensity ?? "Null")
                                    .font(.largeTitle)
                                    .foregroundColor(earthquakeData.changeColorText(value: Float(datas.intensity ?? "0.0") ?? 0))
                            }
                        }
                    }
                }
            .navigationTitle("Last 500 Earthquake")
            .searchable(text: $searchText)
            .scrollDismissesKeyboard(.immediately)
            .animation(.easeOut(duration: 0.3), value: filter.count)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
