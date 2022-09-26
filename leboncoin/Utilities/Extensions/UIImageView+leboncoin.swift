//
//  UIImageView+leboncoin.swift
//  leboncoin
//
//  Created by Messaoui Meriam on 21/09/2022.
//

import Foundation
import UIKit

extension UIImageView {
    
    func getImgFromUrl(link: String, contentMode mode: UIView.ContentMode) {
        guard let url = URL(string: link)  else { return }
        contentMode = mode
        URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) -> Void in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil, let image = UIImage(data: data) else { return }
            DispatchQueue.main.async {
                self.image = image
            }
        }).resume()
    }
}

extension String {
    func formattedAdDate() -> String? {
        let inputDateFormatter = DateFormatter()
        inputDateFormatter.locale = Locale(identifier: "FR-fr")
        inputDateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        if let date = inputDateFormatter.date(from: self) {
            let outputDateFormatter = DateFormatter()
            outputDateFormatter.locale = Locale(identifier: "FR-fr")
            outputDateFormatter.dateFormat = "dd/MM/yyyy à HH:mm"
            return outputDateFormatter.string(from: date)
        }
        return nil
    }
}
