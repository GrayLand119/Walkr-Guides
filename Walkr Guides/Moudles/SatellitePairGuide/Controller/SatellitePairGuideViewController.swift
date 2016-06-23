//
//  SatellitePairGuideViewController.swift
//  Walkr Guides
//
//  Created by GrayLand on 16/5/6.
//  Copyright © 2016年 GrayLand. All rights reserved.
//


import Foundation
import UIKit
import SnapKit


let kStar        = "star"
let kSatellite   = "satellite"
let kEffect      = "effect"
let kDescription = "description"


class SatellitePairGuideViewController : UIViewController, UITextFieldDelegate, UITableViewDelegate, UITableViewDataSource
{
    private var label : UILabel?
    private var starEdit : UITextField?
    private var checkBtn : UIButton?
    private var goBackBtn : UIButton?
    private var resultLabel : UILabel?
    private var satelliteData : NSArray?
    private var historyTableView : UITableView?
    private var historyData : NSMutableArray?
    private var haveShowNotice : Bool?
    
    let lightColor = UIColor(red: 0.4, green: 0.8, blue: 1.0, alpha: 1.0)
    let bgColor    = UIColor( red: 0.0706, green: 0.2, blue: 0.2627, alpha: 1.0 )
    
    
    @objc override func viewDidLoad() {
        
        super.viewDidLoad()
        
//        let file = NSData.dataWithContentsOfMappedFile("Pair.rtf")
//        let file = NSData.init(contentsOfFile: "/Users/GrayLand/Desktop/QTWorkSpace/Walkr Guides/Walkr Guides/Moudles/SatellitePairGuide/Pair.rtf")
        historyData    = NSMutableArray()
        haveShowNotice = false
        
        let path :String? = NSBundle.mainBundle().pathForResource("SatelliteInfo", ofType: "txt")
        print("path:" + path!)
        
        var allValue : NSArray = []
        
        do {
            let str = try NSString.init(contentsOfFile: path!, encoding: NSUTF8StringEncoding)
            
            allValue = str.componentsSeparatedByCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet())
            
        } catch { }
    
//        print(allValue)
        
        let satellitePairArr : NSMutableArray = []
        
        for var index = 0; index < allValue.count; index+=4 {
            
            if (index + 3 < allValue.count){
                
                let satellitePairDic : NSDictionary =
                [
                    kStar           : allValue[index].description,
                    kSatellite      : allValue[index + 1].description,
                    kEffect         : allValue[index + 2].description,
                    kDescription    : allValue[index + 3].description
                ]
                satellitePairArr.addObject(satellitePairDic)
            }
        }
        
        if (satellitePairArr.lastObject == nil){
            satellitePairArr.removeLastObject()
        }
        
        satelliteData = satellitePairArr
        
