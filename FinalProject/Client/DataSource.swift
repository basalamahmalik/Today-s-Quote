//
//  DataSource.swift
//  FinalProject
//
//  Created by Malik Basalamah on 13/05/1440 AH.
//  Copyright © 1440 Malik Basalamah. All rights reserved.
//

import Foundation
class DataSource{
    
    var data = [DataInformation]()
    
    // MARK: Singleton
    static let sharedInstance = DataSource()
    private init() {}
}
