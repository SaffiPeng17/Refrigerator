//
//  ErrorHandle.swift
//  Refrigerator
//
//  Created by Saffi on 2018/6/24.
//  Copyright © 2018 Saffi. All rights reserved.
//

import Foundation


enum VerifyError: Int {
    case veNameEmpty = 101
    case veQuantityZero
    case veValidDateError

    var code: String { return "Error\(self.rawValue)" }
    var message: String {
        switch self {
        case .veNameEmpty:
            return "The food name cannot be empty!"
        case .veQuantityZero:
            return "The quantity cannot be zero!"
        case .veValidDateError:
            return "The valid date cannot be selected today or past days!"
        }
    }
}
