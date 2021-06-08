//
//  Onboarding.swift
//  AtomicHabit
//
//  Created by Hung-Chun Tsai on 2021-04-04.
//  Copyright © 2021 CodeMonk. All rights reserved.
//

import SwiftUI

struct OnboardingPageContent: Identifiable {
    var id = UUID()
    var title: String
    var headline: String
    var image: String
    var gradientColors: [Color]
}

let onboardingData: [OnboardingPageContent] = [
    OnboardingPageContent(
        title: "Change From Now",
        headline: "Every study tells us that around 80% of New Year’s resolutions will get abandoned within a month.",
        image: "onBoarding-1",
        gradientColors: [Color("ColorBlueBerryLight"), Color("ColorBlueBerryDark")]),
    OnboardingPageContent(
        title: "Forming Habit Effortless",
        headline: "This app offer simple and easy way to track your habit and help you develop the good habit.",
        image: "onBoarding-2",
        gradientColors: [Color("ColorBlueBerryLight"), Color("ColorBlueBerryDark")]),
    OnboardingPageContent(
        title: "Why You Wait",
        headline: "Here has large community who want to change their live! Let's motivate each other.",
        image: "onBoarding-3",
        gradientColors: [Color("ColorBlueBerryLight"), Color("ColorBlueBerryDark")])
        ]

struct Onboarding: View {
    // MARK: - PROPERTIES
    @Binding var isPresenting: Bool
    
    // MARK: - BODY
    var body: some View {
        TabView{
            ForEach(onboardingData[0...2]) { item in
                OnboardingCardView(isShowing: $isPresenting, onBoardingContent: item)
            }
        } //: TAB
        .tabViewStyle(PageTabViewStyle())
        .padding(.vertical,20)
    }
    
}

struct StartButtonView: View {
    
    //MARK: - PROPERTIES

    @Binding var isShowing: Bool
    
    //MARK: - BODY
    
    var body: some View {
        
        Button(action: {
            isShowing = false
            print("Exit the onboarding")
        }) {
            HStack(spacing: 8){
                Text("Start")
                Image(systemName: "arrow.right.circle")
                    .imageScale(.large)
            }
            .padding(.horizontal,16)
            .padding(.vertical,10)
            .background(
                Capsule().strokeBorder(Color.white, lineWidth: 1.25)
            )
            
        } //: BUTTON
        .accentColor(Color.white)
        
    }
}

struct OnboardingCardView: View {
    
    //MARK: - PROPERTIES
    
    @State var isAnimating: Bool = false
    @Binding var isShowing: Bool
    
    var onBoardingContent: OnboardingPageContent

    //MARK: - BODY
    
    var body: some View {
        ZStack {
            VStack(spacing: 20){
                
                Image(onBoardingContent.image)
                    .resizable()
                    .scaledToFit()
                    .shadow(color: Color(red: 0, green: 0, blue: 0, opacity: 0.15), radius: 8, x: 6, y: 8)
                    .frame(width: 300, height: 300, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    .scaleEffect(isAnimating ? 1.0 :0.8)
                // FRUIT: TITLE
                Text(onBoardingContent.title)
                    .foregroundColor(Color.white)
                    .font(.largeTitle)
                    .fontWeight(.heavy)
                    .shadow(color: Color(red: 0, green: 0, blue: 0, opacity: 0.3), radius: 2, x: 2, y: 2)
                // FRUIT:HEADLINE
                Text(onBoardingContent.headline)
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 16)
                    .frame(maxWidth: 480)
                // BUTTON: START
                StartButtonView(isShowing: $isShowing)
                
            }
            .onAppear{
                withAnimation(.interpolatingSpring(stiffness: 150, damping: 10)) {
                    isAnimating = true
                }
            }
            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, idealHeight: 0, maxHeight: .infinity, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
            .background(LinearGradient(gradient: Gradient(colors: onBoardingContent.gradientColors), startPoint: .top, endPoint: .bottom))
            .cornerRadius(20)
            .padding(.horizontal,20)
            .ignoresSafeArea()
            
    
        }//: VSTACK
        
    }
}


struct Onboarding_Previews: PreviewProvider {
    static var previews: some View {
        Onboarding(isPresenting: .constant(true))
    }
}
