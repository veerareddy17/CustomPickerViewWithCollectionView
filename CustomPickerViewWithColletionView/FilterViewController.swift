//
//  FilterViewController.swift
//  ScrumptiousFruits
//
//  Created by Veera Reddy on 7/18/17.
//  Copyright © 2017 Temp. All rights reserved.
//

import UIKit

class FilterViewController: UIViewController,UIPickerViewDataSource,UIPickerViewDelegate, UITextFieldDelegate {
    
    let reuseIdentifier:String = "ItemCVCell"
    
    var isPreference:Bool = false
    var isPrice:Bool = false
    var isDiscount:Bool = false
    
    //MARK:- IBOutlet
    
    @IBOutlet weak var collection_view: UICollectionView!
    @IBOutlet weak var collection_view_height: NSLayoutConstraint!
    
    //MARK:- Properties
    
    var pickerView:UIPickerView?
    let tempText = UITextField(frame: CGRect.zero)
    var priceList = ["0 to 50","51 to 100","101 to 150","151 to 200","More Than 200"]
    var discountList = ["0% to 10%","11% to 20%","21% to 30%","31% to 40%","41% to 50%","Morethan 51%"]
    var preferenceList = ["Alphabetical","Price - Low to High","Price - High to Low"]
    
    var picker_dictionary:NSMutableDictionary = NSMutableDictionary()
    var category_identity:Int = 0
    var selectedOptions:NSMutableArray = NSMutableArray()
    var preference_options:[String] = []
    var discount_options:[String] = []
    var price_options:[String] = []

   
    //MARK:- View Life Cycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "Filter"
//        let barButton = UIBarButtonItem(image: #imageLiteral(resourceName: "Close"), style: .done, target: self, action: #selector(self.backButtonTapped))
//        navigationItem.leftBarButtonItem = barButton
        tempText.delegate = self
        view.addSubview(tempText)
        showPickerView(sender: tempText)
        collection_view.delegate = self
        collection_view.dataSource = self
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
    }
    
    // MARK:- UIPickerViewDataSource Methods
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        if pickerView.tag == 0 {
            return preferenceList.count
        }
        else if pickerView.tag == 1 {
            return priceList.count
        }
        
        return discountList.count
    }
    
    // MARK:- UIPickerViewDelegate Method
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 30
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        if pickerView.tag == 0 {
            return preferenceList[row]
        }
        else if pickerView.tag == 1 {
            return priceList[row]
        }
        
        return discountList[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        if pickerView.tag == 0 {
            
            picker_dictionary.setValue(getTextFromPicker(pickerView: pickerView, row: row), forKey: "preference")
            isPreference = true
            
        }else if pickerView.tag == 1 {
            
            picker_dictionary.setValue(getTextFromPicker(pickerView: pickerView, row: row), forKey: "price")
            isPrice = true
            
        }else {
            
            picker_dictionary.setValue(getTextFromPicker(pickerView: pickerView, row: row), forKey: "discount")
            isDiscount = true
        }

    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        
        let pickerLabel = UILabel()
        pickerLabel.textColor = UIColor.black
        pickerLabel.text = getTextFromPicker(pickerView: pickerView, row: row)
        pickerLabel.font = UIFont.boldSystemFont(ofSize: 20)
        pickerLabel.textAlignment = .center
        return pickerLabel
    }
    
    func getTextFromPicker(pickerView: UIPickerView, row: Int) -> String {
        
        if pickerView.tag == 0 {
            return preferenceList[row]
        } else if pickerView.tag == 1 {
            return priceList[row]
        }else{
            return  discountList[row]
        }
    }
    
    // MARK:- IBAction Methods
    
    @IBAction func preferenceButtonTapped(_ sender: Any) {
        
        category_identity = 1
        reloadData(sender as! UIButton, tagValue: 0)
    }
    
    @IBAction func priceButtonTapped(_ sender: Any) {
        category_identity = 2
        reloadData(sender as! UIButton, tagValue: 1)
    }
    
    @IBAction func discountButtonTapped(_ sender: Any) {
        category_identity = 3
        reloadData(sender as! UIButton, tagValue: 2)
    }
    
    // MARK:- PrivateMethods
    
    private func reloadData(_ sender: UIButton, tagValue : Int) {
        
        pickerView!.tag = tagValue
        tempText.becomeFirstResponder()
        pickerView!.reloadAllComponents()
    }
   
    
    @IBAction func clearButtonTapped(_ sender: Any) {
        
    }
    private func showPickerView(sender:UITextField)
    {
        let pickerToolBar: UIToolbar = UIToolbar()
        pickerToolBar.barStyle = .blackTranslucent
        pickerToolBar.backgroundColor = UIColor.darkGray
        pickerToolBar.tintColor = UIColor.white
        pickerToolBar.sizeToFit()
        
        let leftFlexibleButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let doneButton = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(doneButtonTapped(_:)))
        pickerToolBar.setItems([leftFlexibleButton, doneButton], animated: false)
        
        pickerView = UIPickerView(frame: CGRect(x: 0, y: 0, width: view.bounds.size.width, height: 216))
        pickerView?.delegate = self
        pickerView?.dataSource = self
        pickerView?.showsSelectionIndicator = true
        pickerView?.backgroundColor = UIColor.clear
        
        let pickerRowSize = pickerView(pickerView!, rowHeightForComponent: 0)
        let customView = UIView(frame: pickerView!.bounds)
        customView.backgroundColor = UIColor.white
        
        let centreImageView = UIImageView(frame: CGRect(x: 0, y: customView.bounds.height/2 - pickerRowSize/2, width: customView.bounds.width, height: pickerRowSize))
        centreImageView.backgroundColor = UIColor.darkGray
        customView.addSubview(centreImageView)
        
        pickerView?.autoresizingMask = .flexibleWidth
        customView.autoresizingMask = .flexibleWidth
        centreImageView.autoresizingMask = .flexibleWidth
        
        customView.addSubview(pickerView!)
        
        if sender == tempText {
            sender.inputView = customView
            sender.inputAccessoryView = pickerToolBar
        }
    }
    
    func doneButtonTapped(_ item:UIBarButtonItem)  {
        tempText.resignFirstResponder()
        print(picker_dictionary)
        
        if category_identity == 1 {
            
            if isPreference {
                
            }else {
                picker_dictionary.setValue(preference_options[0], forKey: "preference")
                isPreference = false
            }
            
        }else if category_identity == 2 {
            
            if isPrice {
                
            }else {
                picker_dictionary.setValue(price_options[0], forKey: "price")
                isPrice = false
            }
            
        }else {
            
            if isDiscount {
                
            }else {
                picker_dictionary.setValue(discount_options[0], forKey: "discount")
                isPrice = false
            }
            
        }
        selectedOptions.removeAllObjects()
        self.loadPreferenceCollection(picker_dictionary)
        
    }
    
    func loadPreferenceCollection(_ dict:NSMutableDictionary) -> Void {
        let array:NSArray = dict.allValues as NSArray
        print(array)
        for index in 0...array.count-1 {
            selectedOptions.add(array.object(at: index))
        }
        collection_view.reloadData()
    }
    
