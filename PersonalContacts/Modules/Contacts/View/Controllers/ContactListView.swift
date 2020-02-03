//
//  ContactListView.swift
//  PersonalContacts
//
//  Created by jeevan tiwari on 15/01/20.
//  Copyright © 2020 jeevan tiwari. All rights reserved.
//

import UIKit

class ContactListView: UIViewController{
    
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        addObservers()
        viewModel.getContest()
    }
    
    func addObservers(){
        viewModel.contactsGeneric = { [weak self] sections in
            self?.contactTable.reloadData(sections)
        }
        
        contactTable.selection = { [weak self] indexPath in
            self?.push(controller: (self?.contactDetail)!)
        }
    }
    
    lazy var viewModel: ContactListModel = {
        return ContactListModel()
    }()
    
    lazy var contactTable: TableDataSource = {
        let dataSource = TableDataSource(tableView: self.tableView, registerCells: TableCellContactList.self, isSectionIndexTitleAvail: true)
        return dataSource
    }()
}


