 import UIKit
 import CoreLocation
 
 class ViewController: UIViewController, CLLocationManagerDelegate {
    
    let locationManager = CLLocationManager()
    let region = CLBeaconRegion(proximityUUID: UUID(uuidString: "f7826da6-4fa2-4e98-8024-bc5b71e0893e")!, major: 32864, minor: 42263, identifier: "WEB iBeacons")
    //let region = CLBeaconRegion(proximityUUID: UUID(uuidString: "f7826da6-4fa2-4e98-8024-bc5b71e0893e")!, identifier: "Estimotes")
    
    /*let distance = [
        42263: UIColor.red, //(red: 84/255, green: 77/255, blue: 160/255, alpha: 1),
        22438: UIColor.green, //(red: 142/255, green: 212/255, blue: 220/255, alpha: 1),
        24984: UIColor.blue, //(red: 162/255, green: 213/255, blue: 181/255, alpha: 1)
    ]*/
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        locationManager.delegate = self
        if (CLLocationManager.authorizationStatus() != CLAuthorizationStatus.authorizedWhenInUse) {
            locationManager.requestWhenInUseAuthorization()
        }
        locationManager.startRangingBeacons(in: region)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func locationManager(_ manager: CLLocationManager, didRangeBeacons beacons: [CLBeacon], in region: CLBeaconRegion) {
        print(beacons)
        
        guard  let thereIsAiBeacon = beacons.first?.proximity else { print("Couldnt find the beacon"); return }
        
        let backgroundcolor:UIColor = {
            
            switch thereIsAiBeacon {
            case .immediate: return UIColor.red
            case .near: return UIColor.orange
            case .far: return UIColor.yellow
            case .unknown: return UIColor.black
            }
        }()
        
        view.backgroundColor = backgroundcolor
        /*let knownBeacons = beacons.filter{ $0.proximity != CLProximity.unknown }
        if (knownBeacons.count > 0) {
            let closestBeacon = knownBeacons[0] as CLBeacon
            self.view.backgroundColor = self.colors[closestBeacon.minor.intValue]
        }*/
    }
    
 }
