//
//  RouteNameModel.swift
//  HualienBus
//
//  Created by robinson on 2017/12/25.
//  Copyright © 2017年 robinson. All rights reserved.
//

import UIKit

class RouteNameModel: NSObject, NSCoding {
    var Zh_tw: String?
    var En: String?
    
    
    func setRouteNameModel(response:Any?) {
        if let responeDic = response as? Dictionary<String, Any> {
            Zh_tw = responeDic["Zh_tw"] as? String
            En = responeDic["En"] as? String
        }
    }
    
    override init() {
        
    }
    
    func encode(with aCoder: NSCoder) {
        if let zhTw = self.Zh_tw {
            aCoder.encode(zhTw, forKey: "Zh_tw")
        }
        
        if let en = self.En {
            aCoder.encode(en, forKey: "En")
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.Zh_tw = aDecoder.decodeObject(forKey: "Zh_tw") as? String
        self.En = aDecoder.decodeObject(forKey: "En") as? String
    }
}
