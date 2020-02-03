//
//  ContactDetailView.swift
//  PersonalContacts
//
//  Created by jeevan tiwari on 16/01/20.
//  Copyright © 2020 jeevan tiwari. All rights reserved.
//

import UIKit

class ContactDetailView: UIViewController{
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var viewContactDetail: UIView!
    @IBOutlet weak var collectionView: UICollectionView!
    
    var viewModel = ContactDetailViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addObservers()
        viewModel.createViews()
    }
    
    
    func addObservers(){
        viewModel.genericSections = { [weak self] sections in
            self?.contactContactCollection.reloadData(sections)
        }
    }
    
    lazy var contactDetailTable: TableDataSource = {
        let dataSource = TableDataSource(tableView: self.tableView, registerCells: TableCellContactList.self)
        return dataSource
    }()
    
    lazy var contactContactCollection: DataSourceCollection = {
        let datSource = DataSourceCollection(controller: self, collectionView: self.collectionView)
        return datSource
    }()
}
