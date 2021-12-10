//
//  ContentView.swift
//  FoodServiceRating
//  get help from https://github.com/airbnb/lottie-ios
//
//  Created by Lin Tun on 11/25/21.
//  

import SwiftUI

struct ContentView: View {
    var body: some View {
       RatingView()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct RatingView: View{
    @State var offset: CGFloat = 0
    //Gesture Properties
    @GestureState var isDragging: Bool = false
    @State var currentSliderProgress: CGFloat = 0.5
    
    @State var showPopUp: Bool = false
    
    var body: some View{
        VStack(spacing: 15){
            
            Text(getAttributedString())
                .font(.system(size: 45))
                .fontWeight(.medium)
                .kerning(1.1)
                .padding(.top)
            
            GeometryReader{proxy in
                
                LottieAnimationView(jsonFile: "EmojiRating", progress: $currentSliderProgress)
                    .frame(width: 600, height: 400)
                    .scaleEffect(1.2)
            }
            
            //Slider
            ZStack{
                Rectangle()
                    .fill(.white)
                    .frame(height:1)
                
                Group{
                    RoundedRectangle(cornerRadius: 15)
                        .fill(.black)
                        .frame(width: 55, height: 55)
                    
                    Circle()
                        .fill(.white)
                        .frame(width: 11, height: 11)
                }
                .frame(maxWidth: .infinity,alignment: .center)
                .contentShape(Rectangle())
                .offset(x: offset)
                // Gesture
                .gesture(
                    DragGesture(minimumDistance: 5)
                        .updating($isDragging, body: {_, out,_ in out = true})
                        .onChanged({value in
                            
                            //to remove half width value
                            let width = UIScreen.main.bounds.width - 30
                            var slidebar = value.location.x
                            
                            //to the left slider stop
                            slidebar = (slidebar > 27 ? slidebar : 27)
                            
                            //to the right slider stop
                            slidebar = (slidebar < (width - 27) ? slidebar : (width - 27))
                            slidebar = isDragging ? slidebar : 0
                            
                            offset = slidebar - (width / 2)
                            
                            let progress = (slidebar - 27) / (width - 55)
                            currentSliderProgress = progress
                            
                        })
                
                )
            }
            .padding(.bottom,20)
            .offset(y: -10)
            
            Button{
                
                let rate = (currentSliderProgress / 0.2).rounded()
                print("The customer give the rate of",rate)
                
            } label: {
                Text("Done!")
                    .font(.title3)
                    .fontWeight(.medium)
                    .kerning(1.1)
                    .padding(.vertical,18)
                    .frame(maxWidth: .infinity)
                    .foregroundColor(.white)
                    .background(
                        Color.black,in:
                            RoundedRectangle(cornerRadius: 20)
                    )
            }
            .padding(.horizontal,15)

        }
        .padding(15)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(
            LinearGradient(colors: [
                Color(.orange),
                Color(.red),
                Color(.yellow)
            ], startPoint: .top, endPoint: .bottom)
            .ignoresSafeArea()
        )
        .overlay(
            Button(action: {
                
            }, label: {
                Image(systemName: "xmark")
                    .font(.title2)
                    .foregroundColor(.black)
            })
                .padding(.trailing)
                .padding(.top)
            ,alignment: .topTrailing
        )
    }
    
    // Attributed String
    func getAttributedString()->AttributedString{
        var str = AttributedString("Did you enjoy your Food?")
        
        if let range = str.range(of: "Food?"){
            str[range].foregroundColor = .white
        }
        return str
    }
    
}