//    func backButtonTapped() {
//        navigationController!.popViewController(animated: false)
//    }
}

extension FilterViewController : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    //Mark:- UICollection View Data Source
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if selectedOptions.count > 2 {
            collection_view_height.constant = 70
        }else {
            collection_view_height.constant = 40
        }
        return selectedOptions.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let itemCell:ItemCVCell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! ItemCVCell
        itemCell.item_label.text = selectedOptions.object(at: indexPath.item) as? String
        itemCell.item_label.font = UIFont(name: "Helvetica", size: 16.0)!
        return itemCell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(picker_dictionary.allKeys(for: selectedOptions.object(at: indexPath.item))[0])
        picker_dictionary.removeObject(forKey: picker_dictionary.allKeys(for: selectedOptions.object(at: indexPath.item))[0])
        selectedOptions.removeObject(at: indexPath.item)
        collection_view.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 1.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let text:String = (selectedOptions.object(at: indexPath.item) as? String)!
        let height:CGFloat = 34.0
        
        let font:UIFont = UIFont(name: "Helvetica", size: 16.0)!
        
        let attributeText:NSAttributedString = NSAttributedString(string: text, attributes: [NSFontAttributeName:font])
        
        let rect:CGRect = attributeText.boundingRect(with: CGSize(width: CGFloat.greatestFiniteMagnitude, height: height), options: .usesLineFragmentOrigin, context: nil)
        print(CGSize(width: rect.size.width+10, height: 30))
        return CGSize(width: rect.size.width+20, height: 30)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        return UIEdgeInsets(top: 0.0, left: 0.0, bottom: 0.0, right: 0.0)
        
    }
    
}

    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
 


