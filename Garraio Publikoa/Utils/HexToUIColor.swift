//
//  HexToUIColor.swift
//  Garraio Publikoa
//
//  Created by Aitor Zubizarreta on 01/09/2020.
//  Copyright © 2020 Aitor Zubizarreta. All rights reserved.
//

import UIKit

///
/// Converts a Hex color code string into an UIColor.
/// - Parameter hex: A 3 or 6 char Hex color code, with or without # char. Ex: #333, 333, #AA774D, AA774D.
///
public func convertHexToUIColor(hex: String) -> UIColor? {
    
    // Remove all spaces and the # char (if there is any).
    var cleanHex: String = hex
    cleanHex = cleanHex.replacingOccurrences(of: " ", with: "")
    cleanHex = cleanHex.replacingOccurrences(of: "#", with: "")
    
    // Check if Hex color code is correct.
    // Valid chars are : 0-9, A, B, C, D, E, F, and length should be 3 or 6 chars.
    let range = NSRange(location: 0, length: cleanHex.utf16.count)
    let pattern = "^[0-9a-fA-F]{3}$|^[0-9a-fA-F]{6}$"
    let regex = try! NSRegularExpression(pattern: pattern, options: [])
    if regex.numberOfMatches(in: cleanHex, options: [], range: range) == 0 {
        print("❌ Error! Bad Hex code: \(cleanHex)")
        return nil
    }
    
    // If the string has 3 chars convert it to 6.
    // Ex: 333 => 333333, 123 => 112233
    if cleanHex.count == 3 {
        let first: String = String(cleanHex.dropLast(2))
        let second: String = String(cleanHex.dropFirst().dropLast(1))
        let third: String = String(cleanHex.dropFirst().dropFirst())
        
        cleanHex = ("\(first)\(first)\(second)\(second)\(third)\(third)")
    }
    
    // Converts string into an H  ex number.
    let scanner = Scanner(string: cleanHex)
    var hexNumber: UInt64 = 0
    
    // Gets the value of each color and creates the UIColor.
    if scanner.scanHexInt64(&hexNumber) {
        let r = CGFloat((hexNumber & 0xff0000) >> 16) / 255
        let g = CGFloat((hexNumber & 0x00ff00) >> 8) / 255
        let b = CGFloat(hexNumber & 0x0000ff) / 255
        
        return UIColor(red: r, green: g, blue: b, alpha: 1.0)
    } else {
        print("❌ Scanner Error! Can't convert string to UInt64.")
        return nil
    }
}
