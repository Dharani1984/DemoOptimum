//
//  TreeViewLists.swift
//  TreeView1
//
//  Created by Cindy Oakes on 5/21/16.
//  Copyright © 2016 Cindy Oakes. All rights reserved.
//

class TreeViewLists
{
    //MARK:  Load Array With Initial Data
    // let path = Bundle.main.path(forResource: "Contents", ofType: "json")
    static func LoadInitialData(jsonData: Any) -> [TreeViewData]
    {
        
        let countArray = (jsonData as AnyObject).count as Int
        let rawData = (jsonData as AnyObject)
        
        var data: [TreeViewData] = []
        for k in 0 ..< countArray {
            let  tempObj = rawData.objectAt(k) as! [AnyHashable: Any]
            let name1 = tempObj["name"] as! String
            let id1 = tempObj["id"] as! String
            let parentId1 = tempObj["parentId"] as! String
            data.append(TreeViewData(level: tempObj["level"] as! Int, name: name1, id: id1, parentId: parentId1, valid:tempObj["valid"] as! Int)!)
        }
        return data
    }
    
    //MARK:  Load Nodes From Initial Data
    
    static func LoadInitialNodes(_ dataList: [TreeViewData]) -> [TreeViewNode]
    {
        var nodes: [TreeViewNode] = []
        
        for data in dataList where data.level == 0
        {
            // print("\(data.name)")
            
            let node: TreeViewNode = TreeViewNode()
            node.nodeLevel = data.level
            node.nodeObject = data.name as AnyObject
            node.nodeValid = data.valid
            node.isExpanded = GlobalVariables.TRUE
            let newLevel = data.level + 1
            node.nodeChildren = LoadChildrenNodes(dataList, level: newLevel, parentId: data.id)
            
            if (node.nodeChildren?.count == 0)
            {
                node.nodeChildren = nil
            }
            
            nodes.append(node)
            
        }
        
        return nodes
    }
    
    //MARK:  Recursive Method to Create the Children/Grandchildren....  node arrays
    
    static func LoadChildrenNodes(_ dataList: [TreeViewData], level: Int, parentId: String) -> [TreeViewNode]
    {
        var nodes: [TreeViewNode] = []
        
        for data in dataList where data.level == level && data.parentId == parentId
        {
            //print("\(data.name)")
            
            let node: TreeViewNode = TreeViewNode()
            node.nodeLevel = data.level
            node.nodeObject = data.name as AnyObject
            node.nodeValid = data.valid
            node.isExpanded = GlobalVariables.FALSE
            let newLevel = level + 1
            node.nodeChildren = LoadChildrenNodes(dataList, level: newLevel, parentId: data.id)
            
            if (node.nodeChildren?.count == 0)
            {
                node.nodeChildren = nil
            }
            
            nodes.append(node)
            
        }
        return nodes
    }
}
