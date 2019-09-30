//
//  ZFDBManager.m
//  ZFTool
//
//  Created by fengz on 2019/1/7.
//  Copyright © 2019年 FengZ. All rights reserved.
//

//#import "ZFDBManager.h"
//#import <sqlite3.h>
//#import "ZFCommonTool.h"
//
////首页搜索
//#define SQL_Creat_HomeSearch_Table "create table if not exists HomeSearch(id INTEGER PRIMARY KEY NOT NULL, keyWords TEXT,kindid INTEGER,dateStr TEXT);"
//
////创建商城搜索表
//#define SQL_Creat_MallSearch_Table "create table if not exists MallSearch(id INTEGER PRIMARY KEY NOT NULL, keyWords TEXT,kindid INTEGER,dateStr TEXT);"
////创建寄卖搜索表
//#define SQL_Creat_ConsignmentSearch_Table "create table if not exists ConsignmentSearch(id INTEGER PRIMARY KEY NOT NULL, keyWords TEXT,kindid INTEGER,dateStr TEXT);"
////数据库名称
//#define zf_db_name @"ZFTool.sqlite"
//
//@interface ZFDBManager()
//{
//    sqlite3          *db;
//    dispatch_queue_t dbQueue;
//    NSString         *dbPath;
//    
//}
//
//@end
//
//@implementation ZFDBManager
//
//ZF_SingletonM(ZFDBManager)
//- (instancetype)init{
//    if (self = [super init]) {
//        dbPath = [ZFCommonTool documentsFilePath:zf_db_name];
//        
//        
//    }
//    return self;
//}
//
///**
// 初始化DB
// */
//- (void)initDB{
//    
//    //创建数据库
//    if ([self openDatabase]) {
//        //建表
//        char *errorMsg;
//        //SQL:搜索历史
//        if(sqlite3_exec(db, SQL_Creat_MallSearch_Table, NULL, NULL, &errorMsg)!=SQLITE_OK){
//            NSLog(@"create SQL_Creat_History_Table error:%s",errorMsg);
//        }
//        
//        if (sqlite3_exec(db, SQL_Creat_ConsignmentSearch_Table, NULL, NULL, &errorMsg) != SQLITE_OK) {
//            NSLog(@"create SQL_Creat_Adress_Table error:%s",errorMsg);
//        }
//        if (sqlite3_exec(db, SQL_Creat_HomeSearch_Table, NULL, NULL, &errorMsg) != SQLITE_OK) {
//            NSLog(@"create SQL_Creat_HomeSearch_Table error:%s",errorMsg);
//        }
//        
//        
//        [self closeDatabase];
//        
//        
//    }
//    
//}
//
//
//
///**
// 打开数据库
// */
//- (BOOL)openDatabase
//{
//    
//    //打开数据库 ,并接收打开数据库的返回值（如果没有数据库则该函数会自动创建数据库）
//    if (sqlite3_open(dbPath.UTF8String, &db) == SQLITE_OK) {
//        
//        return true;
//    }
//    else{
//        return false;
//    }
//    
//    
//    
//}
//
///**
// 关闭数据库
// */
//-(BOOL)closeDatabase
//{
//    
//    if (sqlite3_close(db) == SQLITE_OK) {
//        return true;
//    }
//    else
//    {
//        return false;
//    }
//    
//    
//}
//
//@end
