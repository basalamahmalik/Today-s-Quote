//
//  TableViewController.swift
//  FinalProject
//
//  Created by Malik Basalamah on 10/05/1440 AH.
//  Copyright © 1440 Malik Basalamah. All rights reserved.
//

import UIKit
import CoreData


class TableViewController: UITableViewController {

    var fetchedResultsController:NSFetchedResultsController<Quotes>!

    override func viewDidLoad() {
        super.viewDidLoad()

        fetch()
    }
    
    func fetch() {
        let fetchRequest: NSFetchRequest<Quotes> = Quotes.fetchRequest()
        let sortDescriptor = NSSortDescriptor(key: "date", ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]

        fetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: DataController.shared.viewContext, sectionNameKeyPath: nil, cacheName: nil)
        fetchedResultsController.delegate = self as? NSFetchedResultsControllerDelegate
        do {
            try fetchedResultsController.performFetch()
        } catch {
            fatalError("The fetch could not be performed: \(error.localizedDescription)")
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewDidLoad()
        tableView.reloadData()
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return fetchedResultsController.sections?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fetchedResultsController.sections?[section].numberOfObjects ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let quotes = fetchedResultsController.object(at: indexPath)
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath)
        cell.textLabel?.text = quotes.quote
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let vc = storyboard?.instantiateViewController(withIdentifier: "savedQuoteViewController") as? savedQuoteViewController else {
            return
        }
        let quote = fetchedResultsController.object(at: indexPath)
        vc.quote = quote
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        switch editingStyle {
        case .delete:
            let quotes = fetchedResultsController.object(at: indexPath)
            DataController.shared.viewContext.delete(quotes)
            try? DataController.shared.viewContext.save()
        default:
            break
        }
    }
}
