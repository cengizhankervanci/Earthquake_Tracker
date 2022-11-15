//
//  TopCircleWithMap.swift
//  EarthqukeFollower
//
//  Created by Cengizhan Kervancı on 13.11.2022.
//

import SwiftUI
import MapKit

struct TopCircleWithMap: View
{
    @ObservedObject var viewModel = EarthquakeViewModel()
    @State var model : EarthquakeModel
    
    //MAP
    struct Place : Identifiable{
        let id = UUID()
        let name : String
        let coordinate : CLLocationCoordinate2D
    }
    
    var coordinate: CLLocationCoordinate2D
    
    @State private var region = MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: 37.334_900,
                                           longitude: -122.009_020),
            latitudinalMeters: 750,
            longitudinalMeters: 750
        )
    
    @State var annotations : [Place] = []
    //END MAP
    
    var body: some View
    {
        VStack(alignment: .leading)
        {
            Map(coordinateRegion: $region,annotationItems: annotations){_ in
                MapMarker(coordinate: coordinate)
            }
            .ignoresSafeArea()
            .onAppear{
                setRegion(coordinate)
                annotations=[Place(name: "Test", coordinate: CLLocationCoordinate2D(latitude: coordinate.latitude, longitude: coordinate.longitude))]
            }
            .frame(width:UIScreen.main.bounds.width,
                   height:UIScreen.main.bounds.height/2)
            .shadow(color: .black, radius: 2)
            
            Group
            {
                HStack
                {
                    Circle()
                        .fill(Color.red.opacity(0.65))
                        .shadow(color: .red, radius: 10)
                        .frame(width: 100)
                        .offset(y:15)
                    
                    Text(model.intensity ?? "0.0")
                        .foregroundColor(.white)
                        .font(.title)
                        .fontWeight(.bold)
                        .offset(x: -78,y:15)
                        
                    Text(model.region ?? "NULL")
                        .fontWeight(.bold)
                        .offset(x:-40)
                }
                Divider()
                    .offset(y:30)
                    
                VStack
                {
                    if let value = Float(model.intensity ?? "0")
                    {
                        if(value > 2.9)
                        {
                            Text("Noticeable shaking of indoor objects")
                                .foregroundColor(.secondary)
                                .lineLimit(-1)
                                .offset(x:60,y:-50)
                        }
                        else{
                            Text("A low-intensity earthquake occurred.")
                                .foregroundColor(.secondary)
                                .lineLimit(-1)
                                .offset(x:60,y:-50)
                        }
                        
                    }
                    
                    
                    ZStack
                    {
                        Rectangle()
                            .shadow(color: .black, radius: 9)
                            .foregroundColor(.secondary.opacity(0.1))
                            .cornerRadius(10)
                            .padding(.horizontal,-30)
                            .frame(height: 250)
                            .padding(.bottom,-200)
                        
                        HStack {
                            Text("Date: \(model.date ?? "00.00.202X")")
                            Spacer()
                            Text("Time: \(model.time ?? "00:00:00")")
                            Spacer()
                        }.padding()
                            .offset(y:50)
                        
                        VStack {
                            HStack {
                                Text("Depth: \(model.depth ?? "0") + KM")
                                Spacer()
                                Text("City: \(model.city ?? "NULL")")
                                Spacer()
                            }.padding()
                        }
                        
                       
                    }
                    .offset(y:-30)
                    .padding()
                }
                
            }.offset(y:10)
            
            
        }
        
    }
    
    private func setRegion(_ coordinate: CLLocationCoordinate2D)
    {
        region = MKCoordinateRegion(center: coordinate,span: MKCoordinateSpan(latitudeDelta: 0.2, longitudeDelta: 0.2))
    }
}


struct TopCircleWithMap_Previews: PreviewProvider {
    static var previews: some View {
        TopCircleWithMap(model: .init(id: "", date: "", time: "", latitude: "", longitude: "", depth: "", intensity: "", region: "", city: ""), coordinate: CLLocationCoordinate2D(latitude: 37.3334_900, longitude: -122.009_020))
    }
}
