//
//  JSONConfig.swift
//
//  Created by Mark Morrill on 2017/06/19.
//

import Foundation
import PerfectLib


public class JSONConfig {
    public static let shared = JSONConfig()
    private var json:[String:Any]?

    /**
     Initialze the configuration with json at source. The json is first populated by the json at defaults (if it exists)
     Note that the defaults are not deeply updated. Just the top level of keys are updated
     */
    public func initialize(withJsonAt source:String, defaultsInJsonAt defaults:String? = nil) {
        self.json = nil
        if let defaults = defaults {
            self.read(jsonAt: defaults)
        }
        self.read(jsonAt: source)
    }

    private func read(jsonAt path:String) {
        let file = File(path)
        do {
            try file.open(.read, permissions: .readUser)
            defer {
                file.close()
            }

            let text = try file.readString()
            let dict = try text.jsonDecode() as? [String:Any]
            if nil == self.json {
                self.json = dict
            }
            else if let dict = dict {
                for (k,v) in dict {
                    self.json?[k] = v
                }
            }

        } catch {
            print("JSONConfig error: " + error.localizedDescription)
        }

    }

    public func value(forKey key:String) -> Any? {
        guard let json = self.json else { return nil }
        return json[key]
    }
    
    public func json(forKey key:String) -> [String:Any]? {
        return self.value(forKey: key) as? [String:Any]
    }
    
    // forKey key
    public func string(forKey key:String, otherwise this:String = "") -> String {
        return self.string(from:self.value(forKey: key), otherwise:this)
    }
    
    public func integer(forKey key:String, otherwise this:Int = 0) -> Int {
        return self.integer(from:self.value(forKey: key), otherwise:this)
    }
    
    public func double(forKey key:String, otherwise this:Double = 0) -> Double {
        return self.double(from:self.value(forKey: key), otherwise:this)
    }
    
    public func bool(forKey key:String, otherwise this:Bool = false) -> Bool {
        return self.bool(from:self.value(forKey: key), otherwise:this)
    }
    
    // forKeyPath path, the delim is a period
    // this.is.a.path
    public func value(forKeyPath path:String) -> Any? {
        guard self.json != nil else { return nil }
        var comps = path.components(separatedBy: ".")
        guard comps.count > 0 else { return nil }
        let key = comps.removeLast()
        var json:[String:Any] = self.json!
        for sub in comps {
            guard let next = json[sub] as? [String:Any] else { return nil }
            json = next
        }
        return json[key]
    }
    
    public func string(forKeyPath path:String, otherwise this:String = "") -> String {
        return self.string(from:self.value(forKeyPath: path), otherwise:this)
    }
    
    public func integer(forKeyPath path:String, otherwise this:Int = 0) -> Int {
        return self.integer(from:self.value(forKeyPath: path), otherwise:this)
    }
    
    public func double(forKeyPath path:String, otherwise this:Double = 0) -> Double {
        return self.double(from:self.value(forKeyPath: path), otherwise:this)
    }
    
    public func bool(forKeyPath path:String, otherwise this:Bool = false) -> Bool {
        return self.bool(from:self.value(forKeyPath: path), otherwise:this)
    }
    
    
    
    // handy conversions
    public func string(from value:Any?, otherwise this:String = "") -> String {
        guard let value = value else {
            return this
        }
        
        return (value as? String) ?? this
    }
    
    public func integer(from value:Any?, otherwise this:Int = 0) -> Int {
        guard let value = value else {
            return this
        }
        
        if let value = value as? Int {
            return value
        }
        
        if let value = value as? NSString {
            return value.integerValue
        }
        
        if let value = value as? NSNumber {
            return value.intValue
        }
        
        return this
    }
    
    public func double(from value:Any?, otherwise this:Double = 0) -> Double {
        guard let value = value else {
            return this
        }
        
        if let value = value as? Double {
            return value
        }
        
        if let value = value as? NSString {
            return value.doubleValue
        }
        
        if let value = value as? NSNumber {
            return value.doubleValue
        }
        
        return this
    }
    
    public func bool(from value:Any?, otherwise this:Bool = false) -> Bool {
        guard let value = value else {
            return this
        }
        
        if let value = value as? Bool {
            return value
        }
        
        if let value = value as? NSString {
            return value.boolValue
        }
        
        if let value = value as? NSNumber {
            return value.boolValue
        }
        
        return this
    }
    
}
