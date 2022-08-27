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
		VStack {
			// MARK: Progress Ring
			
			ProgressRingView()
		}
	}
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
