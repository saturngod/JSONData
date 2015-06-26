//
//  JSONData.swift
//
//
//  Created by Htain Lin Shwe on 26/6/15.
//  Copyright (c) 2015 2c2p. All rights reserved.
//

import Foundation

class JSONData : Printable {
  
  var jsonObject:AnyObject?
  var sep:String = "."
  
  var description: String {
    return "\(jsonObject)"
  }
  
  
  init(_ obj:AnyObject?) {
    
    jsonObject = obj
    self.sep = "."
    
  }
  
  init(_ obj:AnyObject?,separator:String) {
    jsonObject = obj
    self.sep = separator
  }
  
  
  
  
  func get(query:String) -> AnyObject? {
    
    var queryArr = query.componentsSeparatedByString(self.sep)
    
    if(queryArr.count == 0) {
      
      return nil
      
    }
    
    var lastObj:AnyObject? = nil
    
    if(isNSDictionary(jsonObject)) {
      lastObj = jsonObject?.objectForKey(queryArr[0])
    }
    else if(isNSArray(jsonObject)) {
      var index:Int = queryArr[0].toInt()!
      lastObj = jsonObject?.objectAtIndex(index)
    }
    
    
    queryArr.removeAtIndex(0)
    
    
    for name in queryArr {
      if let match = name.rangeOfString("^[0-9]+$", options: .RegularExpressionSearch) {
        var index:Int = name.toInt()!
        if(isNSArray(lastObj)) {
          lastObj = lastObj?.objectAtIndex(index)
        }
        else if(isNSDictionary(lastObj)) {
          lastObj = lastObj?.objectForKey(name)
        }
        else {
          lastObj = nil
        }
      }
      else {
        if(isNSDictionary(lastObj)) {
          lastObj = lastObj?.objectForKey(name)
        }
        else {
          lastObj = nil
        }
      }
    }
    
    return lastObj
    
    
  }
  
  func isNSArray(obj:AnyObject?) -> Bool {
    return isObject(obj,kindOf: NSArray.self)
  }
  
  func isNSDictionary(obj:AnyObject?) -> Bool {
    return isObject(obj,kindOf: NSDictionary.self)
  }
  
  func isObject(from:AnyObject?,kindOf:AnyClass) -> Bool {
    if let obj: AnyObject = from {
      if(obj.isKindOfClass(kindOf)) {
        return true
      }
    }
    return false
  }
  
}