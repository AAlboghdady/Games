//
//  String+Extension.swift
//  Games
//
//  Created by Abdurrahman Alboghdady on 01/06/2023.
//

import UIKit

extension String {
    var htmlToAttributedString: NSAttributedString? {
        guard let data = data(using: .utf8) else { return NSAttributedString() }
        do {
            return try NSAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding: String.Encoding.utf8.rawValue], documentAttributes: nil)
        } catch {
            return NSAttributedString()
        }
    }
    
    func convertHtmlToAttributedStringWithCSS(font: UIFont?, csstextalign: String = "left", lineheight: String = "20") -> NSAttributedString? {
        guard let font = font else {
            return htmlToAttributedString
        }
        let modifiedString =
        "<style>" +
        "body{" +
        "font-family: '\(font.fontName)'; " +
        "font-size:\(font.pointSize)px; " +
        //        "color: \(csscolor); " +
        "line-height: \(lineheight)px; " +
        "text-align: \(csstextalign); " +
        "} " +
        "</style>\(self)"
        guard let data = modifiedString.data(using: .utf8) else {
            return nil
        }
        do {
            return try NSAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding: String.Encoding.utf8.rawValue], documentAttributes: nil)
        }
        catch {
            print(error)
            return nil
        }
    }
}
