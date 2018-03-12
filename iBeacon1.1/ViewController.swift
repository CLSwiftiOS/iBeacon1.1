 import UIKit
 import CoreLocation
 import CoreBluetooth
 
 class ViewController: UIViewController, CLLocationManagerDelegate, CBCentralManagerDelegate {
    
    var manager: CBCentralManager!
    let locationManager = CLLocationManager()
    let region = CLBeaconRegion(proximityUUID: UUID(uuidString: "f7826da6-4fa2-4e98-8024-bc5b71e0893e")!, identifier: "WEB-EDV")
    var vAktuelleZone : Int! = 0
    var vFontSize: CGFloat = 0.0
    let ZonenNummer = [
        42263: 1,
        22438: 2,
        24984: 3,
        16713: 4,
        ]
    
    @IBOutlet weak var btnZone1: UIButton!
    @IBOutlet weak var btnZone2: UIButton!
    @IBOutlet weak var btnZone3: UIButton!
    @IBOutlet weak var btnZone4: UIButton!
    @IBOutlet weak var ImageZone1: UIImageView!
    @IBOutlet weak var ImageZone2: UIImageView!
    @IBOutlet weak var ImageZone3: UIImageView!
    @IBOutlet weak var ImageZone4: UIImageView!
    @IBOutlet weak var ImageBackground: UIImageView!
    
    func setTiteSize() {
        for i in 1...4 {
            let vButtonSize = self.view.viewWithTag(i) as? UIButton
            vButtonSize?.setTitle("Zone \(i)", for: .normal)
            vButtonSize?.titleLabel?.font = UIFont.boldSystemFont(ofSize: vFontSize)
        }
    }
    
    func whichDevice () {
        let whichDevice = UIDevice.current.modelName
        switch whichDevice {
        case "iPod Touch 5": vFontSize = 16
        case "iPod Touch 6": vFontSize = 16
        case "iPhone 4": vFontSize = 16
        case "iPhone 4s": vFontSize = 16
        case "iPhone 5": vFontSize = 16
        case "iPhone 5c": vFontSize = 16
        case "iPhone 5s": vFontSize = 16
        case "iPhone 6": vFontSize = 16
        case "iPhone 6 Plus": vFontSize = 20
        case "iPhone 6s": vFontSize = 16
        case "iPhone 6s Plus": vFontSize = 16
        case "iPhone 7": vFontSize = 20
        case "iPhone 7 Plus": vFontSize = 20
        case "iPhone 8": vFontSize = 20
        case "iPhone 8 Plus" : vFontSize = 20
        case "iPhone X": vFontSize = 20
        case "iPhone SE X": vFontSize = 16
        case "iPad 2": vFontSize = 30
        case "iPad 3": vFontSize = 30
        case "iPad 4": vFontSize = 30
        case "iPad Air": vFontSize = 30
        case "iPad Air 2": vFontSize = 30
        case "iPad Mini": vFontSize = 24
        case "iPad Mini 2": vFontSize = 24
        case "iPad Mini 3": vFontSize = 24
        case "iPad Mini 4": vFontSize = 24
        case "iPad Pro": vFontSize = 30
        case "Apple TV": vFontSize = 40
        default:  print(whichDevice)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setAll()
        let deviceTyp = UIDevice.current.modelName
        print(deviceTyp)
        whichDevice()
        setTiteSize()
        manager = CBCentralManager(delegate: self, queue: nil)
        locationManager.delegate = self
        if (CLLocationManager.authorizationStatus() != CLAuthorizationStatus.authorizedWhenInUse) {
            locationManager.requestWhenInUseAuthorization()
        }
        locationManager.startRangingBeacons(in: region)
    }
    
    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        switch central.state {
        case .poweredOff: print("BT is off"); setAll()
        case .poweredOn: print("BT is on")
        case .unsupported: print("BT is not available 1")
        case .unauthorized: print("BT is not available 2")
        case .unknown: print("no BT Device")
        case .resetting: print("BT is resetting")
            //default: print("no BT Device (default)")
        }
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask { //Bildschirm dreht sich nicht mit
        return UIInterfaceOrientationMask.portrait
    }
    override var shouldAutorotate: Bool { //Bildschirm dreht sich nicht mit
        return false
    }
    
    func locationManager(_ manager: CLLocationManager, didRangeBeacons beacons: [CLBeacon], in region: CLBeaconRegion) {
        //print(beacons)
        let knownBeacons = beacons.filter{ $0.proximity == CLProximity.immediate || $0.proximity == CLProximity.near}
        if (knownBeacons.count > 0) {
            
            let iBeacon = knownBeacons[0] as CLBeacon
            let whichZone = iBeacon.minor.intValue
            switch whichZone  {
            case 42263:
                setAllBackgroundWhite()
                ImageZone1.backgroundColor = UIColor.green
            case 22438:
                setAllBackgroundWhite()
                ImageZone2.backgroundColor = UIColor.green
            case 24984:
                setAllBackgroundWhite()
                ImageZone3.backgroundColor = UIColor.green
            case 16713:
                setAllBackgroundWhite()
                ImageZone4.backgroundColor = UIColor.green
            default:
                print("\(iBeacon.minor.intValue) Falscher Beacon")
            }
        }
        
        let ARViewTrue = beacons.filter{ $0.proximity == CLProximity.immediate}
        if ARViewTrue.count > 0 {
            let iBeaconButton = ARViewTrue[0] as CLBeacon
            let whichZone = iBeaconButton.minor.intValue
            vAktuelleZone = self.ZonenNummer[iBeaconButton.minor.intValue]
            
            switch whichZone  {
            case 42263: //XAyt //Zone1
                setAll()
                btnZone1.isUserInteractionEnabled = true
                btnZone1.setImage(#imageLiteral(resourceName: "Info.png"), for: .normal)
                ImageZone1.backgroundColor = UIColor.green
            case 22438:  //jkS1 //Zone2
                setAll()
                btnZone2.isUserInteractionEnabled = true
                btnZone2.setImage(#imageLiteral(resourceName: "Info.png"), for: .normal)
                ImageZone2.backgroundColor = UIColor.green
            case 24984: //Py27 //Zone3
                setAll()
                btnZone3.isUserInteractionEnabled = true
                btnZone3.setImage(#imageLiteral(resourceName: "Info.png"), for: .normal)
                ImageZone3.backgroundColor = UIColor.green
            case 16713: //85vk //Zone4
                setAll()
                btnZone4.isUserInteractionEnabled = true
                btnZone4.setImage(#imageLiteral(resourceName: "Info.png"), for: .normal)
                ImageZone4.backgroundColor = UIColor.green
            default:
                print(whichZone)
            }
        }
    }
    
    func setAll(){
        setAllBackgroundWhite()
        setAllButtonImagesNil()
        setAllButtonsNegative()
    }
    
    func setAllButtonsNegative() {
        for i in 1...4{
            let vMyButton = self.view.viewWithTag(i) as? UIButton
            vMyButton?.isUserInteractionEnabled = false
        }
    }
    
    func setAllButtonImagesNil() {
        for i in 1...4{
            let vMyButton = self.view.viewWithTag(i) as? UIButton
            vMyButton?.setImage(nil, for: .normal)
        }
    }
    
    func setAllBackgroundWhite() {
        for i in 10...13{
            let vMyImageView = self.view.viewWithTag(i) as? UIImageView
            vMyImageView?.backgroundColor = UIColor.white
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let ARObject = segue.destination as? ARViewController {
            let button: UIButton = sender as! UIButton;
            switch button.tag {
            case 1: ARObject.Zone = vAktuelleZone
            case 2: ARObject.Zone = vAktuelleZone
            case 3: ARObject.Zone = vAktuelleZone
            case 4: ARObject.Zone = vAktuelleZone
            default: print("Keine Zonnennummer übergeben an AR")
            }
        }
    }
 }
