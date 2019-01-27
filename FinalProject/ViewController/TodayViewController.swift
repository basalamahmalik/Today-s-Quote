//
//  TodayViewController.swift
//  FinalProject
//
//  Created by Malik Basalamah on 10/05/1440 AH.
//  Copyright © 1440 Malik Basalamah. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class TodayViewController: UIViewController,NSFetchedResultsControllerDelegate {
    
    @IBOutlet weak var indicator: UIActivityIndicatorView!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var likeButton: UIButton!
    @IBOutlet weak var shareButton: UIButton!
    @IBOutlet weak var headerLabel: UILabel!
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var inspireButton: UIButton!
    @IBOutlet weak var lifeButton: UIButton!
    @IBOutlet weak var loveButton: UIButton!
    @IBOutlet weak var artButton: UIButton!
    var category: String = ""
    
    var dataInformation = DataSource.sharedInstance.data
    var fetchedResultsController:NSFetchedResultsController<Quotes>!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.shareButton.isEnabled = textView?.text != nil
        indicator.isHidden = true
        fetch()
    }
    
    func fetch() {
        let fetchRequest: NSFetchRequest<Quotes> = Quotes.fetchRequest()
        // TODO: Sort the results
        let sortDescriptor = NSSortDescriptor(key: "date", ascending: false)
        fetchRequest.sortDescriptors = [sortDescriptor]
        // TODO: create the fetched results controller
        fetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: DataController.shared.viewContext, sectionNameKeyPath: nil, cacheName: nil)
        fetchedResultsController.delegate = self
        
        // TODO: perform the fetch with fetchedResultsController
        do {
            try fetchedResultsController.performFetch()
        } catch {
            Client.sharedInstance().displayError("The fetch could not be performed: \(error.localizedDescription)", viewController: self) { (success) in
                // do nothing
            }
        }
    }
    
    @IBAction func inspireAction(_ sender: Any) {
        indicator.isHidden = false
        indicator.startAnimating()
        Client.sharedInstance().qoutesOfTheDay(Constants.Types.Inspire) { (success, results , errorString) in
            if success {
                self.dataInformation = results!
                for info in self.dataInformation{
                performUIUpdatesOnMain {
                    self.indicator.stopAnimating()
                    self.indicator.isHidden = true
                    self.textView.text = info.quote
                    self.headerLabel.text = info.title
                    self.authorLabel.text = info.author!
                    self.category = info.category!
                    }
                }
            }else {
                Client.sharedInstance().displayError(errorString, viewController: self, { (success) in
                    // do nothing
                })
            }
        }
    }
    
    @IBAction func lifeAction(_ sender: Any) {
        indicator.isHidden = false
        indicator.startAnimating()
        Client.sharedInstance().qoutesOfTheDay(Constants.Types.Life) { (success, results , errorString) in
            if success {
                self.dataInformation = results!
                for info in self.dataInformation{
                    performUIUpdatesOnMain {
                        self.indicator.stopAnimating()
                        self.indicator.isHidden = true
                        self.textView.text = info.quote
                        self.headerLabel.text = info.title
                        self.authorLabel.text = info.author!
                        self.category = info.category!

                    }
                }
            }else {
                Client.sharedInstance().displayError(errorString, viewController: self, { (success) in
                    // do nothing
                })
            }
        }
    }
    
    @IBAction func loveAction(_ sender: Any) {
        indicator.isHidden = false
        indicator.startAnimating()
        Client.sharedInstance().qoutesOfTheDay(Constants.Types.Love) { (success, results , errorString) in
            if success {
                self.dataInformation = results!
                for info in self.dataInformation{
                    performUIUpdatesOnMain {
                        self.indicator.stopAnimating()
                        self.indicator.isHidden = true
                        self.textView.text = info.quote
                        self.headerLabel.text = info.title
                        self.authorLabel.text = info.author!
                        self.category = info.category!

                    }
                }
            }else {
                Client.sharedInstance().displayError(errorString, viewController: self, { (success) in
                    // do nothing
                })
            }
        }
    }
    
    @IBAction func artAction(_ sender: Any) {
        indicator.isHidden = false
        indicator.startAnimating()
        Client.sharedInstance().qoutesOfTheDay(Constants.Types.Art) { (success, results , errorString) in
            if success {
                self.dataInformation = results!
                for info in self.dataInformation{
                    performUIUpdatesOnMain {
                        self.indicator.stopAnimating()
                        self.indicator.isHidden = true
                        self.textView.text = info.quote
                        self.headerLabel.text = info.title
                        self.authorLabel.text = info.author!
                        self.category = info.category!
                    }
                }
            }else {
                Client.sharedInstance().displayError(errorString, viewController: self, { (success) in
                    // do nothing
                })
            }
        }
    }
    
    
    @IBAction func likeAction(_ sender: Any) {
        let qoutes = Quotes(context: DataController.shared.viewContext)
        qoutes.author = authorLabel.text
        qoutes.quote = textView.text
        qoutes.category = category
        qoutes.date = Date()
        try? DataController.shared.viewContext.save()
    }
    
    
    @IBAction func shareAction(_ sender: Any) {
        // set up activity view controller
        let textToShare = [ "\(textView.text!) #### By: \(authorLabel.text!)" ]
        let activityViewController = UIActivityViewController(activityItems: textToShare as [Any], applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView = self.view // so that iPads won't crash
            
        // present the view controller
        self.present(activityViewController, animated: true, completion: nil)
    }
}

