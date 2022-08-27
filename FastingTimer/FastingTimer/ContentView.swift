//
//  ContentView.swift
//  FastingTimer
//
//  Created by Konstantinos Rizos on 27/8/22.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
		ZStack {
			// MARK: Background
			
			Color(#colorLiteral(red: 0.03370004892, green: 0, blue: 0.07292986661, alpha: 1))
				.ignoresSafeArea()
			
			content
		}
    }
	
	var content: some View {
		ZStack {
			VStack(spacing: 40) {
				// MARK: Title
				Text("Let's get started!")
					.font(.headline)
					.foregroundColor(Color(#colorLiteral(red: 0.2616114616, green: 0.3207069039, blue: 1, alpha: 1)))
				
				// MARK: Fasting Plan
				Text("16:8")
					.fontWeight(.semibold)
					.padding(.horizontal, 24)
					.padding(.vertical, 8)
					.background(.thinMaterial)
					.cornerRadius(20)
				
				Spacer()
			}
			.padding()
				
			VStack(spacing: 40) {
				// MARK: Progress Ring
				ProgressRingView()
				
				HStack(spacing: 60) {
					// MARK: Start Timer
					VStack(spacing: 5) {
						Text("Start")
							.opacity(0.7)
						
						Text(Date(), format: .dateTime.weekday().hour().minute().second())
							.fontWeight(.bold)
					}
					
					// MARK: End Timer
					VStack(spacing: 5) {
						Text("End")
							.opacity(0.7)
						
						Text(Date().addingTimeInterval(16), format: .dateTime.weekday().hour().minute().second())
							.fontWeight(.bold)
					}
				}
				
				// MARK: Button
				Button {
					
				} label: {
					Text("Start fasting")
						.font(.title3)
						.fontWeight(.semibold)
						.padding(.horizontal, 24)
						.padding(.vertical, 8)
						.background(.thinMaterial)
						.cornerRadius(20)
				}

				
			}
			.padding()
		}
		.foregroundColor(.white)
	}
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
