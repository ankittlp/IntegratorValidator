//
//  File.swift
//  
//
//  Created by Ankit Nigam on 29/06/23.
//

import Foundation
import UIKit
//import MyAppFontKit
//import MyLibrary
//import ANAnimation



public struct MyAppColor {
    public static let myAppRed = UIColor.red
    public static let myAppBlue = UIColor.blue
    
    public init() {}
    public func moodColor(_ isGood: Bool) -> UIColor {
        //print("Font \(MyAppFont.boldSmall)")
//        ANAnimation.animateMyView(duration: 1.0) {
//            print(print("Font \(MyAppFont.boldSmall) - \(MyLibrary().text)"))
//        }
        return isGood ? Self.myAppBlue : Self.myAppRed
        
//        if isGood {
//            return Self.myAppBlue
//        }else {
//            return Self.myAppRed
//        }
        
    }
}
