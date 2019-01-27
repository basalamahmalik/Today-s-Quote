//
//  Constants.swift
//  FinalProject
//
//  Created by Malik Basalamah on 10/05/1440 AH.
//  Copyright © 1440 Malik Basalamah. All rights reserved.
//

import Foundation
import UIKit

class Constants{

    struct BASE {
        static let APIScheme = "http"
        static let APIHost = "quotes.rest"
        static let APIPath = "/qod.json"
    }
    
    
    struct ParameterKeys {
        static let category = "category"
        static let quote = "quote"
        static let title = "title"
        static let author = "author"
    }

    // MARK: Response Keys
    struct ResponseKeys {
        static let Status = "stat"
        static let quote = "quote"
        static let title = "title"
        static let author = "author"
        static let contents = "contents"
        static let quotes = "quotes"
        static let category = "category"
    }
    
    struct Types {
        static let Inspire = "inspire"
        static let Art = "art"
        static let Life = "life"
        static let Love = "love"
    }
    
    // MARK: Response Values
    struct ResponseValues {
        static let OKStatus = "success"
    }
    
}
