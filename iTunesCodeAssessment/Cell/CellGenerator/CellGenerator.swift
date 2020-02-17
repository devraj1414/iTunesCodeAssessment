//
//  CellGenerator.swift
//  iTunesCodeAssessment
//
//  Created by Suruchi Kumari on 16/02/20.
//  Copyright © 2020 Suruchi Kumari. All rights reserved.
//

import Foundation
import UIKit
protocol GenericCell {
    associatedtype DataType
    func configureCell(data : DataType)
}

protocol CellGenerator {
    static var reuseIdentifier : String{get}
    func confgure(cell : UITableViewCell)
}

class TableCellGenerator<CellType : GenericCell, DataType>: CellGenerator where CellType.DataType == DataType,  CellType: UITableViewCell {
    static var reuseIdentifier: String{
        return String(describing: CellType.self)
    }
    let item : DataType
    init(item : DataType){
        self.item = item
    }
    func confgure(cell: UITableViewCell) {
        if let c = cell as? CellType{
            c.configureCell(data: item)
        }
    }
}

