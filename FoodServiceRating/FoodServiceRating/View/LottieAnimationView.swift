//
//  LottieAnimationView.swift
//  FoodServiceRating
//
//  Created by Lin Tun on 11/25/21.
//

import SwiftUI
import Lottie

struct LottieAnimationView: UIViewRepresentable {
    
    var jsonFile: String
    @Binding var progress:CGFloat
    
    
    func makeUIView(context: Context) -> UIView {
        
        let rootView = UIView()
        rootView.backgroundColor = .clear
        
        addAnimationView(rootView: rootView)
        
        return rootView
    }
    
    func updateUIView(_ uiView: UIView, context: Context) {
    //Updating Progess
        uiView.subviews.forEach{ view in
            if view.tag == 1009{
                //remove
                view.removeFromSuperview()
            }
            
        }
        
        addAnimationView(rootView: uiView)
    }
    
    func addAnimationView(rootView: UIView){
        
        let emojiview = AnimationView(name: jsonFile, bundle: .main)
        
        //emoji movement
        emojiview.currentProgress = 0.49 + (progress/2)
        
        emojiview.backgroundColor = .clear
        emojiview.tag = 1009
        
        //Applying Auto Layout Constraints to place Lottie View in Center
        emojiview.translatesAutoresizingMaskIntoConstraints = false
        let constraints = [
            emojiview.widthAnchor.constraint(equalTo: rootView.heightAnchor),
            emojiview.heightAnchor.constraint(equalTo: rootView.heightAnchor),
        ]
        
        rootView.addSubview(emojiview)
        rootView.addConstraints(constraints)
    }
}

