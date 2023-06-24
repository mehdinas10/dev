//
//  String.swift
//  Vision45
//
//  Created by Mehdi Nasiri on 12/2/20.
//  Copyright © 2020 Mehdi Nasiri. All rights reserved.
//

import Foundation

extension String{
    
    public var arToEnDigits : String {
        let arabicNumbers = ["٠": "0","١": "1","٢": "2","٣": "3","٤": "4","٥": "5","٦": "6","٧": "7","٨": "8","٩": "9"]
        var txt:String = self
        arabicNumbers.map { txt = txt.replacingOccurrences(of: $0, with: $1)}
        
        let final = txt.convertedDigitsToLocale(Locale(identifier: "EN"))
        
        return (final != nil && final.count == txt.count) ? final : txt
    }
    
    
    private static let formatter = NumberFormatter()

    func clippingCharacters(in characterSet: CharacterSet) -> String {
        components(separatedBy: characterSet).joined()
    }

    func convertedDigitsToLocale(_ locale: Locale = .current) -> String {
        let digits = Set(clippingCharacters(in: CharacterSet.decimalDigits.inverted))
        guard !digits.isEmpty else { return self }
        Self.formatter.locale = locale
        let maps: [(original: String, converted: String)] = digits.map {
            let original = String($0)
            guard let digit = Self.formatter.number(from: String($0)) else {
                assertionFailure("Can not convert to number from: \(original)")
                return (original, original)
            }
            guard let localized = Self.formatter.string(from: digit) else {
                assertionFailure("Can not convert to string from: \(digit)")
                return (original, original)
            }
            return (original, localized)
        }
        var converted = self
        for map in maps { converted = converted.replacingOccurrences(of: map.original, with: map.converted) }
        return converted
    }
    
    func substr(start:Int , end:Int)->String{
        let start = self.index(self.startIndex, offsetBy: start)
        let ends = self.index(self.endIndex, offsetBy: -(self.count-end))
        let range = start..<ends

        let mySubstring:String = String(self[range])
        return mySubstring
    }
    
    func substr(startFrom:Int)->String{
        let start = self.index(self.startIndex, offsetBy: startFrom)
        let range = start...

        let mySubstring:String = String(self[range])
        return mySubstring
    }
    
    func substr(end:Int)->String{
        let offset = self.index(self.endIndex, offsetBy: -(self.count-end))
        let range = ..<offset

        let mySubstring:String = String(self[range])
        return mySubstring
    }
}


