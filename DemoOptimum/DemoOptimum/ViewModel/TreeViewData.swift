//
//  TreeViewData.swift
//  DemoOptimum
//
//  Created by Dharani on 20/3/19.
//  Copyright © 2019 Dharani. All rights reserved.

class TreeViewData
{
    var level: Int
    var name: String
    var id: String
    var parentId: String
    var valid: Int
    
    
    init?(level: Int, name: String, id: String, parentId: String, valid: Int)
    {
        self.level = level
        self.name = name
        self.id = id
        self.parentId = parentId
        self.valid = valid
    }
}


