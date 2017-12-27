//
//  BusRouteManager.swift
//  HualienBus
//
//  Created by robinson on 2017/12/27.
//  Copyright © 2017年 robinson. All rights reserved.
//

import UIKit

class BusRouteManager: NSObject, NSCoding {
    var routeArry: Array<Any>?
    
    func setBusRoutes(response:Any?) {
        if let responseArry:Array<Any> = response as? Array<Any> {
            let tmpRouteArry = NSMutableArray()
            for route in responseArry {
                let routeModel = BusRouteModel()
                routeModel.setBusRouteModel(response: route)
                tmpRouteArry.add(routeModel)
            }
            
            routeArry = tmpRouteArry as? Array<Any>
        }
    }
    
    func encode(with aCoder: NSCoder) {
        if let routes = self.routeArry {
            aCoder.encode(routes, forKey: "Routes")
        }
    }
    
    override init() {
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.routeArry = aDecoder.decodeObject(forKey: "Routes") as? Array<Any>
    }
}
