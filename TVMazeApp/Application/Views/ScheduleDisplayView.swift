//
//  ScheduleDisplayView.swift
//  TVMazeApp
//
//  Created by Joel Alcantara on 16/3/25.
//

import SwiftUI

struct ScheduleDisplayView: View {
    var schedule: Schedule = .mock
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Schedule")
                .font(.title2)
                .fontWeight(.semibold)
            ScrollView(.horizontal) {
                HStack {
                    ForEach(schedule.days, id: \.self) { day in
                        Text(day)
                            .frame(width: 90)
                    }
                }
                .padding(.leading, 50)
                HStack {
                    VStack(alignment: .leading) {
                        RoundedRectangle(cornerRadius: 0)
                            .fill(Color.gray)
                            .frame(height: 1)
                        HStack {
                            Text("Time")
                            ForEach(schedule.days, id: \.self) { _ in
                                Text(schedule.time)
                                    .frame(width: 90)
                            }
                        }
                    }
                }
            }
        }
        .padding(.leading, 8)
        .padding(.trailing, 8)
    }
}

#Preview {
    ScheduleDisplayView()
}
