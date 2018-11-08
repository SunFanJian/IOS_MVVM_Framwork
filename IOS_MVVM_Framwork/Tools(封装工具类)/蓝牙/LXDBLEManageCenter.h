//
//  LXDBLEManageCenter.h
//  HK_Sensor
//
//  Created by Experimental Computer on 2018/7/5.
//  Copyright © 2018年 Luxondata. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreBluetooth/CoreBluetooth.h>

//蓝牙状态
typedef enum : NSUInteger {
    BLEStateOpen,
    BLEStateClosed,
    BLEStateUnknow,
    BLEStatUnSupport,
    BLEStateResetting,
    BLEStateUnauthorized,
} BlueToothState;

//设备连接状态
//typedef enum : NSUInteger {
//    peripheralConnectSuccessed,
//    peripheralConnectFailed,
//    peripheralDisconnect,
//} PeripheralConnectState;

@protocol LXDBLEManagerDelegate <NSObject>

@optional
/** 提示蓝牙状态 */
-(void)promptBlueToothState:(BlueToothState)BLEState;

/** 扫描到设备 */
-(void)peripheralFound:(CBPeripheral *)peripheral RSSI:(NSNumber *)RSSI;

/** 扫描结束 */
-(void)manageStopScanDevice;
//连接结果
-(void)peripheralConnectFailed:(CBPeripheral *)peripheral;

-(void)peripherDisconnect:(CBPeripheral *)peripheral;

-(void)peripheralConnectSuccessed:(CBPeripheral *)peripheral;

-(void)peripheralSubscrobeSuccess;

/** 获取外围设备发送的数据 */
-(void)receivePeripheralData:(NSData *)data error:(NSError *)error;

-(void)sendOrderBack:(NSError *)error;

@end

@interface LXDBLEManageCenter : NSObject <CBPeripheralDelegate,CBCentralManagerDelegate>

//代理
@property(nonatomic ,weak)id<LXDBLEManagerDelegate> BLEDelegate;

/** 蓝牙状态 */
@property(nonatomic , assign)BlueToothState blueToothState;

/** 设备连接状态 */
//@property(nonatomic , assign)PeripheralConnectState peripheralConnectState;

/** 服务UUID */
@property(nonatomic , copy)NSString *serviceUUID;

/** 特征值UUID */
@property(nonatomic , copy)NSString *characterUUID;

/** 连接的设备 */
@property(nonatomic , strong)CBPeripheral *activePeripheral;

/** 使用的服务 */
@property(nonatomic , strong)CBService *activeService;

/** 使用的特征 */
@property(nonatomic , strong)CBCharacteristic *activeCharacteristic;

/** 特征描述列表 */
@property(nonatomic , strong)NSArray *characterDescriptors;

/** 单例 */
+(instancetype)shareBLE;

/** 初始化蓝牙管理中心 */
-(void)initBLECenter;

/**
  开始扫描外围设备
  @param timeout 扫描时间
 */
-(void)scanPerial:(int)timeout;

/** 停止扫描外围设备 */
-(void)stopScanPerial;

/** 连接蓝牙设备 */
-(void)connectPeripheral:(CBPeripheral *)peripheral;

/** 断开连接 */
-(void)disconnectPeripheral:(CBPeripheral *)peripheral;

/** 订阅特征通知 */
-(void)startNotify;

/** 停止通知 */
-(void)stopNotify;

/** 发送指令 */
-(void)writeOrder:(NSString *)order;

@end
