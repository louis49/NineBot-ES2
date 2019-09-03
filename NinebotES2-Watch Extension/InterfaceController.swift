//
//  InterfaceController.swift
//  NinebotES2-Watch Extension
//
//  Created by Benoît Desnos on 19/09/2018.
//  Copyright © 2018 Benoît Desnos. All rights reserved.
//

import WatchKit
import Foundation


class InterfaceController: WKInterfaceController {

    let BLUE_COLOR = UIColor(red: 0x4a/0xff, green: 0x69/0xff, blue: 0xbd/0xff, alpha: 1.0)
    let BLUE_ALPHA_COLOR = UIColor(red: 0x4a/0xff, green: 0x69/0xff, blue: 0xbd/0xff, alpha: 0.5)
    
    let ORANGE_COLOR = UIColor(red: 0xf6/0xff, green: 0xb9/0xff, blue: 0x3b/0xff, alpha: 1.0)
    let ORANGE_ALPHA_COLOR = UIColor(red: 0xf6/0xff, green: 0xb9/0xff, blue: 0x3b/0xff, alpha: 0.5)
    
    let RED_COLOR = UIColor(red: 0xe5/0xff, green: 0x50/0xff, blue: 0x39/0xff, alpha: 1.0)
    var RED_ALPHA_COLOR = UIColor(red: 0xe5/0xff, green: 0x50/0xff, blue: 0x39/0xff, alpha: 0.5)
    
    @IBOutlet var groupLock: WKInterfaceGroup!
    @IBOutlet var buttonLock: WKInterfaceButton!
    @IBOutlet var groupRegulator: WKInterfaceGroup!
    @IBOutlet var buttonRegulator: WKInterfaceButton!
    @IBOutlet var groupLightBack: WKInterfaceGroup!
    @IBOutlet var buttonLightBack: WKInterfaceButton!
    
    @IBOutlet var table: WKInterfaceTable!
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        
        _ = sharedTrottinetteManager.locked.asObservable().subscribe(onNext: { (newValue:Bool) in

            if newValue {
                self.setLockON()
            }
            else{
                self.setLockOFF()
            }
        })
        
        _ = sharedTrottinetteManager.regulator.asObservable().subscribe(onNext: { (newValue:Bool) in
            
            if newValue {
                self.setRegulatorON()
            }
            else{
                self.setRegulatorOFF()
            }
        })
        
        _ = sharedTrottinetteManager.light_back.asObservable().subscribe(onNext: { (newValue:Bool) in
            
            if newValue {
                self.setLightBackON()
            }
            else{
                self.setLightBackOFF()
            }
        })
        
        _ = sharedTrottinetteManager.serial_number.asObservable().subscribe(onNext: { (newValue:String) in
            
            if let infoCell:InfoCell = (self.table.rowController(at: 0) as? InfoCell){
                infoCell.labelValue.setText(newValue)
            }
        })
        
        _ = sharedTrottinetteManager.pin_number.asObservable().subscribe(onNext: { (newValue:String) in
            
            if let infoCell:InfoCell = (self.table.rowController(at: 1) as? InfoCell){
                infoCell.labelValue.setText(newValue)
            }
        })
        
        _ = sharedTrottinetteManager.version.asObservable().subscribe(onNext: { (newValue:String) in
            
            if let infoCell:InfoCell = (self.table.rowController(at: 2) as? InfoCell){
                infoCell.labelValue.setText(newValue)
            }
        })
        
        _ = sharedTrottinetteManager.battery.asObservable().subscribe(onNext: { (newValue:UInt) in
            
            if let infoCell:InfoCell = (self.table.rowController(at: 3) as? InfoCell){
                infoCell.labelValue.setText(String(newValue) + " %")
            }
        })
        
        _ = sharedTrottinetteManager.distance_remain.asObservable().subscribe(onNext: { (newValue:Float) in
            
            if let infoCell:InfoCell = (self.table.rowController(at: 4) as? InfoCell){
                infoCell.labelValue.setText(String(newValue) + " km")
            }
        })
        
