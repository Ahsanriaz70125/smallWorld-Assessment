//
//  UIImageView+Extension.swift
//  ModelViewVeiwModel
//
//  Created by Ahsan Riaz on 10/08/2023.
//

import UIKit
import Kingfisher

extension UIImageView {
    
    func setImage(with path: String) {
        let imageURL = "https://image.tmdb.org/t/p/original/\(path)"
        guard let url = URL.init(string: imageURL) else { return }
        
        
        let resourse = KF.ImageResource(downloadURL: url, cacheKey: imageURL)
        kf.indicatorType = .activity
        kf.setImage(with: resourse)
    }
}


extension String {
    
    func trimWhiteSpaces() -> Self {
        return trimmingCharacters(in: .whitespaces)
    }
    
    func contains(_ text: String) -> Bool {
        return range(of: text, options: .caseInsensitive) != nil
    }
    
    // returns ranges of substrings
    func ranges(of text: String) -> [NSRange]? {
        return try? NSRegularExpression(pattern: text, options: .caseInsensitive)
            .matches(in: self, options: .withTransparentBounds, range: NSRange(location: 0, length: count))
            .map { $0.range }
    }
}


extension UITableView {
    
    func showNoDataView(with message: String) {
        
        separatorStyle = .none
        let labelNoData = UILabel(frame: CGRect(x: 0, y: 0, width: frame.width, height: 100))
        labelNoData.text = message
        labelNoData.textAlignment = .center
        backgroundView = labelNoData
        reloadData()
    }
    
    func hideNoDataView() {
        separatorStyle = .singleLine
        backgroundView = nil
        reloadData()
    }
}
