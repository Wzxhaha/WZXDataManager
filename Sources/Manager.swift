//
//  Manager.swift
//  NoDB
//
//  Created by WzxJiang on 17/5/16.
//  Copyright © 2016年 WzxJiang. All rights reserved.
//
//  https://github.com/Wzxhaha/NoDB
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.


import Foundation

public struct Manager<SQLite: SQLiteDBable> {
    
    static func start(tables: [Tableable]?) {
        SQLite.shared.open { _ in
            tables?.forEach {
                SQLite.shared.execute(sql: $0.createSQL, parameters: nil)
            }
        }
    }
    
    static func insert<T: Tableable>(model: T) {
        SQLite.shared.open {
            $0.execute(sql: model.insertSQL, parameters: model.values)
        }
    }
    
    static func fetch<T: Tableable>(model: T) -> [T]? {
        
        var result: [T]?
        
        SQLite.shared.open { db in
            guard let dics = db.query(sql: model.fetchSQL, parameters: model.values) else {
                return
            }
            
            result = dics.map {
                let model = T.init($0)
                
                if let id = db.value(forColumn: "_id") as? Int {
                    model._id = id
                }
                
                return model
            }
        }
        
        return result
    }
    
    static func delete<T: Tableable>(model: T) {
        SQLite.shared.open {
            $0.execute(sql: model.deleteSQL, parameters: model.values)
        }
    }
    
    static func update<T: Tableable>(model: T) {
        guard model._id != nil else {
            assert(true, "this model isn't fetched, so it can't update")
            return
        }
        
        SQLite.shared.open {
            $0.execute(sql: model.updateSQL, parameters: model.values)
        }
    }
}

