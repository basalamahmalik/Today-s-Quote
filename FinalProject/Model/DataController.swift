//
//  DataController.swift
//  FinalProject
//
//  Created by Malik Basalamah on 10/05/1440 AH.
//  Copyright © 1440 Malik Basalamah. All rights reserved.
//

import Foundation
import CoreData

class DataController {
    static let shared = DataController()
    
    private let persistentContainer:NSPersistentContainer
    
    var viewContext:NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
    private init() {
        persistentContainer = NSPersistentContainer(name: "FinalProject")
    }
    
    func load(completion: (() -> Void)? = nil) {
        persistentContainer.loadPersistentStores { storeDescription, error in
            guard error == nil else {
                fatalError(error!.localizedDescription)
            }
            self.autoSaveViewContext()
            completion?()
        }
    }
}

// MARK: - Autosaving

extension DataController {
    private func autoSaveViewContext(interval:TimeInterval = 30) {
        let timeInterval = interval > 0 ? interval : 30
        if interval <= 0 {
            // just informing the developer that something wrong has happened
            print("time interval should be greater than 0, will use the default time interval")
        }
        
        if viewContext.hasChanges {
            try? viewContext.save()
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + timeInterval) {
            self.autoSaveViewContext(interval: timeInterval)
        }
    }
}
