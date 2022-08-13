//
//  ContentView.swift
//  bmi
//
//  Created by WSS on 13/08/2022.
//

import SwiftUI
struct RadioButton: View {
    let id: String
    let label: String
    let size: CGFloat
    let color: Color
    let textSize: CGFloat
    let isMarked: Bool
    let callback: (String) -> ()
    
    init(
        id: String,
        label: String,
        size: CGFloat = 20,
        color: Color = Color.black,
        textSize: CGFloat = 14,
        isMarked: Bool = false,
        callback: @escaping (String) -> ()
    ){
        self.id = id
        self.label = label
        self.size = size
        self.color = color
        self.textSize = textSize
        self.isMarked = isMarked
        self.callback = callback
        
    }
    var body: some View {
        Button {
            self.callback(self.id)
        } label: {
            HStack (alignment:.center, spacing: 10){
                Image(systemName: self.isMarked ? "largecircle.fill.circle" : "circle")
                    .renderingMode(.original)
                    .resizable()
                    .aspectRatio(contentMode:.fit)
                    .frame(width:self.size, height: self.size)
                
                Text(label)
                    .font(Font.system(size: textSize))
                
                Spacer()
            }
            .foregroundColor(self.color)
        }.foregroundColor(Color.white)
        
    }
}



// Mark:- Group of Radio Buttons
enum Gender: String {
    case male = "Male"
    case female = "Female"
}

struct RadioButtonsGroup: View {
    let callback: (String) -> ()
    
    @State var selectedId: String = ""
    
    var body: some View {
        VStack {
            radioMaleMajority
            radioFemleMajority
        }
    }
    
    var radioMaleMajority: some View {
        RadioButton(id:Gender.male.rawValue,
                    label: Gender.male.rawValue,
                    isMarked: selectedId == Gender.male.rawValue ? true : false,
                    callback: radioGroupCallback)
    }
    
    var radioFemleMajority: some View {
        RadioButton(id:Gender.female.rawValue,
                    label: Gender.female.rawValue,
                    isMarked: selectedId == Gender.female.rawValue ? true : false,
                    callback: radioGroupCallback)
    }
    
    func radioGroupCallback(id: String){
        selectedId = id
        callback(id)
    }
}

struct ContentView: View {
    @State var weight = ""
    @State var height = ""
    @State var result: Double = 0.0
    @State var health = ""
    var body: some View {
        ZStack {
            Color.gray
                .ignoresSafeArea()
                .opacity(0.1)
            
            VStack {
                Text("BMI Calculator")
                    .font(.largeTitle)
                    .font(.title2)
                    .bold()
                Image("Index")
                    .resizable()
                    .scaledToFit()
                    .background(.gray)
                    .opacity(0.9)
                Text("Enter Your Info")
                    .font(.system(size:25))
                    .bold()
                HStack {
                    Text("Gender")
                        .font(.headline)
                    RadioButtonsGroup { selected in
                        print("selected Gender id: \(selected)")
                    }
                }.padding()
                HStack{
                    Text("Weight: ")
                        .font(.system(size:20))
                        .bold()
                    TextField("  Enter", text: $weight)
                        .padding(.vertical)
                        
                        .background(.white)
                }.padding([.top, .leading]).background(.secondary)
                HStack{
                    Text("Height: ")
                        .bold()
                        .font(.system(size:20))
                    TextField("  Enter", text: $height)
                        .padding(.vertical)
                        .background(.white)
                }.padding([.top, .leading]).background(.secondary)
                
                Button {
                    result = bmiCalc(w: Double(weight) ?? 0.0, h: Double(height) ?? 0.0)
                    if result <= 20 {
                        health = "Underweight"
                    } else if result <= 25 {
                        health = "Normal"
                    } else if result >= 25 && result <= 30 {
                        health = "Overweight"
                    } else {
                        health = "Obese"
                    }
                } label: {
                    Text("Calculate")
                        .bold()
                        .padding(.all)
                        .foregroundColor(.black)
                        .background(.red)
                }.padding()
                HStack {
                    Text("Your BMI =")
                        .bold()
                        .padding(.all)
                        .background(.teal)
                    Text("\(result)")
                        .padding(.all)
                        .background(.white)
                }.offset(x:-70, y:0)
                HStack{
                    Text("Category =")
                        .bold()
                        .padding(.all)
                        .background(.teal)
                    Text("\(health)")
                        .padding(.all)
                        .background(.white)
                }.offset(x:-80, y:0)
                Spacer()
                
            }
        }
    }
    func bmiCalc(w: Double, h: Double) -> Double {
        return w / (h * h)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
