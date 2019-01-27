//
//  DataInformation.swift
//  FinalProject
//
//  Created by Malik Basalamah on 11/05/1440 AH.
//  Copyright © 1440 Malik Basalamah. All rights reserved.
//

import Foundation
struct DataInformation{
    
    let quote:String?
    let author:String?
    let title: String?
    let category:String?
    
    init(dataDictionary: [String:AnyObject])
    {
        // Check & Set the most important properties
        if let quote = dataDictionary[Constants.ParameterKeys.quote] as? String {
            self.quote = quote
        } else {
            self.quote = ""
        }
        if let author = dataDictionary[Constants.ParameterKeys.author] as? String {
            self.author = author
        } else {
            self.author = ""
        }
        if let title = dataDictionary[Constants.ParameterKeys.title] as? String {
            self.title = title
        } else {
            self.title = ""
        }
        if let category = dataDictionary[Constants.ParameterKeys.category] as? String {
            self.category = category
        } else {
            self.category = ""
        }
    }
    
    static func DataFromResults(_ results: [[String:AnyObject]]) -> [DataInformation] {
        
        var data = [DataInformation]()
        
        // iterate through array of dictionaries, each Movie is a dictionary
        for result in results {
            data.append(DataInformation(dataDictionary: result))
        }
        return data
    }
}
