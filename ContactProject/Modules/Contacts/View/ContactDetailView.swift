//
//  ContactDetailView.swift
//  ContactProject
//
//  Created by jeevan tiwari on 18/01/20.
//  Copyright © 2020 jeevan tiwari. All rights reserved.
//

import UIKit

class ContactDetailView: UIViewController{
 
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var imageContact: UIImageView!
    @IBOutlet weak var lbluserName: UILabel!

    var viewModel = ContactDetailViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        addObservers()
        viewModel.createViews()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.getContactDetails()
    }
    
    func addObservers(){
        viewModel.genericSectionsCollection = { [weak self] sections in
            self?.contactContactCollection.reloadData(sections)
        }
        
        viewModel.genericSectionTable = { [weak self] sections in
            self?.contactDetailTable.reloadData(sections)
            self?.lbluserName.text = self?.fullName(firstName: self?.viewModel.contact?.firstName, lastName: self?.viewModel.contact?.lastName)
            self?.imageContact.addImage(urlString: self?.viewModel.contact?.profilePic, placeholderImage: #imageLiteral(resourceName: "placeholder_photo.png") )
        }
        
        viewModel.showAlert = { [weak self] message in
            self?.showAlert(message: message)
            if self?.viewModel.deletedSuccessfully == true{
                DispatchQueue.main.asyncAfter(deadline: .now() + 2.8) {
                    self?.pop()
                }
            }
        }
        
        contactContactCollection.selection = { [weak self] indexPath in
            self?.viewModel.contactTo(indexPath.item)
        }
        
        viewModel.showHud = { [weak self] show in
            self?.showHud(show: show)
        }
        
        viewModel.contactUser = { url in
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }
    
    @IBAction func handleDeleteContact(_ sender: Any) {
        viewModel.deleteContact()
    }
    
    @IBAction func handleEditContact(_ sender: Any) {
        let editContact = addContact
        editContact.viewModel.from = .edit
        editContact.viewModel.contact = viewModel.contact
        present(controller: UINavigationController(rootViewController: editContact))
    }
    
   
    lazy var contactDetailTable: TableDataSource = {
        let dataSource = TableDataSource(tableView: self.tableView, registerCells: TableCellContactDetail.self)
        return dataSource
    }()
    
    lazy var contactContactCollection: DataSourceCollection = {
        let datSource = DataSourceCollection(controller: self, collectionView: self.collectionView)
        self.collectionView.accessibilityIdentifier = "CONTACT_IDENTIFIER"
        return datSource
    }()
}

