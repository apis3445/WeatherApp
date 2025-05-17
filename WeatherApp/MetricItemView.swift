//
//  MetricItemView.swift
//  WeatherApp
//
//  Created by Abigail Armijo Hernández on 17/05/25.
//

import SwiftUI

struct MetricItemView: View {
    
    
    var imageName: String
    var metrictName: String
    var value: String
    
    @State private var isAnimate = false
    
    var body: some View {
        HStack(alignment: .center) {
            Image(imageName)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 70, height: 70)
                .background(Color("background"))
                .cornerRadius(20)
                .shadow(radius: 15)
                .padding(.leading, 20)
                .padding(.bottom, 0)
            
            Text(metrictName)
                .font(.system(size: 24))
                .shadow(color: .black, radius: 0.5, x:0, y:1)
                .frame(maxWidth: .infinity, alignment: .center)
                
            Text(value)
                .font(.system(size: 24))
                .fontWeight(.bold)
                .shadow(color: .black, radius: 0.5, x:0, y:1)
                .rotation3DEffect(Angle(degrees: isAnimate ? 360 : 0), axis: (x: 10, y:0.0, z: 0.0))
                .animation(.easeInOut(duration: 0.1), value: isAnimate)
                .id(value)
            
        }.padding(20)
        .onChange(of: value) {
                        isAnimate = true
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                            isAnimate = false
                        }
                    }
    }
}

struct DishView_Previews: PreviewProvider {
    static var previews: some View {
        MetricItemView(imageName: "temp",
                       metrictName: "Temperature",
                       value: "64 °C")
    }
}
