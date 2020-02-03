//
//  ContactListView.swift
//  ContactProject
//
//  Created by jeevan tiwari on 18/01/20.
//  Copyright © 2020 jeevan tiwari. All rights reserved.
//

import UIKit

class ContactListView: UIViewController{
    
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        initilization()
        addObservers()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.getContacts()
    }
    
    func initilization(){
        title = viewModel.title
        transparentNavigation()
    }
    
    func addObservers(){
        viewModel.contactsGeneric = { [weak self] sections in
            self?.contactTable.reloadData(sections)
        }
        
        contactTable.selection = { [weak self] indexPath in
            self?.viewModel.jumpToContact(indexPath.section, indexPath.item)
        }
        
        viewModel.contactDetails = { [weak self] contact in
            let contactDetail = (self?.contactDetail)!
            contactDetail.viewModel.contact = contact
            self?.push(controller: contactDetail)
        }
        
        viewModel.showHud = { [weak self] show in
            self?.showHud(show: show)
        }
        
        viewModel.showAlert = { [weak self] message in
            self?.showAlert(message: message)
        }
    }
    
    
    @IBAction func handleAddContact(_ sender: Any) {
        present(controller: UINavigationController(rootViewController: addContact))
    }
    
    lazy var viewModel: ContactListViewModel = {
        return ContactListViewModel()
    }()
    
    lazy var contactTable: TableDataSource = {
        let dataSource = TableDataSource(tableView: self.tableView, registerCells: TableCellContactList.self, isSectionIndexTitleAvail: true)
        self.tableView.accessibilityIdentifier = "contactListTableView"
        return dataSource
    }()
}



