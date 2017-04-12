//
//  WebViewController.swift
//  BoutTime
//
//  Created by howroot on 11/04/2017.
//  Copyright © 2017 Marcus Jepsen Klausen. All rights reserved.
//

import UIKit

class WebViewController: UIViewController {
    @IBOutlet weak var webView: UIWebView!

    var urlString = ""
    
    override func viewDidLoad() {
        super.viewDidLoad() 
        
        
        let link = URL(string: urlString)
        let request = URLRequest(url: link!)
        webView.loadRequest(request)
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
