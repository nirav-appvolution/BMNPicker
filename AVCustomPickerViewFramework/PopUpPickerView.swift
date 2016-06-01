import UIKit

@objc
protocol PopUpPickerViewDelegate: UIPickerViewDelegate {
        func pickerDone()
        func pickerCancel()
}

public class PopUpPickerView: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    
    var pickerContainerView : UIView!
    var pickerView: UIPickerView!
    var pickerToolbar: UIToolbar!
    var dataSource : NSMutableArray!
    
    public var toolBarItems : [UIBarButtonItem]!
    
    var delegate: PopUpPickerViewDelegate!
    
    private var selectedRows: [Int]?
    
    //MARK: - Life Cycle Methods
    
    override public func viewDidLoad() {
        
        super.viewDidLoad()
        self.initFunc()
    }
    
    private func initFunc() {
        
        let screenSize = UIScreen.mainScreen().bounds.size
        self.view.backgroundColor = UIColor.clearColor()
        
        pickerToolbar = UIToolbar()
        pickerView = UIPickerView()
        toolBarItems = []
        
        pickerToolbar.translucent = true
        pickerView.showsSelectionIndicator = true
        pickerView.backgroundColor = UIColor.whiteColor()
        
        pickerToolbar.frame = CGRectMake(0, 0, screenSize.width, 44)
        pickerView.frame = CGRectMake(0, 44, screenSize.width, 216)
        
        pickerContainerView = UIView(frame: CGRectMake(0, screenSize.height - 260, screenSize.width, 260))
        
        let space = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.FixedSpace, target: nil, action: nil)
        space.width = 12
        let cancelItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Cancel, target: self, action: Selector("cancelPicker"))
        let flexSpaceItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.FlexibleSpace, target: self, action: nil)
        let doneButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Done, target: self, action: Selector("endPicker"))
        toolBarItems! += [space, cancelItem, flexSpaceItem, doneButtonItem, space]
        
        pickerToolbar.setItems(toolBarItems, animated: false)
        
        pickerView.delegate = self
        pickerView.dataSource = self
        
        self.pickerContainerView.addSubview(pickerToolbar)
        self.pickerContainerView.addSubview(pickerView)
        
        self.view.addSubview(self.pickerContainerView)
    }
    
    //MARK: - Custom Methods
    
    public func showPicker() {
        
    }
    
    func cancelPicker() {
//        restoreSelectedRows()
        selectedRows = nil
        self.delegate?.pickerCancel()
        hidePicker()
    }

    func endPicker() {
        selectedRows = nil
        self.delegate?.pickerDone()
        hidePicker()
    }
    
    private func hidePicker() {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    private func getSelectedRows() -> [Int] {
        var selectedRows = [Int]()
        for i in 0..<pickerView.numberOfComponents {
            selectedRows.append(pickerView.selectedRowInComponent(i))
        }
        return selectedRows
    }
    
    private func getSelectedRowsValue() -> Int {
        var selectedRowsValue = Int()
        selectedRowsValue = pickerView.selectedRowInComponent(0)
        
        return selectedRowsValue
    }
    
    private func restoreSelectedRows() {
        for i in 0..<selectedRows!.count {
            pickerView.selectRow(selectedRows![i], inComponent: i, animated: true)
        }
    }
    
    public func hexStringToUIColor (hex:String) -> UIColor {
        var cString:String = hex.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet() as NSCharacterSet).uppercaseString
        
        if (cString.hasPrefix("#")) {
            cString = cString.substringFromIndex(cString.startIndex.advancedBy(1))
        }
        
        if ((cString.characters.count) != 6) {
            return UIColor.grayColor()
        }
        
        var rgbValue:UInt32 = 0
        NSScanner(string: cString).scanHexInt(&rgbValue)
        
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
    
    //MARK: - UIPicker Delegate/DataSource
    
    public func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    public func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return dataSource.count
    }
    
    public func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return dataSource[row] as? String
    }
    
    public func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        /*if (row == 0) {
        self.view.backgroundColor = UIColor.whiteColor();
        } else if(row == 1) {
        self.view.backgroundColor = UIColor.redColor();
        } else if(row == 2) {
        self.view.backgroundColor =  UIColor.greenColor();
        } else {
        self.view.backgroundColor = UIColor.blueColor();
        }*/
    }
    
}

