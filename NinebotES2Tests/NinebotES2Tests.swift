//
//  NinebotES2Tests.swift
//  NinebotES2Tests
//
//  Created by Benoît Desnos on 17/09/2018.
//  Copyright © 2018 Benoît Desnos. All rights reserved.
//

import XCTest
@testable import NinebotES2

class NinebotES2Tests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func data(size:Int)->[UInt8]{
        
        var data:[UInt8] = []
        if size > 0{
            for _ in 0...size-1{
                data.append(UInt8(arc4random_uniform(255)))
            }
        }
        
        return data
    }
    
    func testInit(){
        
        let message = BLEMessage(type: BLEMessage.TYPE.read, register: 0x1a, data: [0x09], to: BLEMessage.DEVICE.battery)
        
        XCTAssert(message.data()[0].bytes[0] == 0x5a) // Entete 1
        XCTAssert(message.data()[0].bytes[1] == 0xa5) // Entete 2
        XCTAssert(message.data()[0].bytes[2] == 0x01) // Taille
        XCTAssert(message.data()[0].bytes[3] == BLEMessage.DEVICE.me.rawValue) // Sender
        XCTAssert(message.data()[0].bytes[4] == BLEMessage.DEVICE.battery.rawValue) // Receiver
        XCTAssert(message.data()[0].bytes[5] == BLEMessage.TYPE.read.rawValue) // Type
        XCTAssert(message.data()[0].bytes[6] == 0x1a) // Register
        XCTAssert(message.data()[0].bytes[7] == 0x09) // Data
        XCTAssert(message.data()[0].bytes[8] == 122) // Ack1
        XCTAssert(message.data()[0].bytes[9] == 255) // Ack2
        
    }
    
    func testAll(){
        
        for size in 0...255{
            
            let frame_x1:UInt8 = 0x5a
            let frame_x2:UInt8 = 0xa5
            let frame_length:UInt8 = UInt8(size)
            let frame_sender:UInt8 = 0x3e
            let frame_receiver:UInt8 = 0x20
            let frame_type:UInt8 = 0x03
            let frame_register:UInt8 = 0xc8
            let frame_data:[UInt8] = self.data(size: size)
            var payload = [frame_x1, frame_x2, frame_length, frame_sender, frame_receiver, frame_type, frame_register]
            payload.append(contentsOf: frame_data)
            var frame_ack1:UInt8
            var frame_ack2:UInt8
            (frame_ack1,frame_ack2) = BLEMessage.computeAcks(payload:payload)
            payload.append(frame_ack1)
            payload.append(frame_ack2)
            
            let array:[[UInt8]] = cut(data:payload)
            
            var message:BLEMessage!
            for index_array in 0...array.count-1{
                
                if(index_array == 0){
                    message = BLEMessage(payload: array[index_array])
                }
                else{
                    message.append(payload: array[index_array])
                }
                
                if(index_array == array.count-1){
                    XCTAssert(message.complete == true)
                }
                else{
                    XCTAssert(message.complete == false)
                }
            }
        }
    }
    
    func cut(data:[UInt8]) -> [[UInt8]]{
        
        var array:[[UInt8]] = []
        
        let ratio = (data.count / BLEMessage.MAX_SIZE_PAYLOAD) + ((data.count % BLEMessage.MAX_SIZE_PAYLOAD)>0 ? 1 : 0)
        
        for index_array in 0...ratio-1{
            array.append([])
            for index_data in 0...BLEMessage.MAX_SIZE_PAYLOAD-1{
                if(index_array * BLEMessage.MAX_SIZE_PAYLOAD + index_data < data.count){
                    array[index_array].append(data[index_array * BLEMessage.MAX_SIZE_PAYLOAD + index_data])
                }
                
            }
        }
        
        return array
    }
    
    func testVersion(){
        
        let version_part1 = UInt8(36)
        let version_part2 = UInt8(1)
        
        let version = BLE.parseVersion(data:[version_part1, version_part2])
        
        let final = "1.2.4"
        
        XCTAssert(version == final)
    }
    
    func testAck(){
        
        let data:[UInt8] = [0x5a, 0xa5, 0x1e, 0x20, 0x3e, 0x04, 0x10, 0x4e, 0x32, 0x47, 0x54, 0x4c, 0x31, 0x38, 0x32, 0x37, 0x43, 0x30, 0x34, 0x31]
        let data2:[UInt8] = [0x38, 0x35, 0x33, 0x34, 0x34, 0x37, 0x32, 0x24, 0x01, 0x00, 0x00, 0x00, 0x00, 0x00, 0x08, 0x00, 0x00, 0xc0,0xfa]
        
        let message:BLEMessage = BLEMessage(payload: data)
        
        message.append(payload: data2)
        
        print("")
    }
}
