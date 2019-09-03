//
//  ViewController.swift
//  NinebotES2-OSX
//
//  Created by Benoît Desnos on 26/09/2018.
//  Copyright © 2018 Benoît Desnos. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        sharedBleManager.start()
        
        // Do any additional setup after loading the view.
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }

    @IBAction func clicTest(_ sender: Any) {
        
        let device=BLEMessage.DEVICE.battery
        let type=BLEMessage.TYPE.read
        
        sharedTrottinetteManager.start()
        
        //sharedBleManager.addMessage(message: BLEMessage(type: type, register: 0x39, data: [4], to: device))
        
        
        
        
        //let data:[UInt8]=[2]
        /*
        for register:UInt8 in 0x00...0xFF{
            let message = BLEMessage(type: type, register: register, data: data, to: device)
            
            sharedBleManager.addMessage(message: message)
        }
         */
        
        /*
        let increment:UInt8 = 5
        for register:UInt8 in stride(from:128, to:(0xc9-increment), by:Int(increment)){
            print(String(register) + " " + String(increment))
            sharedBleManager.addMessage(message: BLEMessage(type: type, register: register, data: [increment*2], to: device))
        }
        */
        
        // 2 messages dans ces "logs":
        //5A A5 01 20 22 01 30 0C 7F FF
        //5A A5 01 3E 22 01 80 32 EB FE
        
        /*
        let mess1:BLEMessage = BLEMessage(payload:[0x5A,0xA5,0x01,0x3E,0x22,0x01,0x30,0x0C,0x7F,0xFF]) // La trotinette //0x20
        let mess2:BLEMessage = BLEMessage(payload:[0x5A,0xA5,0x01,0x3E,0x22,0x01,0x80,0x32,0xEB,0xFE]) // => Moi
        
        print(mess1.description())
        print(mess2.description())
        
        
        sharedBleManager.addMessage(message: mess1)
        sharedBleManager.addMessage(message: mess2)
        */
        /*
        for index:Int in 0...100{
            sharedBleManager.addMessage(message: BLEMessage(type: type, register: UInt8(128), data: [50], to: device))
        }
         */
 
        
        /*
        var register:UInt8 = 128
        
        print(String(register) + " " + String(increment))
        sharedBleManager.addMessage(message: BLEMessage(type: type, register: register, data: [increment], to: device))
        
        register = register + increment
        increment = 10
        print(String(register) + " " + String(increment))
        sharedBleManager.addMessage(message: BLEMessage(type: type, register: register, data: [increment], to: device))
        
        register = register + increment
        increment = 10
        print(String(register) + " " + String(increment))
        sharedBleManager.addMessage(message: BLEMessage(type: type, register: register, data: [increment], to: device))
        
        register = register + increment
        increment = 10
        print(String(register) + " " + String(increment))
        sharedBleManager.addMessage(message: BLEMessage(type: type, register: register, data: [increment], to: device))
        
        register = register + increment
        increment = 10
        print(String(register) + " " + String(increment))
        sharedBleManager.addMessage(message: BLEMessage(type: type, register: register, data: [increment], to: device))
        */
        
    }
    

}

