//
//  ViewController.swift
//  Forget
//
//  Created by Malik Arachiche on 7/24/18.
//  Copyright © 2018 Malik Arachiche. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var homeScreenLabel: UILabel!
    @IBOutlet weak var preMadebutton: UIButton!
    @IBOutlet weak var customButton: UIButton!
    
    //var premadeItem = CoreDataHelper.retrievePreMadeItems()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //self.navigationController?.navigationBar.isHidden = true
        
        self.navigationController?.navigationBar.tintColor = UIColor.white;

        view.setGradientBackground(colorOne: Colors.babyBlue, colorTwo: Colors.offWhite)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
    }

    @IBAction func preMadeButtonAction(_ sender: UIButton) {
    }
    @IBAction func customButtonAction(_ sender: UIButton) {
        let alert = UIAlertController(title: "Error", message: "Coming VERY Soon", preferredStyle: UIAlertControllerStyle.alert)
        present(alert, animated: true)
        alert.addAction(UIAlertAction(title: "Return", style: UIAlertActionStyle.cancel, handler: nil))
        return
    
    }
    
}