        self.setupViews()
        self.setupLayout()
    }
    
    private func setupViews() {
        
        self.view.backgroundColor = bgColor
        
        label = UILabel()
        label?.textColor = lightColor
        label?.font      = UIFont.systemFontOfSize(20)
        label?.text      = "请输入需要查询的[星球]或[卫星]:"
        
        self.view.addSubview(label!)
        
        
        starEdit = UITextField.init()
        starEdit?.backgroundColor    = UIColor.whiteColor()
        starEdit?.layer.cornerRadius = 15
        starEdit?.delegate           = self
        starEdit?.placeholder        = "例如:查询[微风沙漠],输入[微风]或[沙漠]或[风沙]等等都可以"
        starEdit?.clearButtonMode    = UITextFieldViewMode.Always;
        starEdit?.leftView           = UIView.init(frame: CGRectMake(0, 0, 15, 0))
        starEdit?.leftViewMode       = UITextFieldViewMode.Always;
        self.view.addSubview(starEdit!)
        
        
        checkBtn = UIButton.init()
        checkBtn?.backgroundColor    = lightColor//UIColor ( red: 0.4, green: 1.0, blue: 0.4, alpha: 1.0 )
        checkBtn?.layer.cornerRadius = 20
        checkBtn?.setTitle("查询匹配", forState: UIControlState.Normal)
        checkBtn?.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
        checkBtn?.addTarget(self, action: #selector(SatellitePairGuideViewController.onCheck), forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(checkBtn!)
        
//        goBackBtn = UIButton.init()
//        goBackBtn?.backgroundColor = lightColor
//        goBackBtn?.layer.cornerRadius = 20
//        goBackBtn?.setTitle("回到游戏", forState: UIControlState.Normal)
//        goBackBtn?.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
//        goBackBtn?.addTarget(self, action:Selector("onGoBackToGame"), forControlEvents: UIControlEvents.TouchUpInside)
        
        resultLabel = UILabel()
        resultLabel?.textColor     = UIColor.whiteColor()
        resultLabel?.numberOfLines = 0;
        resultLabel?.textAlignment = NSTextAlignment.Center
        self.view.addSubview(resultLabel!)
        
        
        historyTableView = UITableView.init(frame: CGRectZero, style: UITableViewStyle.Grouped)
        historyTableView?.delegate        = self
        historyTableView?.dataSource      = self
        historyTableView?.backgroundColor = bgColor
        historyTableView?.allowsSelection = false
        historyTableView?.separatorColor  = bgColor
        
        self.view.addSubview(historyTableView!)
    }
    
    private func setupLayout() {
        
        label?.snp_makeConstraints { (make) -> Void in
            make.left.equalTo(20)
            make.top.equalTo(30)
        }
        
        starEdit?.snp_makeConstraints { (make) -> Void in
            make.left.equalTo(20)
            make.top.equalTo((label!.snp_bottom)).offset(10)
            make.width.equalTo(SCREEN_WIDTH - 40)
            make.height.equalTo(30)
        }
        
        checkBtn?.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(starEdit!.snp_bottom).offset(10)
            make.right.equalTo(checkBtn!.superview!).offset(-20)
            make.size.equalTo(CGSizeMake(100, 40))
        }
        
        resultLabel?.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(checkBtn!.snp_bottom).offset(5)
            make.centerX.equalTo(resultLabel!.superview!)
            make.width.equalTo(resultLabel!.superview!).offset(-40)
            make.height.equalTo(45)
        }
        
        historyTableView?.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(resultLabel!.snp_bottom).offset(5)
            make.left.right.bottom.equalTo(historyTableView!.superview!)
        }
    }
    
    func onCheck()
    {
//        starEdit?.resignFirstResponder()
        
        var isFound             = false
        var resultStr : String  = NSString() as String
        var historyStr : String = NSString() as String
        
        for dic in satelliteData!
        {
            if (dic[kStar]!!.description.containsString(starEdit!.text!)){
                
                starEdit!.text = dic[kStar]!!.description
                
                resultStr =
                    "对应卫星 : " + dic[kSatellite]!!.description +
                    "\n效果 : " + dic[kEffect]!!.description +
                    dic[kDescription]!!.description
                
                historyStr = "[" + dic[kStar]!!.description + "]----[" + dic[kSatellite]!!.description + "]"

                isFound = true
                
                break
            }
            else if(dic[kSatellite]!!.description.containsString(starEdit!.text!)){
                
                starEdit!.text = dic[kSatellite]!!.description
                
                resultStr =
                    "对应星球 : " + dic[kStar]!!.description +
                    "\n效果 : " + dic[kEffect]!!.description +
                    dic[kDescription]!!.description
                
                historyStr = "[" + dic[kStar]!!.description + "]----[" + dic[kSatellite]!!.description + "]"
                
                isFound = true
                
                break
            }
        }
        
        if (!isFound){
            resultLabel?.text = "没有找到对应数据"
        }else{
            resultLabel?.text = resultStr
            
            if((historyData?.containsObject(historyStr)) != nil){
                historyData?.removeObject(historyStr)
            }
            
            historyData?.insertObject(historyStr, atIndex: 0)
            historyTableView?.reloadData()
        }
    }
    
    func onGoBackToGame()
    {
        UIApplication.sharedApplication().openURL(NSURL.init(string: "walkrgame://")!)
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        
        if (textField == starEdit!){
            self.onCheck()
        }
        
        return true;
    }
    
    
    func checkTime() -> Bool
    {
        let currentDate   = NSDate()
        let dateFormatter = NSDateFormatter.init()
        
        dateFormatter.dateFormat = "MM-dd"
        
        let dateString       = dateFormatter.stringFromDate(currentDate)
        let result : NSArray = dateString.componentsSeparatedByString("-")
        let month            = result.firstObject?.description
        let day              = result.lastObject?.description
        
        if ((month == "05") && (day == "21")){
            return true
        }else{
            return false
        }
    }
    
    
    func autoShowNoticeVie()
    {
        if (haveShowNotice == true){
            return
        }
        
        if (checkTime()){
            let view = UIAlertView.init(title: "生日快乐?", message: "祝谭阳洋生日快乐?哈哈哈哈哈~~~", delegate: self, cancelButtonTitle: "谢谢,我太感动了(T.T)")

            view.show()
            
            haveShowNotice = true;
        }
    }
    
    override func viewDidAppear(animated: Bool) {
        
        super.viewDidAppear(animated)
        
        self.autoShowNoticeVie()
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (historyData?.count)!
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let identifier = "historyCell"
        var cell = tableView.dequeueReusableCellWithIdentifier(identifier)
        
        if(cell == nil){
            cell = UITableViewCell.init(style: UITableViewCellStyle.Default, reuseIdentifier: identifier)
            cell?.backgroundColor      = bgColor
            cell?.textLabel?.textColor = lightColor
        }
        
        cell?.textLabel?.text = historyData?.objectAtIndex(indexPath.row).description
        
        return cell!
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 25
    }
}


















