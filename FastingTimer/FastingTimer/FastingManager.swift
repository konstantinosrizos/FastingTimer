//
//  FastingManager.swift
//  FastingTimer
//
//  Created by Konstantinos Rizos on 27/8/22.
//

import Foundation

enum FastingState {
	case notStarted
	case fasting
	case feeding
}

enum FastingPlan: String {
	case begginer = "12:12"
	case intermediate = "16:8"
	case advanced = "20:4"
	
	var fastingPeriod: Double {
		switch self {
		case .begginer:
			return 12
		case .intermediate:
			return 16
		case .advanced:
			return 20
		}
	}
}

class FastingManager: ObservableObject {
	@Published private(set) var fastingState: FastingState = .notStarted
	@Published private(set) var fastingPlan: FastingPlan = .intermediate
	@Published private(set) var startTime: Date {
		didSet {
			if fastingState == .fasting {
				endTime = startTime.addingTimeInterval(fastingTime)
			} else {
				endTime = startTime.addingTimeInterval(feedingTime)
			}
		}
	}
	@Published private(set) var endTime: Date {
		didSet {
			print("endTime:", endTime.formatted(.dateTime.month().day().hour().minute().second()))
		}
	}
	
	@Published private(set) var elapsed: Bool = false
	@Published private(set) var elapsedTime: Double = 0.0
	@Published private(set) var progress: Double = 0.0
	
	var fastingTime: Double {
		return fastingPlan.fastingPeriod
	}
	
	var feedingTime: Double {
		return 24 - fastingPlan.fastingPeriod
	}
	
	init() {
		let calendar = Calendar.current
		
		let components = DateComponents(hour: 20)
		let scheduleTime = calendar.nextDate(after: .now, matching: components, matchingPolicy: .nextTime)!
				
		startTime = scheduleTime
		endTime = scheduleTime.addingTimeInterval(FastingPlan.intermediate.fastingPeriod)
	}
	
	func toggleFastingState() {
		fastingState = fastingState == .fasting ? .feeding : .fasting
		startTime = Date()
		elapsedTime = 0.0
	}
	
	func toggleFastingPlan(fastingPlanSelected: FastingPlan) {
		if fastingPlanSelected == .begginer {
			fastingPlan = .begginer
		} else if fastingPlanSelected == .intermediate {
			fastingPlan = .intermediate
		} else {
			fastingPlan = .advanced
		}
		startTime = Date()
		elapsedTime = 0.0
	}
	
	func track() {
		guard fastingState != .notStarted else { return }
		
		if endTime >= Date() {
			elapsed = false
		} else {
			elapsed = true
		}
		
		elapsedTime += 1
		
		let totalTime = fastingState == .fasting ? fastingTime : feedingTime
		progress = (elapsedTime / totalTime * 100).rounded() / 100
	}
}
