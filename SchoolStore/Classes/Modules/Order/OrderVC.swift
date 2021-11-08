//  OrderVC.swift
//  SchoolStore
//
//  Created by Ксения Дураева on 24.10.2021.
//

import Foundation
import AutoLayoutSugar
import Kingfisher
import UIKit
import SwiftUI
import MapKit
final class OrderVC: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = L10n.Order.title
        
        view.backgroundColor = .white
        view.addSubview(contentView)
        contentView.addSubview(contentImageView)
        contentView.addSubview(tittleLabel)
        contentView.addSubview(departmentLabel)
        
        view.addSubview(addOneItem)
        view.addSubview(deleteOneItem)
        view.addSubview(textField)
        view.addSubview(numberOfFlat)
        view.addSubview(adress)
        
        
        view.addSubview(txtPicker)
        txtPicker.textField.inputView = datePickerToolbar
        view.addSubview(sentOrder)
        
        
        sentOrder.titleLabel?.setCharacterSpacing(1.25)
        sentOrder.setTitleColor(UIColor.white, for: .normal)
        sentOrder.backgroundColor = .systemBlue
        sentOrder.layer.cornerRadius = 8
        sentOrder.bottom(100).left(16).right(16).height(44)
        setup()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
        guard let num = textField.text else { return }
        let IntNum = Int(num)!
        guard let priceProduct = product?.price else { return }
        getPrice(numberProduct: IntNum, priceProduct: priceProduct)
        
        self.view.endEditing(true)
    }
    
    var product: Product? {
        didSet {
            
            tittleLabel.text = product?.title
            departmentLabel.text = product?.department
            
            let price = NumberFormatter.rubString(from: (product?.price)!)
            sentOrder.setTitle(L10n.Order.payTitle + price  , for: .normal)
            
            if let previewUrl = URL(string: (product?.preview)!) {
                let contentImageResource = ImageResource(downloadURL: previewUrl, cacheKey: product?.preview)
                contentImageView.kf.setImage(
                    with: contentImageResource,
                    placeholder: Asset.itemPlaceholder.image,
                    options: [
                        .transition(.fade(0.2)),
                        .forceTransition,
                        .cacheOriginalImage,
                        .keepCurrentImageWhileLoading,
                    ]
                )
            } else {
                contentImageView.image = Asset.itemPlaceholder.image
            }
        }
    }
    
    // MARK: Private
    
    private var snacker: Snacker?
    
    private var orderServise: OrderService?
    
    func setup(with orderServise: OrderService, snacker: Snacker){
        self.orderServise = orderServise
        self.snacker = snacker
    }
    
    private let textPrimaryColor: UIColor = Asset.textPrimary.color
    
    private let textSecondaryColor: UIColor = Asset.textSecondary.color
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.showsVerticalScrollIndicator = false
        return scrollView
    }()
    private lazy var pageView: UIView = {
        let contentView = UIView()
        contentView.backgroundColor = .green
        contentView.translatesAutoresizingMaskIntoConstraints = false
        return contentView
    }()
    
    private lazy var contentView: UIView = {
        let contentView = UIView()
        contentView.backgroundColor = .green
        contentView.translatesAutoresizingMaskIntoConstraints = false
        return contentView
    }()
    
    private lazy var contentImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var tittleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 14, weight: .medium)
        return label
    }()
    
    private lazy var departmentLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 14, weight: .medium)
        return label
    }()
    
    private lazy var addOneItem: UIButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(addNewItem), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = Asset.fieldBacground.color
        return button
    }()
    
    private lazy var deleteOneItem: UIButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(deleteItem), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = Asset.fieldBacground.color
        return button
    }()
    
    private lazy var textField: UITextField = {
        let txt = UITextField()
        txt.textAlignment = .center
        txt.text = "1"
        txt.translatesAutoresizingMaskIntoConstraints = false
        txt.inputView?.becomeFirstResponder()
        txt.keyboardType = .numberPad
        txt.layer.borderWidth = 0.5
        return txt
    }()
    
    private lazy var numberOfFlat: InputField = {
        let txtField = InputField()
        txtField.title = L10n.Order.apartment
        txtField.layer.cornerRadius = 12
        txtField.translatesAutoresizingMaskIntoConstraints = false
        return txtField
    }()
    
    private lazy var adress: InputField = {
        let txtField = InputField()
        txtField.translatesAutoresizingMaskIntoConstraints = false
        txtField.title = L10n.Order.house
        txtField.layer.cornerRadius = 12
        return txtField
    }()
    
    private lazy var txtPicker: InputField = {
        let txt = InputField()
        txt.translatesAutoresizingMaskIntoConstraints = false
        txt.title = L10n.Order.orderDate
        txt.layer.cornerRadius = 12
        txt.layer.cornerRadius = 8
        
        return txt
    }()
    private lazy var datePickerToolbar: UIDatePicker = {
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .date
        datePicker.addTarget(self, action: #selector(addDate), for: .valueChanged)
        datePicker.preferredDatePickerStyle = .wheels
        datePicker.locale = Locale(identifier: "ru_RU")
        
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        return datePicker
    }()
    
    private lazy var sentOrder: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(sentFormedOrder), for: .touchUpInside)
        return button
    }()
    
    private func setup() {
        
        contentView.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor).activate()
        
        contentImageView.width(112).height(112).left(16).top(16)
        
        tittleLabel.top(16).left(to: .right(16), of: contentImageView).right(10).width(230)
        tittleLabel.font = .systemFont(ofSize: 14, weight: .medium)
        tittleLabel.textColor = textPrimaryColor
        tittleLabel.lineBreakMode = NSLineBreakMode.byWordWrapping
        tittleLabel.numberOfLines = 3
        
        
        departmentLabel.top(to: .bottom(0), of: tittleLabel).right(6).left(to: .right(16), of: contentImageView)
        departmentLabel.textColor = .black
        
        
        addOneItem.width(32).height(28).top(to: .bottom(32), of: departmentLabel).left(231)
        addOneItem.setTitle("+", for: .normal)
        addOneItem.backgroundColor =  Asset.fieldBacground.color
        addOneItem.setTitleColor(.black, for: .normal)
        
        textField.left(to: .right(0), of: addOneItem).height(28).width(65).top(to: .bottom(32), of: departmentLabel)
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor.gray.cgColor
        textField.alpha = 0.5
        
        deleteOneItem.left(to: .right(0), of: textField).width(32).height(28).top(to: .bottom(32), of: departmentLabel)
        deleteOneItem.setTitle("-", for: .normal)
        deleteOneItem.backgroundColor =  Asset.fieldBacground.color
        
        deleteOneItem.setTitleColor(.black, for: .normal)
        
        adress.top(to: .bottom(53), of: addOneItem).left(16).right(16)
        
        numberOfFlat.top(to: .bottom(32), of: adress).left(16).right(16)
        
        txtPicker.top(to: .bottom(32), of: numberOfFlat).left(16).right(16)
    }
    
    func convertToIntValue(value: String) -> Int{
        let valueInt = Int(value)
        return valueInt!
    }
    
    func getPrice(numberProduct: Int, priceProduct: Int){
        let priceFinal = NumberFormatter.rubString(from: numberProduct * Int(priceProduct))
        sentOrder.setTitle(L10n.Order.payTitle + priceFinal  , for: .normal)
    }
    
    @objc
    func addDate(sender: UIDatePicker){
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ru_RU")
        formatter.dateFormat = "dd MMM yyyy"
        
        self.txtPicker.text = formatter.string(from: sender.date)
    }
    
    @objc
    func addNewItem(){
        guard let numberOfItems = textField.text else { return }
        guard let priceProduct = product?.price else { return }
        
        var num = convertToIntValue(value: numberOfItems)
        if num > 1 {
            deleteOneItem.isEnabled = true
        }
        num += 1
        getPrice(numberProduct: num, priceProduct: priceProduct)
        let stringValue =  String(num)
        textField.text = stringValue
    }
    
    @objc
    func deleteItem(){
        guard let numberOfItems = textField.text else { return }
        guard let priceProduct = product?.price else { return }
        
        var num = convertToIntValue(value: numberOfItems)
        if num == 1 {
            deleteOneItem.isEnabled = false
        }
        if num > 1 {
            deleteOneItem.isEnabled = true
            num -= 1
            getPrice(numberProduct: num, priceProduct: priceProduct)
            let stringValue =  String(num)
            textField.text = stringValue
            
        }
    }
    
    @objc
    func sentFormedOrder(){
        
        guard let quantity = textField.text, let house = adress.text, let apartment = numberOfFlat.text, let etd = txtPicker.text else { return }
        if house.isEmpty {
            adress.error = L10n.Common.emptyField
        }
        
        if apartment.isEmpty {
            numberOfFlat.error = L10n.Common.emptyField
        }
        
        if etd.isEmpty {
            txtPicker.error = L10n.Common.emptyField
        }
       
        
        let productId = (product?.id)!
        let size = (product?.sizes[0].value)!
        if ( !house.isEmpty && !apartment.isEmpty && !etd.isEmpty) {
            
            orderServise?.sendOrder(quantity: quantity, house: house, apartment: apartment, etd: etd, productId: productId, size: size, completion: { (result: Result<Void, Error>) in
                switch result {
                case .success:
                    self.navigationController?.popToRootViewController(animated: true)
                case let .failure(error):
                    self.snacker?.show(snack: error.localizedDescription, with: .error)
                    self.navigationController?.popToRootViewController(animated: true)
                }
            })
        }
        
    }
}






