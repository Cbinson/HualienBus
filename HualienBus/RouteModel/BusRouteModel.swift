//
//  BusRouteModel.swift
//  HualienBus
//
//  Created by robinson on 2017/12/25.
//  Copyright © 2017年 robinson. All rights reserved.
//

import UIKit

class BusRouteModel: NSObject, NSCoding {
    var RouteUID: String?
    var RouteID: String?
    var HasSubRoutes: Bool?
    var OperatirIDs: Array<Any>?
    var AuthorityID: String?
    var ProviderID: String?
    var SubRoutes: Array<Any>?
    var BusRouteType: Int?
    var RouteName: RouteNameModel?
    var DepartureStopNameZh: String?
    var DepartureStopNameEn: String?
    var DestinationStopNameZh: String?
    var DestinationStopNameEn: String?
    var UpdeateTime: String?
    var versionID: Int?
    
    
    
    
    func setBusRouteModel(response:Any?) {
        if let routeDic = response as? Dictionary<String, Any> {
            RouteUID = routeDic["RouteUID"] as? String
            RouteID = routeDic["RouteID"] as? String
            HasSubRoutes = routeDic["HasSubRoutes"] as? Bool
            OperatirIDs = routeDic["OperatorIDs"] as? Array<Any>
            AuthorityID = routeDic["AuthorityID"] as? String
            ProviderID = routeDic["ProviderID"] as? String
            
            if let subsRoutes = routeDic["SubRoutes"] as? Array<Any> {
                let tmpSubsArry = NSMutableArray()
                for subRoute in subsRoutes {
                    let subRouteModel = SubsRouteModel()
                    subRouteModel.setSubsRoute(response: subRoute)
                    tmpSubsArry.add(subRouteModel)
                }
                
                SubRoutes = tmpSubsArry as? Array<Any>
            }
            
            BusRouteType = routeDic["BusRouteType"] as? Int
            
            let routeNameModel = RouteNameModel()
            routeNameModel.setRouteNameModel(response: routeDic["RouteName"])
            RouteName = routeNameModel
            
            DepartureStopNameZh = routeDic["DepartureStopNameZh"] as? String
            DepartureStopNameEn = routeDic["DepartureStopNameEn"] as? String
            DestinationStopNameZh = routeDic["DestinationStopNameZh"] as? String
            DestinationStopNameEn = routeDic["DestinationStopNameEn"] as? String
            UpdeateTime = routeDic["UpdeateTime"] as? String
            versionID = routeDic["versionID"] as? Int
        }
    }
    
    func encode(with aCoder: NSCoder) {
        if let routeUID = self.RouteUID {
            aCoder.encode(routeUID, forKey: "RouteUID")
        }
        
        if let routeID = self.RouteID {
            aCoder.encode(routeID, forKey: "RouteID")
        }
        
        if let hasSubRoutes = self.HasSubRoutes {
            aCoder.encode(hasSubRoutes, forKey: "HasSubRoutes")
        }
        
        if let operatirIDs = self.OperatirIDs {
            aCoder.encode(operatirIDs, forKey: "OperatirIDs")
        }
        
        if let authorityID = self.AuthorityID {
            aCoder.encode(authorityID, forKey: "AuthorityID")
        }
        
        if let providerID = self.ProviderID {
            aCoder.encode(providerID, forKey: "providerID")
        }
        
        if let subRoutes = self.SubRoutes {
            aCoder.encode(subRoutes, forKey: "SubRoutes")
        }
        
        if let busRouteType = self.BusRouteType {
            aCoder.encode(busRouteType, forKey: "BusRouteType")
        }
        
        if let routeName = self.RouteName {
            aCoder.encode(routeName, forKey: "RouteName")
        }
        
        if let departureStopNameZh = self.DepartureStopNameZh {
            aCoder.encode(departureStopNameZh, forKey: "DepartureStopNameZh")
        }
        
        if let departureStopNameEn = self.DepartureStopNameEn {
            aCoder.encode(departureStopNameEn, forKey: "DepartureStopNameEn")
        }
        
        if let destinationStopNameZh = self.DestinationStopNameZh {
            aCoder.encode(destinationStopNameZh, forKey: "DestinationStopNameZh")
        }
        
        if let destinationStopNameEn = self.DestinationStopNameEn {
            aCoder.encode(destinationStopNameEn, forKey: "DestinationStopNameEn")
        }
        
        if let updeateTime = self.UpdeateTime {
            aCoder.encode(updeateTime, forKey: "UpdeateTime")
        }
        
        if let version = self.versionID {
            aCoder.encode(version, forKey: "versionID")
        }
    }
    
    override init() {
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.RouteUID = aDecoder.decodeObject(forKey: "RouteUID") as? String
        self.RouteID = aDecoder.decodeObject(forKey: "RouteID") as? String
        self.HasSubRoutes = aDecoder.decodeObject(forKey: "HasSubRoutes") as? Bool
        self.OperatirIDs = aDecoder.decodeObject(forKey: "OperatirIDs") as? Array<Any>
        self.AuthorityID = aDecoder.decodeObject(forKey: "AuthorityID") as? String
        self.ProviderID = aDecoder.decodeObject(forKey: "ProviderID") as? String
        self.SubRoutes = aDecoder.decodeObject(forKey: "SubRoutes") as? Array<Any>
        self.BusRouteType = aDecoder.decodeObject(forKey: "BusRouteType") as? Int
        self.RouteName = aDecoder.decodeObject(forKey: "RouteName") as? RouteNameModel
        self.DepartureStopNameZh = aDecoder.decodeObject(forKey: "DepartureStopNameZh") as? String
        self.DepartureStopNameEn = aDecoder.decodeObject(forKey: "DepartureStopNameEn") as? String
        self.DestinationStopNameZh = aDecoder.decodeObject(forKey: "DestinationStopNameZh") as? String
        self.DestinationStopNameEn = aDecoder.decodeObject(forKey: "DestinationStopNameEn") as? String
        self.UpdeateTime = aDecoder.decodeObject(forKey: "UpdeateTime") as? String
        self.versionID = aDecoder.decodeObject(forKey: "versionID") as? Int
    }
}
