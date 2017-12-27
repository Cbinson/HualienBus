//
//  SubsRouteModel.swift
//  HualienBus
//
//  Created by robinson on 2017/12/25.
//  Copyright © 2017年 robinson. All rights reserved.
//

import UIKit

class SubsRouteModel: NSObject, NSCoding {
    var SubRouteUID: String?
    var SubRouteID: String?
    var OperatorIDs: Array<Any>?
    var SubRouteName: RouteNameModel?
    var Headsign: String?
    var Direction: Int?
    
    func setSubsRoute(response:Any?) {
        if let responseDic = response as? Dictionary<String, Any> {
            SubRouteUID = responseDic["SubRouteUID"] as? String
            SubRouteID = responseDic["SubRouteID"] as? String
            OperatorIDs = responseDic["OperatorIDs"] as? Array<Any>
            
            let subRouteNameModel = RouteNameModel()
            subRouteNameModel.setRouteNameModel(response: responseDic["SubRouteName"])
            SubRouteName = subRouteNameModel
            
            Headsign = responseDic["Headsign"] as? String
            Direction = responseDic["Direction"] as? Int
        }
    }
    
    override init() {
        
    }
    
    func encode(with aCoder: NSCoder) {
        if let subRouteUID = self.SubRouteUID {
            aCoder.encode(subRouteUID, forKey: "SubRouteUID")
        }
        
        if let subRouteID = self.SubRouteID {
            aCoder.encode(subRouteID, forKey: "SubRouteID")
        }
        
        if let operatorIDs = self.OperatorIDs {
            aCoder.encode(operatorIDs, forKey: "OperatorIDs")
        }
        
        if let subRouteName = self.SubRouteName {
            aCoder.encode(subRouteName, forKey: "SubRouteName")
        }
        
        if let headsign = self.Headsign {
            aCoder.encode(headsign, forKey: "Headsign")
        }
        
        if let direction = self.Direction {
            aCoder.encode(direction, forKey: "Direction")
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.SubRouteUID = aDecoder.decodeObject(forKey: "SubRouteUID") as? String
        self.SubRouteID = aDecoder.decodeObject(forKey: "SubRouteID") as? String
        self.OperatorIDs = aDecoder.decodeObject(forKey: "OperatorIDs") as? Array<Any>
        self.SubRouteName = aDecoder.decodeObject(forKey: "SubRouteName") as? RouteNameModel
        self.Headsign = aDecoder.decodeObject(forKey: "Headsign") as? String
        self.Direction = aDecoder.decodeObject(forKey: "Direction") as? Int
    }
}