        _ = sharedTrottinetteManager.speed_current.asObservable().subscribe(onNext: { (newValue:Float) in
            
            if let infoCell:InfoCell = (self.table.rowController(at: 5) as? InfoCell){
                infoCell.labelValue.setText(String(newValue) + " km/h")
            }
        })
        
        _ = sharedTrottinetteManager.distance_traveled.asObservable().subscribe(onNext: { (newValue:Float) in
            
            if let infoCell:InfoCell = (self.table.rowController(at: 6) as? InfoCell){
                infoCell.labelValue.setText(String(newValue) + " km")
            }
        })
        
        _ = sharedTrottinetteManager.duration_traveled.asObservable().subscribe(onNext: { (newValue:Int) in
            
            if let infoCell:InfoCell = (self.table.rowController(at: 7) as? InfoCell){
                infoCell.labelValue.setText(String(newValue) + " s")
            }
        })
        
        _ = sharedTrottinetteManager.distance_current.asObservable().subscribe(onNext: { (newValue:Float) in
            
            if let infoCell:InfoCell = (self.table.rowController(at: 8) as? InfoCell){
                infoCell.labelValue.setText(String(newValue) + " km")
            }
        })
        
        _ = sharedTrottinetteManager.duration_current.asObservable().subscribe(onNext: { (newValue:Int) in
            
            if let infoCell:InfoCell = (self.table.rowController(at: 9) as? InfoCell){
                infoCell.labelValue.setText(String(newValue) + " s")
            }
        })
        
        _ = sharedTrottinetteManager.temperature.asObservable().subscribe(onNext: { (newValue:Float) in
            
            if let infoCell:InfoCell = (self.table.rowController(at: 10) as? InfoCell){
                infoCell.labelValue.setText(String(newValue) + " °C")
            }
        })
        
        _ = sharedTrottinetteManager.speed_average.asObservable().subscribe(onNext: { (newValue:Float) in
            
            if let infoCell:InfoCell = (self.table.rowController(at: 11) as? InfoCell){
                infoCell.labelValue.setText(String(newValue) + " km/h")
            }
        })
        
        table.setNumberOfRows(20, withRowType: "infoCell")
        
        if let infoCell:InfoCell = (self.table.rowController(at: 0) as? InfoCell){
            infoCell.labelTitle.setText("Serial Number")
            infoCell.labelValue.setText(sharedTrottinetteManager.serial_number.value)
        }
        
        if let infoCell:InfoCell = (self.table.rowController(at: 1) as? InfoCell){
            infoCell.labelTitle.setText("PIN")
            infoCell.labelValue.setText(sharedTrottinetteManager.pin_number.value)
        }
        
        if let infoCell:InfoCell = (self.table.rowController(at: 2) as? InfoCell){
            infoCell.labelTitle.setText("Version")
            infoCell.labelValue.setText(sharedTrottinetteManager.version.value)
        }
        
        if let infoCell:InfoCell = (self.table.rowController(at: 3) as? InfoCell){
            infoCell.labelTitle.setText("Battery")
            infoCell.labelValue.setText(String(sharedTrottinetteManager.battery.value) + " %")
        }
        
        if let infoCell:InfoCell = (self.table.rowController(at: 4) as? InfoCell){
            infoCell.labelTitle.setText("Autonomy")
            infoCell.labelValue.setText(String(sharedTrottinetteManager.distance_remain.value) + " km")
        }
        
        if let infoCell:InfoCell = (self.table.rowController(at: 5) as? InfoCell){
            infoCell.labelTitle.setText("Speed Current")
            infoCell.labelValue.setText(String(sharedTrottinetteManager.speed_current.value) + " km/h")
        }
        
        if let infoCell:InfoCell = (self.table.rowController(at: 6) as? InfoCell){
            infoCell.labelTitle.setText("Distance Traveled")
            infoCell.labelValue.setText(String(sharedTrottinetteManager.distance_traveled.value) + " km")
        }
        
        if let infoCell:InfoCell = (self.table.rowController(at: 7) as? InfoCell){
            infoCell.labelTitle.setText("Time Traveled")
            infoCell.labelValue.setText(String(sharedTrottinetteManager.duration_traveled.value) + " s")
        }
        
