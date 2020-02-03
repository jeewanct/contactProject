//
//  TableCellContactDetail.swift
//  ContactProject
//
//  Created by jeevan tiwari on 18/01/20.
//  Copyright © 2020 jeevan tiwari. All rights reserved.
//

import UIKit

class TableCellContactDetail: BaseTableCell {

    override var data: Any?{
        didSet{
            setup()
        }
    }
    @IBOutlet weak var txtFieldValue: UITextField!
    @IBOutlet weak var lblPlaceholder: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        txtFieldValue.delegate = self
        txtFieldValue.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        txtFieldValue.accessibilityIdentifier = "TableCellContactDetail_TextField_FieldValue"
        lblPlaceholder.accessibilityIdentifier = "TableCellContactDetail_Label_Placeholder"
    }

    private func setup(){
        guard let unwrappedDetails = data as? ContactDetailsInfo else { return }
        lblPlaceholder.text = unwrappedDetails.placeholder
        txtFieldValue.text = unwrappedDetails.fieldValue
        txtFieldValue.placeholder =  "Enter " + unwrappedDetails.placeholder!
        txtFieldValue.isUserInteractionEnabled = unwrappedDetails.isEditable
    }
    
}

extension TableCellContactDetail: UITextFieldDelegate{
    @objc func textFieldDidChange(_ textField: UITextField) {
        (data as? ContactDetailsInfo)?.fieldValue = textField.text ?? ""
    }
}
