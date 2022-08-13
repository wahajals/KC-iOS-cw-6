//
//  ContentView.swift
//  cw5
//
//  Created by ... on 23/06/2022.
//

import SwiftUI

struct ContentView: View {
    @State var counter: [Int] = [0, 0, 0]
    var body: some View {
        ZStack {
            Image("Praying")
                .resizable()
                .ignoresSafeArea()
                .blur(radius:6)
            Color.black
                .ignoresSafeArea()
                .opacity(0.4)
        VStack{
            Text("المسبحة")
                .font(.largeTitle)
                .bold()
                .foregroundColor(.primary)
                .padding(.vertical)
                .background(.secondary)
            
            AthkarView(myCounter: $counter[0], title: "استغفرالله")
            AthkarView(myCounter: $counter[1],title: "الحمدلله")
            AthkarView(myCounter: $counter[2],title:"سبحان الله وبحمده")
     
        }
        }
    }
}


// يجب عمل extract

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .previewInterfaceOrientation(.portrait)
    }
}

struct AthkarView: View {
    @Binding var myCounter: Int
    @State var title: String
    var body: some View {
        HStack{
            Text(title).font(.title)
                .foregroundColor(.white)
                .bold()
            Spacer()
            Text("\(myCounter)")
                .font(.largeTitle)
                .frame(width: 100, height: 100, alignment: .center)
                .foregroundColor(.white)
                .background(Color.secondary)
                .clipShape(Circle())
                .padding()
                .onTapGesture {
                    myCounter = myCounter + 1
                }
        }.padding()
    }
}
