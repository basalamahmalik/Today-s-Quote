//
//  savedQuoteViewController.swift
//  FinalProject
//
//  Created by Malik Basalamah on 19/05/1440 AH.
//  Copyright © 1440 Malik Basalamah. All rights reserved.
//

import Foundation
import UIKit

class savedQuoteViewController: UIViewController {
    
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var labelAuthor: UILabel!
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var backButton: UIButton!
    var quote: Quotes!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        label.text = "Quote about \(quote.category!)"
        textView.text = quote.quote
        labelAuthor.text = "By: \(quote.author!)"
    }
}