        if let infoCell:InfoCell = (self.table.rowController(at: 8) as? InfoCell){
            infoCell.labelTitle.setText("Distance Current")
            infoCell.labelValue.setText(String(sharedTrottinetteManager.distance_traveled.value) + " km")
        }
        
        if let infoCell:InfoCell = (self.table.rowController(at: 9) as? InfoCell){
            infoCell.labelTitle.setText("Time Current")
            infoCell.labelValue.setText(String(sharedTrottinetteManager.duration_current.value) + " s")
        }
        
        if let infoCell:InfoCell = (self.table.rowController(at: 10) as? InfoCell){
            infoCell.labelTitle.setText("Temperature")
            infoCell.labelValue.setText(String(sharedTrottinetteManager.temperature.value) + " °C")
        }
        
        if let infoCell:InfoCell = (self.table.rowController(at: 11) as? InfoCell){
            infoCell.labelTitle.setText("Speed Average")
            infoCell.labelValue.setText(String(sharedTrottinetteManager.speed_average.value) + " km/h")
        }
        
    }
    
    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        
        super.willActivate()
    }
    
    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }

    @IBAction func tapLock() {
        sharedTrottinetteManager.setLocked(value: !sharedTrottinetteManager.locked.value)
    }
    
    @IBAction func tapRegulator() {
        sharedTrottinetteManager.setRegulator(value: !sharedTrottinetteManager.regulator.value)
    }
    
    @IBAction func tapLightBack() {
        sharedTrottinetteManager.setLightBack(value:!sharedTrottinetteManager.light_back.value)
    }
    
    func setLockON(){
        
        groupLock.setBackgroundColor(ORANGE_COLOR)
        
        let image:UIImage? = UIImage(named: "icons8-lock-500")?.withRenderingMode(UIImage.RenderingMode.alwaysTemplate)
        
        buttonLock.setBackgroundColor(UIColor.white)
        buttonLock.setBackgroundImage(image)
    }
    
    func setLockOFF(){
        
        groupLock.setBackgroundColor(UIColor.lightGray)
        
        let image:UIImage? = UIImage(named: "icons8-padlock-500")?.withRenderingMode(UIImage.RenderingMode.alwaysTemplate)
        
        buttonLock.setBackgroundColor(UIColor.white)
        buttonLock.setBackgroundImage(image)

    }
    
    
    
    func setRegulatorON(){
        
        groupRegulator.setBackgroundColor(BLUE_COLOR)
        
        let image:UIImage? = UIImage(named: "icons8-speed-500-B")?.withRenderingMode(UIImage.RenderingMode.alwaysTemplate)
        
        buttonRegulator.setBackgroundColor(UIColor.white)
        buttonRegulator.setBackgroundImage(image)
    }
    
    
    func setRegulatorOFF(){
        
        groupRegulator.setBackgroundColor(UIColor.lightGray)
        
        let image:UIImage? = UIImage(named: "icons8-speed-500-A")?.withRenderingMode(UIImage.RenderingMode.alwaysTemplate)
        
        buttonRegulator.setBackgroundColor(UIColor.white)
        buttonRegulator.setBackgroundImage(image)

    }
    
    func setLightBackON(){
        
        groupLightBack.setBackgroundColor(RED_COLOR)
        
        let image:UIImage? = UIImage(named: "icons8-luminaria-led-filled-500-A")?.withRenderingMode(UIImage.RenderingMode.alwaysTemplate)
        
        buttonLightBack.setBackgroundColor(UIColor.white)
        buttonLightBack.setBackgroundImage(image)

    }
    
    func setLightBackOFF(){
        
        groupLightBack.setBackgroundColor(UIColor.lightGray)
        
        let image:UIImage? = UIImage(named: "icons8-luminaria-led-filled-500-B")?.withRenderingMode(UIImage.RenderingMode.alwaysTemplate)
        
        buttonLightBack.setBackgroundColor(UIColor.white)
        buttonLightBack.setBackgroundImage(image)
        
    }
    
    
}
