//
//  RepositoryTableViewCell.swift
//  github-browser-reswift
//
//  Created by haanwave on 2022/03/06.
//

import UIKit
import ListKit
import OctoKit

class RepositoryTableViewCell: UITableViewCell, ListKitCellProtocol {
    var model: Repository? {
        didSet {
            self.textLabel?.text = model?.name ?? "no name"
        }
    }
}
