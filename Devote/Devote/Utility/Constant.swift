//
//  Constant.swift
//  Devote
//
//  Created by Ussama Irfan on 01/07/2024.
//

import SwiftUI

// MARK: - FORMATTER
let itemFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .medium
    return formatter
}()
 
// MARK: - UI
var backgroundGradient: LinearGradient {
    return LinearGradient(colors: [.pink, .blue], startPoint: .topLeading, endPoint: .bottomTrailing)
}


// MARK: - UX
let hapticFeedBack = UINotificationFeedbackGenerator()

