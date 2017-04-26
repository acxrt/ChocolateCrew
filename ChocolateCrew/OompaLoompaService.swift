//
//  OompaLoompaService.swift
//  ChocolateCrew
//
//  Created by Aina Cuxart on 26/4/17.
//  Copyright © 2017 Aina Cuxart. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON


class OompaLoompaService: NSObject {
    
    
    class func allOompaLoompa(success:@escaping () -> Void, failure:@escaping (Error) -> Void) {
        do {
            
            Alamofire.request("https://www.mockaroo.com/aaafc040/download?count=10&key=aa8685c0").responseJSON { response in
                if response.result.isSuccess {
                    let resJson = JSON(response.result.value!)
                    var oompaLoompaList : Array<OompaLoopma> = Array()
                    
                    for (_, subJson) in resJson {
//                        let oompaLompa = OompaLoopma(json: subJson)!
//                        oompaLoompaList.append(oompaLoompa)
                        print(subJson)
                    }
                }
                if response.result.isFailure {
                    let error : Error = response.result.error!
                    
                    failure(error)
                }
                
                if let JSON = response.result.value {
                    print("JSON: \(JSON)")
                }
            }
            
        } catch {
            print("error getting xml string: \(error)")
        }
    }
    
}
