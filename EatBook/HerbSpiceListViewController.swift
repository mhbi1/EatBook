//
//  HerbSpiceListViewController.swift
//  EatBook
//
//  Created by Michael Bi on 4/16/17.
//  Copyright © 2017 Michael Bi. All rights reserved.
//

import UIKit
import CoreData

class HerbSpiceListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var hbData: NSManagedObjectContext = (UIApplication.shared.delegate as! AppDelegate).managedObjectContext
    
    var herbSpices = [HerbSpice]()
    var urlString: String = ""
    
    @IBOutlet weak var herbSpiceTable: UITableView!
    
    func fetchList() {
        // Fetches the request, executes and adds to the array
        herbSpices = ((try? hbData.fetch(HerbSpice.fetchRequest())))!
    }
    
    // Datasource method that is called when table is loaded
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return herbSpices.count
    }
    
    // This datasource method will create each cell of the table
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // Get the LogItem for this index
        let hs = herbSpices[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "hsCell", for: indexPath)
        cell.textLabel?.text = hs.getName()
        cell.detailTextLabel?.textAlignment = .right
        
        
        /*let cell_Image = context.value(forKey: "image") as? Data
         cell.imageView?.image = UIImage(data: cell_Image!)*/
        
        return cell
    }
    
    // segue will be called as a row of the table is selected
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "toView"){
            let selectedIndex: IndexPath = self.herbSpiceTable.indexPath(for: sender as! UITableViewCell)!
            
            self.urlString = herbSpices[selectedIndex.row].getURL()
            
            if let vc: HerbSpiceViewController = segue.destination as? HerbSpiceViewController {
                vc.urlString = urlString
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
     
        // Create spice list
        let spiceList = [
            ("Allspice", "http://www.thekitchn.com/thekitchn/ingredients-pantry/from-the-spice-cupboard-allspice-101103"),
            ("Cayenne Pepper","http://www.thekitchn.com/thekitchn/ingredients-pantry/from-the-spice-cupboard-cayenne-pepper-085210"),
            ("Cinnamon","http://www.thekitchn.com/thekitchn/ingredients-pantry/from-the-spice-cupboard-cinnamon-115560"),
            ("Cloves","http://www.thekitchn.com/thekitchn/ingredients-pantry/from-the-spice-cupboard-cloves-097706"),
            ("Cumin","http://www.thekitchn.com/thekitchn/ingredients-pantry/from-the-spice-cupboard-cloves-097706"),
            ("Garlic Powder","http://www.thekitchn.com/thekitchn/seasonings/garlic-powder-yay-or-nay-103636"),
            ("Ginger","http://www.thekitchn.com/ground-ginger-ingredient-intelligence-211363"),
            ("Nutmeg","http://www.thekitchn.com/thekitchn/ingredients-pantry/from-the-spice-cupboard-nutmeg-069844"),
            ("Oregano","http://www.thekitchn.com/thekitchn/whats-the-difference-mediterranean-and-mexican-oregano-093923"),
            ("Paprika","http://www.thekitchn.com/thekitchn/ingredients-pantry/whats-the-difference-paprika-068134"),
            ("Rosemary","http://www.thekitchn.com/thekitchn/seasonings/from-the-herb-garden-rosemary-093261"),
            ("Sage","http://www.thekitchn.com/thekitchn/ingredients-pantry/from-the-spice-cupboard-sage-077424"),
            ("Star Anise","http://www.thekitchn.com/thekitchn/ingredients-pantry/new-secret-ingredient-star-anise-066365"),
            ("Turmeric","http://www.thekitchn.com/thekitchn/ingredients-pantry/from-the-spice-cupboard-turmeric-088166"),
            ("Thyme","http://www.thekitchn.com/thekitchn/seasonings/from-the-spice-cupboard-thyme-089346")
        ]
        
        let herbList = [
            ("Basil", "http://www.thekitchn.com/seasonal-spotlight-basil-88762"),
            ("Cilantro", "http://www.thekitchn.com/the-herb-you-love-or-hate-cilantro-ingredient-intelligence-210866"),
            ("Dill", "http://www.thekitchn.com/thekitchn/ingredients-herbs/from-the-herb-garden-dill-112388"),
            ("Mint", "http://www.thekitchn.com/thekitchn/from-the-herb-garden-mint-110897"),
            ("Oregano (fresh)", "http://www.thekitchn.com/thekitchn/whats-the-difference-mediterranean-and-mexican-oregano-093923"),
            ("Parsley", "http://www.thekitchn.com/ingredient-spotlight-italian-parsley-169880"),
            ("Rosemary (fresh)", "http://www.thekitchn.com/thekitchn/seasonings/from-the-herb-garden-rosemary-093261"),
            ("Sage (fresh)", "http://www.thekitchn.com/thekitchn/ingredients-pantry/from-the-spice-cupboard-sage-077424"),
            ("Thyme (fresh)", "http://www.thekitchn.com/thekitchn/seasonings/from-the-spice-cupboard-thyme-089346")
        ]
        
        // Loop through, creating items
        for (nameText, urlLink) in herbList {
            // Create an individual item
            HerbSpice.createInManagedObjectContext(moc: hbData,
                                    name: nameText, url: urlLink)
        }
        // Loop through, creating items
        for (nameText, urlLink) in spiceList {
            // Create an individual item
            HerbSpice.createInManagedObjectContext(moc: hbData,
                                                   name: nameText, url: urlLink)
        }
        
        fetchList()
    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
