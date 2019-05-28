//
//  String+Extension.swift
//  TemplateProject
//
//  Created by TrungPhan on 7/4/18.
//  Copyright © 2018 Dwarvesv. All rights reserved.
//

import Foundation
import UIKit

extension String {
    func grouping(every groupSize: Int, with separator: Character) -> String {
        let cleanedUpCopy = replacingOccurrences(of: String(separator), with: "")
        return String(cleanedUpCopy.enumerated().map() {
            $0.offset % groupSize == 0 ? [separator, $0.element] : [$0.element]
            }.joined().dropFirst())
    }
    func isValidEmail() -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailPredicate = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPredicate.evaluate(with: self)
    }
    
    func isNumber() -> Bool {
        var numberWithoutSpace = self.replacingOccurrences(of: " ", with: "")
        numberWithoutSpace = numberWithoutSpace.replacingOccurrences(of: ",", with: "")
        numberWithoutSpace = numberWithoutSpace.replacingOccurrences(of: "+", with: "")
        numberWithoutSpace = numberWithoutSpace.replacingOccurrences(of: "(", with: "")
        numberWithoutSpace = numberWithoutSpace.replacingOccurrences(of: ")", with: "")
        return !self.isEmpty && numberWithoutSpace.rangeOfCharacter(from: CharacterSet.decimalDigits.inverted) == nil
    }
    
    var URLEncoded: String {
        let allowedCharacters = NSCharacterSet.urlQueryAllowed
        if let encodedStr = self.addingPercentEncoding(withAllowedCharacters: allowedCharacters) {
            return encodedStr
        } else {
            return self
        }
    }
    
    func convertToImage() -> UIImage? {
        guard let dataDecoded = Data.init(base64Encoded: self, options: Data.Base64DecodingOptions.ignoreUnknownCharacters),
            let image = UIImage.init(data: dataDecoded) else {
                return nil
        }
        
        return image
    }
    
    func heightWithConstrainedWidth(width: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)
        
        return boundingBox.height
    }
    
    func widthWithConstrainedHeight(height: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: .greatestFiniteMagnitude, height: height)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)
        
        return boundingBox.width
    }
    
    func normalizeUrl() -> String {
        
        guard self.lowercased() != "na" else {
            return self
        }
        
        guard !self.hasPrefix("http://") && !self.hasPrefix("https://") else {
            return self
        }
        
        return "http://\(self)"
    }
    
    var html2AttributedString: NSAttributedString? {
        guard let data = data(using: .unicode) else { return nil }
        do {
            return try NSAttributedString(data: data, options: [
                NSAttributedString.DocumentReadingOptionKey.documentType : NSAttributedString.DocumentType.html,
                NSAttributedString.DocumentReadingOptionKey.characterEncoding : String.Encoding.utf8.rawValue], documentAttributes: nil)
        } catch let error as NSError {
            print(error.localizedDescription)
            return  nil
        }
    }
    
    var html2String: String {
        return html2AttributedString?.string ?? ""
    }
    
    func content(forSearchKeyword keyword: String) -> String {
        
        if let range: Range<String.Index> = self.lowercased().range(of: keyword) {
            
            //let index: Int = self.distance(from: keyword.startIndex, to: range.lowerBound)
            
            return String(self[self.startIndex ..< range.upperBound])
        }
        
        return ""
    }
    
    func needIgnoreContent() -> Bool {
        guard !self.isEmpty else {
            return true
        }
        
        let downcaseStr = self.lowercased()
        
        if downcaseStr == "na" {
            return true
        }
        
        return false
    }
    
    func colored(color: UIColor) -> NSAttributedString {
        var attributes = [NSAttributedString.Key: AnyObject]()
        attributes[.foregroundColor] = color
        return NSAttributedString(string: self, attributes: attributes)
    }
    func toBold() -> NSMutableAttributedString {
        let attrs = [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 14, weight: UIFont.Weight.medium)]
        let boldString = NSMutableAttributedString(string:"\(self)", attributes:attrs)
        return boldString
    }
    func toBold(color: UIColor, size: CGFloat) -> NSMutableAttributedString {
        let attrs = [NSAttributedString.Key.font : UIFont.systemFont(ofSize: size, weight: UIFont.Weight.medium), NSAttributedString.Key.foregroundColor: color]
        return NSMutableAttributedString(string:"\(self)", attributes:attrs)
    }
    func append(string:String, color:UIColor) -> NSMutableAttributedString{
        return NSMutableAttributedString(string: self).appEndColor(text:string, color:color)
    }
    

}
extension NSMutableAttributedString {
    @discardableResult func appEndBold(_ text:String) -> NSMutableAttributedString {
        let attrs = [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 14, weight: UIFont.Weight.medium)]
        let boldString = NSMutableAttributedString(string:"\(text)", attributes:attrs)
        self.append(boldString)
        return self
    }
    @discardableResult func appEndBold(_ text:String, color: UIColor, size:CGFloat) -> NSMutableAttributedString {
        let attrs = [NSAttributedString.Key.font : UIFont.systemFont(ofSize: size, weight: UIFont.Weight.medium), NSAttributedString.Key.foregroundColor: color]
        let boldString = NSMutableAttributedString(string:"\(text)", attributes:attrs)
        self.append(boldString)
        return self
    }
    @discardableResult func appEndColor(text:String, color: UIColor) -> NSMutableAttributedString {
        let attrs = [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 16), NSAttributedString.Key.foregroundColor: color]
        let coloredString = NSMutableAttributedString(string:"\(text)", attributes:attrs)
        self.append(coloredString)
        return self
    }
    @discardableResult func normal(_ text:String) -> NSMutableAttributedString {
        let normal =  NSAttributedString(string: text)
        self.append(normal)
        return self
    }
    
}
