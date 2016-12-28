//
//  ViewController.swift
//  TableViewTips
//
//  Created by melody5417 on 28/12/2016.
//  Copyright © 2016 melody5417. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet var tableView: UITableView!
    
    let testValue = "This is test value\nThis is test value\nThis is test value\nThis is test value\nThis is test value\n"
    
    var dic: Dictionary<String, String> = [:]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // delete default seperator of tableview
        //tableView.tableFooterView = UIView()
        
        // follow two lines also can achieve dynamic adjusted row height
        //tableView.estimatedRowHeight = 10
        //tableView.rowHeight = UITableViewAutomaticDimension
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: UITableViewDataSource
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1;
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 100;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        let label = cell.contentView.viewWithTag(1000) as! UILabel
        label.text = testValue
        
        if dic[String(indexPath.row)] == "0" {
            label.numberOfLines = 0
        } else {
            label.numberOfLines = 1
        }
        
        updateCell(cell)
        
        return cell
    }
    
    // MARK: UITableViewDelegate
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        // default the label only show one line, set label lines to zero will show all lines.
        
        let attribute = [NSFontAttributeName : UIFont.systemFont(ofSize: 17)]
        let value: NSString = testValue as NSString
        return value.boundingRect(with: CGSize(width: 300, height: 0), options: .usesLineFragmentOrigin, attributes: attribute, context: nil).size.height + 20
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let label = cell.contentView.viewWithTag(1000) as! UILabel
        label.numberOfLines = 1
        
        // beginUpdates and endUpdates not work!!!
        //tableView.beginUpdates()
        if dic[String(indexPath.row)] == "0" {
            label.numberOfLines = 1
            dic[String(indexPath.row)] = "1"
        } else {
            label.numberOfLines = 0
            dic[String(indexPath.row)] = "0"
        }
        //tableView.endUpdates()
        
        tableView.reloadData()
    }
 
    override func viewDidLayoutSubviews() {
        tableView.separatorInset = UIEdgeInsets.zero
        tableView.layoutMargins = UIEdgeInsets.zero
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.separatorInset = UIEdgeInsets.zero
        cell.layoutMargins = UIEdgeInsets.zero
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        for cell in tableView.visibleCells {
            updateCell(cell)
        }
    }
    
    func updateCell(_ cell: UITableViewCell) {
        let imageView = cell.contentView.viewWithTag(2000)
        let rect = imageView?.convert(cell.contentView.bounds, to: nil)
        var Y = UIScreen.main.bounds.size.height - (rect?.origin.y)! - 700
        print(Y)
        if Y > 0 {
            Y = 0
        }
        if Y < -100 {
            Y = -100
        }
        imageView?.frame.origin.y = Y
    }
}

