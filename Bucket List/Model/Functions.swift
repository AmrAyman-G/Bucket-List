//
//  Functions.swift
//  Bucket List
//
//  Created by amr on 02/06/2022.
//

import Foundation

struct Functions{
    
    func getHourForData(_ date:Date?) -> String{
        guard let inputDate = date else{

            return "error"
        }
        let formatter = DateFormatter()
        formatter.dateFormat = "h:mm a"
        return formatter.string(from: inputDate)
    }
}
