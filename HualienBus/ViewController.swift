//
//  ViewController.swift
//  HualienBus
//
//  Created by robinson on 2017/12/25.
//  Copyright © 2017年 robinson. All rights reserved.
//

import UIKit
import Foundation
import MBProgressHUD
import Alamofire
//import IDZSwiftCommonCrypto
import CryptoSwift

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var mainTableView: UITableView!
    
    /*
    基礎資料服務(L1)
    APP ID：b17a7d6d5ddf4906baf70feacc5a1d04
    APP Key：d6Ht3-EXTeznj8AWDbTjyro4F5c
    基礎加值服務(L2)
    APP ID：91ec9adfd8694418ab6932d3cba72811
    APP Key：ADzs9o646I7hmqj2HeYpG9hOP2M
     */
    let APP_ID = "b17a7d6d5ddf4906baf70feacc5a1d04"
    let APP_KEY = "d6Ht3-EXTeznj8AWDbTjyro4F5c"
    
    let DATE_KEY = "SYSTEM_DATE"
    let ROUTE_KEY = "BUS_ROUTES"
    
    

//
//    let APP_ID = "91ec9adfd8694418ab6932d3cba72811"
//    let APP_KEY = "ADzs9o646I7hmqj2HeYpG9hOP2M"
    
    /// 市區客運路線
    let busRouteUrl = "http://ptx.transportdata.tw/MOTC/v2/Bus/Route/City/HualienCounty?$format=JSON"
    
    /// 公路客運路線 //filter = OperatorIDs/any(OperatorID: OperatorID eq '46')
    let busInterCityRouteUrl = "http://ptx.transportdata.tw/MOTC/v2/Bus/Route/InterCity?$filter=OperatorIDs%2Fany(OperatorID%3A%20OperatorID%20eq%20%2746%27)&$format=JSON"
    

    private var hualienBusRoutes: NSMutableArray?
    private var busRouteOK: Bool = false
    private var busCityRouteOK: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.hualienBusRoutes = NSMutableArray()
        
        self.registerCell()
        
//        let usd = UserDefaults.standard
//        let curDate: String? = usd.object(forKey: DATE_KEY) as? String
//        if curDate == nil || self.getDateTime() != curDate {
            self.queueHandle()
//        }else{
//            print("route:\(usd.array(forKey: ROUTE_KEY))")
//        }
        
        
    }
    
    private func registerCell() {
        self.mainTableView.register(UINib.init(nibName: "RouteCell", bundle: nil), forCellReuseIdentifier: "RouteCell")
    }
    
    func queueHandle() {
        let group = DispatchGroup()
        let queue = DispatchQueue(label: "HualienBus", qos: DispatchQoS.default, attributes: .concurrent)
        let busRouteItem = DispatchWorkItem {
            self.readHualienBusRoute(routeStr: self.busRouteUrl)
        }
        let busInterCityRouteItem = DispatchWorkItem {
            self.readHualienBusRoute(routeStr: self.busInterCityRouteUrl)
        }
        
        busRouteItem.notify(queue: queue) {
            print("市區客運路線 done\n")
        }
        
        busInterCityRouteItem.notify(queue: queue) {
            print("公路客運路線 done\n")
        }
        
        queue.async(group: group, execute: busRouteItem)
        queue.async(group: group, execute: busInterCityRouteItem)
        
        group.notify(queue: queue) {
            print("all done!!!!\n")
        }
    }
    
    func readHualienBusRoute(routeStr: String) {
        let url = URL(string: routeStr)
        
        //xDate + app_key
        let xDate = self.toXDate()
        
        let signatureXDate = String(format: "x-date: %@", xDate)
        let signatureHMAC = try! HMAC(key: APP_KEY, variant: .sha1).authenticate(signatureXDate.bytes)
        
        let authorization = String(format: "hmac username=\"%@\", algorithm=\"hmac-sha1\", headers=\"x-date\", signature=\"%@\"", APP_ID, signatureHMAC.toBase64()!)
        
        Alamofire.request(url!, method: .get, parameters: nil, encoding: URLEncoding.httpBody, headers: ["Authorization":authorization,"x-date":xDate]).validate().responseJSON { [weak self](response) in
            print("result:\(response.result)")
            switch response.result {
            case .success:
                let routeManager = BusRouteManager()
                routeManager.setBusRoutes(response: response.result.value)
                
                self?.hualienBusRoutes?.addObjects(from: routeManager.routeArry!)
                
                if routeStr == self?.busRouteUrl {
                    self?.busRouteOK = true
                }else if routeStr == self?.busInterCityRouteUrl {
                    self?.busCityRouteOK = true
                }
                
                if (self?.busRouteOK)! && (self?.busCityRouteOK)! {
//                    let usd = UserDefaults.standard
//                    usd.set(self?.getDateTime(), forKey: (self?.DATE_KEY)!)
//                    let routeData = NSKeyedArchiver.archivedData(withRootObject: self?.hualienBusRoutes as Any)
//                    usd.set(self?.hualienBusRoutes, forKey: (self?.ROUTE_KEY)!)
//                    usd.synchronize()
                    
                    self?.mainTableView.reloadData()
                }
                
                break
                
            case .failure:
                print("Bus route fail")
                break
            }
        }
    }
    
    private func toXDate() -> String {
        let date = Date()
        let formater = DateFormatter()
        formater.locale = Locale(identifier: "en_us")
        formater.timeZone = TimeZone(identifier: "GMT")
        formater.dateFormat = "EEE, dd MMM yyyy HH:mm:ss z"
        let xDate = formater.string(from: date)//"Mon, 25 Dec 2017 07:19:06 GMT"
        
        return xDate
    }
    
    private func getDateTime() -> String {
        let date = Date()
        let formater = DateFormatter()
        formater.locale = Locale.current
        formater.timeZone = NSTimeZone.system
        formater.dateFormat = "yyyy-MM-dd"
        let dateTime = formater.string(from: date)
        
        return dateTime
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}


/// table delegate
extension ViewController {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 160.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}


/// table datasource
extension ViewController {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let routeModel = self.hualienBusRoutes![section] as? BusRouteModel {
            return (routeModel.SubRoutes?.count)!
        }
        
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RouteCell", for: indexPath) as! RouteCell
        
        let busRoute:BusRouteModel = self.hualienBusRoutes![indexPath.section] as! BusRouteModel
        let subRoute:SubsRouteModel = busRoute.SubRoutes![indexPath.row] as! SubsRouteModel
        
        //路線ID
        let routeName:RouteNameModel = subRoute.SubRouteName!
        cell.routeId.text = String(format: "%@", routeName.Zh_tw!)
        //路線名稱(起始-終點)
        cell.routeName.text = String(format: "%@", subRoute.Headsign!)
        
        if indexPath.row == 0 {
            
        }else if indexPath.row == 1 {
            
        }
        
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if self.hualienBusRoutes != nil {
            return (self.hualienBusRoutes?.count)!
        }
        return 0
    }
}

