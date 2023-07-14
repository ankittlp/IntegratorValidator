//
//  StringExtension.swift
//  ANValidator
//
//  Created by Ankit on 28/05/20.
//  Copyright © 2020 Ankit. All rights reserved.
//

import Foundation

extension String {
    var trimmed: String {
        return self.trimmingCharacters(in: .whitespacesAndNewlines) 
    }
}
