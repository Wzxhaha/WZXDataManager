//
//  Property.swift
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

internal enum SQLType: String {
    case blob = "BLOB"
    
    case bool = "BOOLEAN"
    
    case int  = "INTEGER"
    
    case text = "TEXT"
}

public struct Property {
    public enum `Type` {
        case array
        
        case dictionary
        
        case bool
        
        case int
        
        case string
        
        internal var sql: SQLType {
            switch self {
            case .array: fallthrough
            case .dictionary:
                return .blob
            case .bool:
                return .bool
            case .int:
                return .int
            case .string:
                return .text
            }
        }
    }
    
    public let key: String
    
    public let value: Any?
    
    public let type: Type
}

extension Property {
    internal var sql: String {
        return "\(key) \(type.sql.rawValue)"
    }
}

