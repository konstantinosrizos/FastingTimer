//
//  ProgressRingView.swift
//  FastingTimer
//
//  Created by Konstantinos Rizos on 27/8/22.
//

import SwiftUI

struct ProgressRingView: View {
	@EnvironmentObject var fastingManager: FastingManager
	
	let timer = Timer
		.publish(every: 1, on: .main, in: .common)
		.autoconnect()
	
    var body: some View {
		ZStack {
			// MARK: Placeholder Ring
			Circle()
				.stroke(lineWidth: 20)
				.foregroundColor(.gray)
				.opacity(0.1)
			
			// MARK: Colored Ring
			Circle()
				.trim(from: 0.0, to: min(fastingManager.progress, 1.0))
				.stroke(
					AngularGradient(
						gradient: Gradient(
							colors: [
								Color(#colorLiteral(red: 0.2616114616, green: 0.3207069039, blue: 1, alpha: 1)),
								Color(#colorLiteral(red: 1, green: 0.2492741346, blue: 1, alpha: 1)),
								Color(#colorLiteral(red: 0.9098039269, green: 0.4784313738, blue: 0.6431372762, alpha: 1)),
								Color(#colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1)),
								Color(#colorLiteral(red: 0.2616114616, green: 0.3207069039, blue: 1, alpha: 1))
							]
						),
						center: .center
					),
					style: StrokeStyle(
						lineWidth: 15.0,
						lineCap: .round,
						lineJoin: .round
					)
				)
				.rotationEffect(Angle(degrees: 270))
				.animation(.easeInOut(duration: 1.0), value: fastingManager.progress)
			
			VStack(spacing: 30) {
				if fastingManager.fastingState == .notStarted {
					// MARK: Upcoming fast
					VStack(spacing: 5) {
						Text("Upcoming fast")
							.opacity(0.7)
						
						Text("\(fastingManager.fastingPlan.fastingPeriod.formatted()) Seconds")
							.font(.title)
							.fontWeight(.bold)
					}
				} else {
					// MARK: Elapsed time
					VStack(spacing: 5) {
						Text("Elapsed time (\(fastingManager.progress.formatted(.percent)))")
							.opacity(0.7)
						
						Text(fastingManager.startTime, style: .timer)
							.font(.title)
							.fontWeight(.bold)
					}
					.padding(.top)
					
					// MARK: Remaining time
					VStack(spacing: 5) {
						if !fastingManager.elapsed {
							Text("Remaining time (\((1 - fastingManager.progress).formatted(.percent)))")
								.opacity(0.7)
						} else {
							Text("Extra time")
								.opacity(0.7)
						}
						
						Text(fastingManager.endTime, style: .timer)
							.font(.title2)
							.fontWeight(.bold)
					}
				}
			}
		}
		.frame(width: 250, height: 250)
		.padding()
		.onReceive(timer) { _ in
			fastingManager.track()
		}
    }
}

struct ProgressRingView_Previews: PreviewProvider {
    static var previews: some View {
        ProgressRingView()
			.environmentObject(FastingManager())
    }
}
