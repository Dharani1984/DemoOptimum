//
//  ViewController.swift
//  DemoOptimum
//
//  Created by Dharani on 20/3/19.
//  Copyright © 2019 Dharani. All rights reserved.

import UIKit
import Foundation


class ViewController: UIViewController
{
    //MARK: Properties & Variables
    
    @IBOutlet weak var tableView: UITableView!
    
    var displayArray = [TreeViewNode]()
    var indentation: Int = 0
    var nodes: [TreeViewNode] = []
    var data: [TreeViewData] = []
    var data1: [TreeViewData] = []
    
    //MARK:  Init & Load
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        displayUI()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
//MARK:  Table View Methods
extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    //MARK:  Node/Data Functions
    @objc func ExpandCollapseNode(_ notification: Notification)
    {
        self.LoadDisplayArray()
        self.tableView.reloadData()
    }
    
    func displayUI() {
        let notificationName = Notification.Name("TreeNodeButtonClicked")
        
        NotificationCenter.default.addObserver(self, selector: #selector(ViewController.ExpandCollapseNode(_:)), name: notificationName, object: nil)
        
        if let path = Bundle.main.path(forResource: "contents", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                let jsonResult = try JSONSerialization.jsonObject(with: data, options: .mutableLeaves)
                if let jsonResult = jsonResult as? Dictionary<String, AnyObject>, let value = jsonResult["value"] as? [Any] {
                    // do stuff
                    
                    self.data = TreeViewLists.LoadInitialData(jsonData: value)
                    nodes = TreeViewLists.LoadInitialNodes(self.data)
                    self.LoadDisplayArray()
                    self.tableView.reloadData()
                }
            } catch {
                // handle error
            }
        }
    }
    func LoadDisplayArray()
    {
        self.displayArray = [TreeViewNode]()
        for node: TreeViewNode in nodes
        {
            self.displayArray.append(node)
            if (node.isExpanded == GlobalVariables.TRUE)
            {
                self.AddChildrenArray(node.nodeChildren as! [TreeViewNode])
            }
        }
    }
    func AddChildrenArray(_ childrenArray: [TreeViewNode])
    {
        for node: TreeViewNode in childrenArray
        {
            self.displayArray.append(node)
            if (node.isExpanded == GlobalVariables.TRUE )
            {
                if (node.nodeChildren != nil)
                {
                    self.AddChildrenArray(node.nodeChildren as! [TreeViewNode])
                }
            }
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat
    {
        return 50.0
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return displayArray.count;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        
        let node: TreeViewNode = self.displayArray[indexPath.row]
        
        //print("cellForRowAt \(node.nodeObject as! String?) , \(node.nodeValid)")
        let cell  = (self.tableView.dequeueReusableCell(withIdentifier: "cell") as! TreeViewCell)
        
        cell.treeNode = node
        cell.treeLabel.text = node.nodeObject as! String?
        
        
        if node.nodeValid == 0 { // As we mentioned the rule in json data, it will work based on that.
            cell.isUserInteractionEnabled = false
            cell.backgroundColor = UIColor.red
        }
        else {
            cell.isUserInteractionEnabled = true
            cell.backgroundColor = UIColor.white
        }
        
        if (node.isExpanded == GlobalVariables.TRUE)
        {
            cell.setTheButtonBackgroundImage(UIImage(named: "whiteOpen")!)
        }
        else
        {
            cell.setTheButtonBackgroundImage(UIImage(named: "whiteClose")!)
        }
        cell.setNeedsDisplay()
        
        return cell
    }
}
extension String {
    func jsonData() -> String {
        let path = Bundle.main.path(forResource: "contents", ofType: "json")
        return path!
    }
}
