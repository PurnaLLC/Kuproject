//
//  CreateTodo.swift
//  KUComputerScienceCompetition
//
//  Created by Maxwell Meyer on 9/5/23.
//

import SwiftUI

struct CreateTodo: View {
    @State var checkin: CheckIn
    var save: (CheckIn)->()
    @Environment(\.dismiss) var dismiss
    
    @State private var streak: Int = 0
    @State private var lastCheckedDate: Date?
    
    var body: some View {
        
        VStack{
            HStack {
        
                VStack{
                    
                    TextField("Todo Name", text: $checkin.name)
                        .textFieldStyle(.roundedBorder)
            
                    
                    Text("Started Date: \(checkin.formattedDate())")
                    
                    
                    VStack {
                        DatePicker("Finished By", selection: $checkin.tododate, in: Date()..., displayedComponents: .date)
                        
                    }
                    VStack {
                        DatePicker("", selection: $checkin.tododate, in: Date()..., displayedComponents: .hourAndMinute)
                        
                    }
                    
                }
    
                
            }
            
            
            Button {
                save(checkin)
                dismiss()
                performCheckIn()
            } label: {
                Text("Save")
            }
            
            VStack(alignment: .center){
                
                TextField("Description of todo", text: $checkin.description, axis: .vertical)
                           .lineLimit(2)
                           .textFieldStyle(.roundedBorder)
                           .padding()

            }
            
        }
        .padding()
    }
    
    
    private func performCheckIn() {
        let currentDate = Date()
        
        // Check if there's a last checked date
        if let lastDate = lastCheckedDate {
            let calendar = Calendar.current
            
            // Compare date components, excluding time
            if calendar.isDateInToday(lastDate) {
                // Already checked in today
                return
            }
            
            if calendar.isDateInYesterday(lastDate) {
                // Checked in yesterday, increment the streak
                streak += 1
            } else {
                // Missed a day, reset streak
                streak = 0
            }
        } else {
            // First time check-in
            streak = 1
        }
        // Save the current date
        lastCheckedDate = currentDate
        saveStreak()
    }
    
    
    private func saveStreak() {
        UserDefaults.standard.setValue(streak, forKey: "streak")
        UserDefaults.standard.setValue(lastCheckedDate, forKey: "lastCheckedDate")
    }
    private func loadStreak() {
        streak = UserDefaults.standard.integer(forKey: "streak")
        lastCheckedDate = UserDefaults.standard.object(forKey: "lastCheckedDate") as? Date
    }
    
    
    
    
}
