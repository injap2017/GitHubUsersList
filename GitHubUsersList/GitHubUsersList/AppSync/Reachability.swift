//
//  Reachability.swift
//  GitHubUsersList
//
//  Created by Edgar Sia on 12/23/20.
//

import Foundation
import Alamofire

protocol ReachabilityObserver: class {
    func reachabilityListener(_ status: NetworkReachabilityManager.NetworkReachabilityStatus)
}

class Reachability: NSObject {
    public static let shared = Reachability()
    
    private let _reachability = NetworkReachabilityManager(host: "www.apple.com")!
    private var _observers:[ReachabilityObserver] = []
    
    // listening Network
    public func startListening() {
        self._reachability.startListening { status in
            for observer in self._observers {
                observer.reachabilityListener(status)
            }
        }
    }
    
    public func stopListening() {
        self._reachability.stopListening()
    }
    
    // add/remove Observers
    public func addObserver(_ object:ReachabilityObserver) {
        let contains = self._observers.contains { observer -> Bool in
            return observer === object
        }
        
        if contains {
            return
        }
        
        self._observers.append(object)
    }
    
    public func removeObserver(_ object:ReachabilityObserver) {
        self._observers = self._observers.filter({ observer -> Bool in
            return observer !== object
        })
    }
    
    // properties
    public var isReachable: Bool {
        return self._reachability.isReachable
    }
}

