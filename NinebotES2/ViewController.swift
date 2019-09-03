//
//  ViewController.swift
//  NinebotES2
//
//  Created by Benoît Desnos on 17/09/2018.
//  Copyright © 2018 Benoît Desnos. All rights reserved.
//

import UIKit

import RxSwift
import RxCocoa

import UICircularProgressRing

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    
    let BLUE_COLOR = UIColor(red: 0x4a/0xff, green: 0x69/0xff, blue: 0xbd/0xff, alpha: 1.0)
    let BLUE_ALPHA_COLOR = UIColor(red: 0x4a/0xff, green: 0x69/0xff, blue: 0xbd/0xff, alpha: 0.5)
    
    let ORANGE_COLOR = UIColor(red: 0xf6/0xff, green: 0xb9/0xff, blue: 0x3b/0xff, alpha: 1.0)
    let ORANGE_ALPHA_COLOR = UIColor(red: 0xf6/0xff, green: 0xb9/0xff, blue: 0x3b/0xff, alpha: 0.5)
    
    let RED_COLOR = UIColor(red: 0xe5/0xff, green: 0x50/0xff, blue: 0x39/0xff, alpha: 1.0)
    let RED_ALPHA_COLOR = UIColor(red: 0xe5/0xff, green: 0x50/0xff, blue: 0x39/0xff, alpha: 0.5)
    
    let GREEN_COLOR = UIColor(red: 0x78/0xff, green: 0xe0/0xff, blue: 0x8f/0xff, alpha: 1.0) //#78e08f
    let GREEN_ALPHA_COLOR = UIColor(red: 0x78/0xff, green: 0xe0/0xff, blue: 0x8f/0xff, alpha: 0.7)
    
    @IBOutlet weak var tableView: UITableView!

    //MARK: UIViewController
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder:aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        _ = sharedTrottinetteManager.locked.asObservable().subscribe(onNext: { (newValue:Bool) in
            let cell = self.tableView.cellForRow(at:IndexPath(row: 0, section: 0))
            
            if(cell != nil && newValue){
                self.setLockON(button:(cell as! UITableViewCellButtons).buttonLock!)
            }
            else if cell != nil{
                self.setLockOFF(button:(cell as! UITableViewCellButtons).buttonLock!)
            }
        })
        
        _ = sharedTrottinetteManager.regulator.asObservable().subscribe(onNext: { (newValue:Bool) in
            let cell = self.tableView.cellForRow(at:IndexPath(row: 0, section: 0))
            
            if(cell != nil && newValue){
                self.setRegulatorON(button:(cell as! UITableViewCellButtons).buttonRegulator!)
            }
            else if cell != nil{
                self.setRegulatorOFF(button:(cell as! UITableViewCellButtons).buttonRegulator!)
            }
        })
        
        _ = sharedTrottinetteManager.light_back.asObservable().subscribe(onNext: { (newValue:Bool) in
            let cell = self.tableView.cellForRow(at:IndexPath(row: 0, section: 0))
            
            if(cell != nil && newValue){
                self.setLightBackON(button:(cell as! UITableViewCellButtons).buttonLightBack!)
            }
            else if cell != nil{
                self.setLightBackOFF(button:(cell as! UITableViewCellButtons).buttonLightBack!)
            }
        })
        
        _ = sharedTrottinetteManager.brake_level.asObservable().subscribe(onNext: { (newValue:Trottinette.BRAKE_LEVEL) in
            let cell = self.tableView.cellForRow(at:IndexPath(row: 1, section: 0))
            
            if(cell != nil && newValue == Trottinette.BRAKE_LEVEL.none){
                self.setBrakeLevelNone(button:(cell as! UITableViewCellTwoButtons).buttonBrake!)
            }
            else if(cell != nil && newValue == Trottinette.BRAKE_LEVEL.limited){
                self.setBrakeLevelLimited(button:(cell as! UITableViewCellTwoButtons).buttonBrake!)
            }
            else if(cell != nil && newValue == Trottinette.BRAKE_LEVEL.full){
                self.setBrakeLevelFull(button:(cell as! UITableViewCellTwoButtons).buttonBrake!)
            }
        })
        
        _ = sharedTrottinetteManager.speed_mode.asObservable().subscribe(onNext: { (newValue:Trottinette.SPEED_MODE) in
            let cell = self.tableView.cellForRow(at:IndexPath(row: 1, section: 0))
            
            if(cell != nil && newValue == Trottinette.SPEED_MODE.limited){
                self.setSpeedModeLimited(button:(cell as! UITableViewCellTwoButtons).buttonSpeed!)
            }
            else if(cell != nil && newValue == Trottinette.SPEED_MODE.economy){
                self.setSpeedModeEconomy(button:(cell as! UITableViewCellTwoButtons).buttonSpeed!)
            }
            else if(cell != nil && newValue == Trottinette.SPEED_MODE.full){
                self.setSpeedModeFull(button:(cell as! UITableViewCellTwoButtons).buttonSpeed!)
            }
        })
        
        
        
        
        
        _ = sharedTrottinetteManager.serial_number.asObservable().subscribe(onNext: { (newValue:String) in
            let cell = self.tableView.cellForRow(at:IndexPath(row: 2, section: 0))
            
            if(cell != nil){
                (cell as! UITableViewCellInfo).labelValue.text = newValue
            }
            
        })
        
        _ = sharedTrottinetteManager.pin_number.asObservable().subscribe(onNext: { (newValue:String) in
            let cell = self.tableView.cellForRow(at:IndexPath(row: 3, section: 0))
            
            if(cell != nil){
                (cell as! UITableViewCellInfo).labelValue.text = newValue
            }
            
        })
        
        _ = sharedTrottinetteManager.version.asObservable().subscribe(onNext: { (newValue:String) in
            let cell = self.tableView.cellForRow(at:IndexPath(row: 4, section: 0))
            
            if(cell != nil){
                (cell as! UITableViewCellInfo).labelValue.text = newValue
            }
            
        })
        
        _ = sharedTrottinetteManager.battery.asObservable().subscribe(onNext: { (newValue:UInt) in
            let cell = self.tableView.cellForRow(at:IndexPath(row: 5, section: 0))
            
            if(cell != nil){
                (cell as! UITableViewCellInfo).labelValue.text = String(newValue) + " %"
            }
            
        })
        
        _ = sharedTrottinetteManager.distance_remain.asObservable().subscribe(onNext: { (newValue:Float) in
            let cell = self.tableView.cellForRow(at:IndexPath(row: 6, section: 0))
            
            if(cell != nil){
                (cell as! UITableViewCellInfo).labelValue.text = String(newValue) + " km"
            }
            
        })
        
        _ = sharedTrottinetteManager.speed_current.asObservable().subscribe(onNext: { (newValue:Float) in
            let cell = self.tableView.cellForRow(at:IndexPath(row: 7, section: 0))
            
            if(cell != nil){
                (cell as! UITableViewCellInfo).labelValue.text = String(newValue) + " km/h"
            }
            
        })
        
        _ = sharedTrottinetteManager.distance_traveled.asObservable().subscribe(onNext: { (newValue:Float) in
            let cell = self.tableView.cellForRow(at:IndexPath(row: 8, section: 0))
            
            if(cell != nil){
                (cell as! UITableViewCellInfo).labelValue.text = String(newValue) + " km"
            }
            
        })
        
        _ = sharedTrottinetteManager.duration_traveled.asObservable().subscribe(onNext: { (newValue:Int) in
            let cell = self.tableView.cellForRow(at:IndexPath(row: 9, section: 0))
            
            if(cell != nil){
                (cell as! UITableViewCellInfo).labelValue.text = String(newValue) + " s"
            }
            
        })
        
        _ = sharedTrottinetteManager.distance_current.asObservable().subscribe(onNext: { (newValue:Float) in
            let cell = self.tableView.cellForRow(at:IndexPath(row: 10, section: 0))
            
            if(cell != nil){
                (cell as! UITableViewCellInfo).labelValue.text = String(newValue) + " km"
            }
            
        })
        
        _ = sharedTrottinetteManager.duration_current.asObservable().subscribe(onNext: { (newValue:Int) in
            let cell = self.tableView.cellForRow(at:IndexPath(row: 11, section: 0))
            
            if(cell != nil){
                (cell as! UITableViewCellInfo).labelValue.text = String(newValue) + " s"
            }
            
        })
        
        _ = sharedTrottinetteManager.temperature.asObservable().subscribe(onNext: { (newValue:Float) in
            let cell = self.tableView.cellForRow(at:IndexPath(row: 12, section: 0))
            
            if(cell != nil){
                (cell as! UITableViewCellInfo).labelValue.text = String(newValue) + " °C"
            }
            
        })
        
        _ = sharedTrottinetteManager.speed_average.asObservable().subscribe(onNext: { (newValue:Float) in
            let cell = self.tableView.cellForRow(at:IndexPath(row: 13, section: 0))
            
            if(cell != nil){
                (cell as! UITableViewCellInfo).labelValue.text = String(newValue) + " km/h"
            }
            
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    //MARK: UITableViewDelegate
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        if(indexPath.section == 0 && indexPath.row == 0){
            return CGFloat(100)
        }
        else if(indexPath.section == 0 && indexPath.row == 1){
            return CGFloat(100)
        }
        else if(indexPath.section == 1 && indexPath.row == 0){
            return CGFloat(100)
        }
        else{
            return CGFloat(44)
        }
        
    }
    
    //MARK: UITableViewDataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        
        switch section{
            case 0 :
                return 20
            case 1 :
                return 1
            default:
                return 0
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        
        if(indexPath.section == 0){
            
            if(indexPath.row == 0){
                
                let cell:UITableViewCellButtons = tableView.dequeueReusableCell(withIdentifier: "buttonsCell", for: indexPath) as! UITableViewCellButtons
                
                if(sharedTrottinetteManager.locked.value){
                    setLockON(button:cell.buttonLock)
                }
                else{
                    setLockOFF(button:cell.buttonLock)
                }
                
                if(sharedTrottinetteManager.regulator.value){
                    setRegulatorON(button:cell.buttonRegulator)
                }
                else{
                    setRegulatorOFF(button:cell.buttonRegulator)
                }
                
                if(sharedTrottinetteManager.light_back.value){
                    setLightBackON(button:cell.buttonLightBack)
                }
                else{
                    setLightBackOFF(button:cell.buttonLightBack)
                }
                
                return cell
                
            }
            else if(indexPath.row == 1){
                
                let cell:UITableViewCellTwoButtons = tableView.dequeueReusableCell(withIdentifier: "2buttonsCell", for: indexPath) as! UITableViewCellTwoButtons
        
                if(sharedTrottinetteManager.brake_level.value == Trottinette.BRAKE_LEVEL.none){
                    self.setBrakeLevelNone(button:cell.buttonBrake!)
                }
                else if(sharedTrottinetteManager.brake_level.value == Trottinette.BRAKE_LEVEL.limited){
                    self.setBrakeLevelLimited(button:cell.buttonBrake!)
                }
                else if(sharedTrottinetteManager.brake_level.value == Trottinette.BRAKE_LEVEL.limited){
                    self.setBrakeLevelFull(button:cell.buttonBrake!)
                }
                
                if(sharedTrottinetteManager.speed_mode.value == Trottinette.SPEED_MODE.limited){
                    self.setSpeedModeLimited(button:cell.buttonSpeed!)
                }
                else if(sharedTrottinetteManager.speed_mode.value == Trottinette.SPEED_MODE.economy){
                    self.setSpeedModeEconomy(button:cell.buttonSpeed!)
                }
                else if(sharedTrottinetteManager.speed_mode.value == Trottinette.SPEED_MODE.full){
                    self.setSpeedModeFull(button:cell.buttonSpeed!)
                }
                
                return cell
                
            }
            else if(indexPath.row < 20){
                let cell:UITableViewCellInfo = tableView.dequeueReusableCell(withIdentifier: "infoCell", for: indexPath) as! UITableViewCellInfo
                
                switch indexPath.row{
                case 2 :
                    cell.labelTitle.text = "Serial Number"
                    cell.labelValue.text = sharedTrottinetteManager.serial_number.value
                case 3 :
                    cell.labelTitle.text = "Pin Number"
                    cell.labelValue.text = sharedTrottinetteManager.pin_number.value
                case 4 :
                    cell.labelTitle.text = "Version"
                    cell.labelValue.text = sharedTrottinetteManager.version.value
                case 5 :
                    cell.labelTitle.text = "Battery"
                    cell.labelValue.text = String(sharedTrottinetteManager.battery.value) + " %"
                case 6 :
                    cell.labelTitle.text = "Autonomy"
                    cell.labelValue.text = String(sharedTrottinetteManager.distance_remain.value) + " km"
                case 7 :
                    cell.labelTitle.text = "Current Speed"
                    cell.labelValue.text = String(sharedTrottinetteManager.speed_current.value) + " km/h"
                case 8 :
                    cell.labelTitle.text = "Distance Traveled"
                    cell.labelValue.text = String(sharedTrottinetteManager.distance_traveled.value) + " km"
                case 9 :
                    cell.labelTitle.text = "Duration Traveled"
                    cell.labelValue.text = String(sharedTrottinetteManager.duration_traveled.value) + " s"
                case 10 :
                    cell.labelTitle.text = "Distance Current"
                    cell.labelValue.text = String(sharedTrottinetteManager.distance_current.value) + " km"
                case 11 :
                    cell.labelTitle.text = "Duration Current"
                    cell.labelValue.text = String(sharedTrottinetteManager.duration_current.value) + " s"
                case 12 :
                    cell.labelTitle.text = "Temperature"
                    cell.labelValue.text = String(sharedTrottinetteManager.temperature.value) + " °C"
                case 13 :
                    cell.labelTitle.text = "Speed Average"
                    cell.labelValue.text = String(sharedTrottinetteManager.speed_average.value) + " km/h"
                default:
                    cell.labelTitle.text = "Default"
                }
                
                return cell
            }
            else{
                let cell = tableView.dequeueReusableCell(withIdentifier: "infoCell", for: indexPath)
                
                return cell
            }
            
        }
        else{
            let cell:UITableViewCellLevel = tableView.dequeueReusableCell(withIdentifier: "levelCell", for: indexPath) as! UITableViewCellLevel
            
            switch indexPath.row{
            case 0 :
            
                cell.circularProgressRingLife.value = UICircularProgressRing.ProgressValue(sharedTrottinetteManager.battery_life.value)
                cell.circularProgressRingCharge.value = UICircularProgressRing.ProgressValue(sharedTrottinetteManager.battery.value)
                
            default :
                break
            }
            return cell
        }
    }
    
    public func numberOfSections(in tableView: UITableView) -> Int{
        return 2
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String?{
        
        switch section {
        case 0:
            return "Trotinette"
        case 1:
            return "Batterie"
        default:
            return ""
        }
    }

    //MARK: IBActions
    
    @IBAction func tapLock(_ button: UIButton) {
        sharedTrottinetteManager.setLocked(value: !sharedTrottinetteManager.locked.value)
    }
    
    @IBAction func tapRegulator(_ button: UIButton) {
        sharedTrottinetteManager.setRegulator(value: !sharedTrottinetteManager.regulator.value)
    }
    
    @IBAction func tapLightBack(_ button: UIButton) {
        sharedTrottinetteManager.setLightBack(value:!sharedTrottinetteManager.light_back.value)
    }
    
    @IBAction func tapBrake(_ button: UIButton) {
        
        switch sharedTrottinetteManager.brake_level.value {
        case Trottinette.BRAKE_LEVEL.none:
            sharedTrottinetteManager.setBrakeLevel(value: Trottinette.BRAKE_LEVEL.limited)
        case Trottinette.BRAKE_LEVEL.limited:
            sharedTrottinetteManager.setBrakeLevel(value: Trottinette.BRAKE_LEVEL.full)
        case Trottinette.BRAKE_LEVEL.full:
            sharedTrottinetteManager.setBrakeLevel(value: Trottinette.BRAKE_LEVEL.none)
        }
        
    }
    
    
    @IBAction func tapSpeed(_ sender: UIButton) {
        
        switch sharedTrottinetteManager.speed_mode.value {
        case Trottinette.SPEED_MODE.limited:
            sharedTrottinetteManager.setSpeedMode(value: Trottinette.SPEED_MODE.economy)
        case Trottinette.SPEED_MODE.economy:
            sharedTrottinetteManager.setSpeedMode(value: Trottinette.SPEED_MODE.full)
        case Trottinette.SPEED_MODE.full:
            sharedTrottinetteManager.setSpeedMode(value: Trottinette.SPEED_MODE.limited)
        }
        
    }
    
    
    func setLockON(button:UIButton){
        
        button.backgroundColor = ORANGE_COLOR
        button.layer.cornerRadius = button.bounds.height/2
        button.contentEdgeInsets = UIEdgeInsets(top: 15, left: 15, bottom: 15, right: 15)
        button.tintColor = UIColor.white
        button.setImage(UIImage(named: "icons8-lock-500")!.withRenderingMode(UIImage.RenderingMode.alwaysTemplate), for: UIControl.State.normal)
    }
    
    func setLockOFF(button:UIButton){
        
        button.backgroundColor = ORANGE_ALPHA_COLOR
        button.layer.cornerRadius = button.bounds.height/2
        button.contentEdgeInsets = UIEdgeInsets(top: 15, left: 15, bottom: 15, right: 15)
        button.tintColor = UIColor.white
        button.setImage(UIImage(named: "icons8-padlock-500")!.withRenderingMode(UIImage.RenderingMode.alwaysTemplate), for: UIControl.State.normal)
       
    }
    
    func setRegulatorON(button:UIButton){
        
        button.backgroundColor = BLUE_COLOR
        button.layer.cornerRadius = button.bounds.height/2
        button.contentEdgeInsets = UIEdgeInsets(top: 15, left: 15, bottom: 15, right: 15)
        button.tintColor = UIColor.white
        button.setImage(UIImage(named: "icons8-speed-500-B")!.withRenderingMode(UIImage.RenderingMode.alwaysTemplate), for: UIControl.State.normal)
    }
    
    func setRegulatorOFF(button:UIButton){
        
        button.backgroundColor = BLUE_ALPHA_COLOR
        button.layer.cornerRadius = button.bounds.height/2
        button.contentEdgeInsets = UIEdgeInsets(top: 15, left: 15, bottom: 15, right: 15)
        button.tintColor = UIColor.white
        button.setImage(UIImage(named: "icons8-speed-500-A")!.withRenderingMode(UIImage.RenderingMode.alwaysTemplate), for: UIControl.State.normal)
        
    }
    
    func setLightBackON(button:UIButton){
        
        button.backgroundColor = RED_COLOR
        button.layer.cornerRadius = button.bounds.height/2
        button.contentEdgeInsets = UIEdgeInsets(top: 15, left: 15, bottom: 15, right: 15)
        button.tintColor = UIColor.white
        button.setImage(UIImage(named: "icons8-luminaria-led-filled-500-A")!.withRenderingMode(UIImage.RenderingMode.alwaysTemplate), for: UIControl.State.normal)
    }
    
    func setLightBackOFF(button:UIButton){
        
        button.backgroundColor = RED_ALPHA_COLOR
        button.layer.cornerRadius = button.bounds.height/2
        button.contentEdgeInsets = UIEdgeInsets(top: 15, left: 15, bottom: 15, right: 15)
        button.tintColor = UIColor.white
        button.setImage(UIImage(named: "icons8-luminaria-led-filled-500-B")!.withRenderingMode(UIImage.RenderingMode.alwaysTemplate), for: UIControl.State.normal)
        
    }
    
    func setBrakeLevelNone(button:UIButton){
        
        button.backgroundColor = UIColor.clear
        button.layer.cornerRadius = button.bounds.height/2
        button.layer.borderWidth = 2
        button.layer.borderColor = UIColor.lightGray.cgColor
        button.contentEdgeInsets = UIEdgeInsets(top: 15, left: 15, bottom: 15, right: 15)
        button.tintColor = UIColor.lightGray
        button.setImage(UIImage(named: "icons8-brake-warning-500-A")!.withRenderingMode(UIImage.RenderingMode.alwaysTemplate), for: UIControl.State.normal)
        
    }
    
    func setBrakeLevelLimited(button:UIButton){
        
        button.backgroundColor = UIColor.lightGray
        button.layer.cornerRadius = button.bounds.height/2
        button.layer.borderWidth = 0
        button.contentEdgeInsets = UIEdgeInsets(top: 15, left: 15, bottom: 15, right: 15)
        button.tintColor = UIColor.white
        button.setImage(UIImage(named: "icons8-brake-warning-500-A")!.withRenderingMode(UIImage.RenderingMode.alwaysTemplate), for: UIControl.State.normal)
        
    }
    
    func setBrakeLevelFull(button:UIButton){
        
        button.backgroundColor = GREEN_COLOR
        button.layer.cornerRadius = button.bounds.height/2
        button.layer.borderWidth = 0
        button.contentEdgeInsets = UIEdgeInsets(top: 15, left: 15, bottom: 15, right: 15)
        button.tintColor = UIColor.white
        button.setImage(UIImage(named: "icons8-brake-warning-500-B")!.withRenderingMode(UIImage.RenderingMode.alwaysTemplate), for: UIControl.State.normal)
        
    }
    
    func setSpeedModeLimited(button:UIButton){
        
        button.backgroundColor = UIColor.white
        button.layer.cornerRadius = button.bounds.height/2
        button.layer.borderWidth = 2
        button.layer.borderColor = UIColor.lightGray.cgColor
        button.contentEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        button.tintColor = UIColor.lightGray
        button.setImage(UIImage(named: "icons8-circled-s-500")!.withRenderingMode(UIImage.RenderingMode.alwaysTemplate), for: UIControl.State.normal)
    }
    
    func setSpeedModeEconomy(button:UIButton){
        
        button.backgroundColor = UIColor.lightGray
        button.layer.cornerRadius = button.bounds.height/2
        button.layer.borderWidth = 0
        button.contentEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        button.tintColor = UIColor.white
        button.setImage(UIImage(named: "icons8-circled-s-500")!.withRenderingMode(UIImage.RenderingMode.alwaysTemplate), for: UIControl.State.normal)
    }
    
    func setSpeedModeFull(button:UIButton){
        
        button.backgroundColor = RED_COLOR
        button.layer.cornerRadius = button.bounds.height/2
        button.layer.borderWidth = 0
        button.contentEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        button.tintColor = UIColor.white
        button.setImage(UIImage(named: "icons8-circled-s-500")!.withRenderingMode(UIImage.RenderingMode.alwaysTemplate), for: UIControl.State.normal)
    }
}

