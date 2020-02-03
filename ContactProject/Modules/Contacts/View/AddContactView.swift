//
//  AddContactView.swift
//  ContactProject
//
//  Created by jeevan tiwari on 18/01/20.
//  Copyright © 2020 jeevan tiwari. All rights reserved.
//

import UIKit
import SDWebImage

enum AddEditContactEnum{
    case edit
    case add
}

class AddContactView: UIViewController{
    
    @IBOutlet weak var imageUser: UIImageView!
    @IBOutlet weak var itemDone: UIBarButtonItem!
    @IBOutlet weak var ItemCancel: UIBarButtonItem!
    @IBOutlet weak var tableView: UITableView!
    
    var viewModel = AddContactViewModel()
    var imagePicker: ImagePicker!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initilizations()
        addObservers()
        viewModel.createView()
    }
    
    func initilizations(){
        imageUser.accessibilityIdentifier = "PROFILE_IMAGE_IDENTIFIER"
        imageUser.layer.cornerRadius = Constants.screenWidth * 0.3 / 2
        itemDone.title = viewModel.titleDone
        ItemCancel.title = viewModel.titleCancel
        transparentNavigation()
    }
    
    func addObservers(){
        viewModel.genericTable = { [weak self] sections in
            self?.contactDetailTable.reloadData(sections)
            self?.imageUser.addImage(urlString: self?.viewModel.contact?.profilePic, placeholderImage: #imageLiteral(resourceName: "placeholder_photo.png"))
        }
        viewModel.showErrorAlert = { [weak self] message in
            self?.showAlert(message: message)
        }
        
        viewModel.addedContact = { [weak self] contact in
            
           let addEdit = self?.viewModel.from == AddEditContactEnum.add ? "added" : "edited"
            self?.showAlert(message: (self?.fullName(firstName: contact?.firstName, lastName: contact?.lastName))! + " \(addEdit) successfully")
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.8) {
                self?.dismiss()
            }
        }
        
        viewModel.showHud = { [weak self] show in
            self?.showHud(show: show)
        }
    }
    
    @IBAction func handleCancel(_ sender: Any) {
        dismiss()
    }
    
    @IBAction func handleAddContact(_ sender: Any) {
        viewModel.addContact()
    }
    
    @IBAction func handleAddPhoto(_ sender: Any) {
        if imagePicker == nil{
            imagePicker = ImagePicker(viewController: self)
        }
        imagePicker.delegate = self
        imagePicker.presentImagePickerOptions(showRemoveOption: true)
    }
    
    lazy var contactDetailTable: TableDataSource = {
        let dataSource = TableDataSource(tableView: self.tableView, registerCells: TableCellContactDetail.self)
        self.tableView.accessibilityIdentifier = "addContactTableView"
        return dataSource
    }()
}

extension AddContactView: PhotoPickerDelegate{
    func photoPicker(selectedImage: UIImage) {
        imageUser.image = selectedImage
    }
}



