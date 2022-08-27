//
//  ContentView.swift
//  FastingTimer
//
//  Created by Konstantinos Rizos on 27/8/22.
//

import SwiftUI

struct ContentView: View {
	@StateObject var fastingManager = FastingManager()
	
	var title: String {
		switch fastingManager.fastingState {
		case .notStarted:
			return "Let's get started!"
		case .fasting:
			return "You are now fasting"
		case .feeding:
			return "You are now feeding"
		}
	}
	
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
				Text(title)
					.font(.headline)
					.foregroundColor(Color(#colorLiteral(red: 0.2616114616, green: 0.3207069039, blue: 1, alpha: 1)))
				
				// MARK: Fasting Plan
				Button {
					fastingManager.toggleFastingPlan()
				} label: {
					Text(fastingManager.fastingPlan.rawValue)
						.font(.title3)
						.fontWeight(.semibold)
						.padding(.horizontal, 24)
						.padding(.vertical, 8)
						.background(.thinMaterial)
						.cornerRadius(20)
				}
				
				Spacer()
			}
			.padding()
				
			VStack(spacing: 40) {
				// MARK: Progress Ring
				ProgressRingView()
					.environmentObject(fastingManager)
				
				HStack(spacing: 60) {
					// MARK: Start Timer
					VStack(spacing: 5) {
						Text(fastingManager.fastingState == .notStarted ? "Start" : "Started")
							.opacity(0.7)
						
						Text(fastingManager.startTime, format: .dateTime.weekday().hour().minute().second())
							.fontWeight(.bold)
					}
					
					// MARK: End Timer
					VStack(spacing: 5) {
						Text(fastingManager.fastingState == .notStarted ? "End" : "Ends")
							.opacity(0.7)
						
						Text(fastingManager.endTime, format: .dateTime.weekday().hour().minute().second())
							.fontWeight(.bold)
					}
				}
				
				// MARK: Button
				Button {
					fastingManager.toggleFastingState()
				} label: {
					Text(fastingManager.fastingState == .fasting ? "End fast" : "Start fasting")
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
