//
//  ViewController.swift
//  do-hoang-vu
//
//  Created by Đỗ Hoàng Vũ on 7/6/18.
//  Copyright © 2018 Đỗ Hoàng Vũ. All rights reserved.
//

import UIKit
import GooglePlaces
import GoogleMaps
import Dropper
class ViewController: UIViewController , GMSMapViewDelegate , UICollectionViewDelegate, UICollectionViewDataSource , UICollectionViewDelegateFlowLayout,UISearchBarDelegate, LocateOnTheMap  {
    
    @IBOutlet weak var coverView: UIView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var dropdownBtn: UIButton!
    @IBOutlet weak var my_Collection: UICollectionView!
    @IBOutlet weak var my_map_view: GMSMapView!
    @IBOutlet weak var text_country: UITextField!
    let dropper = Dropper(width: 75, height: 200)
    var _token : String = ""
    var resultsArray = [String]()
    var items = [NameCollectionItem]()
    var locationOneKm = [LocationRdiusOneKm]()
    var locManager = CLLocationManager()
    var currentLocation : CLLocation!
    override func viewDidLoad() {
        
        super.viewDidLoad()
        registerNotification()
        postAction()
        let camera = GMSCameraPosition.camera(withLatitude: -33.86, longitude: 151.20, zoom: 6.0)
        self.my_map_view.camera = camera
        self.addMarker()
        //    my_map_view.settings.myLocationButton = true
        my_map_view.isMyLocationEnabled = true
        
        my_map_view.padding = UIEdgeInsets(top: 0, left: 0, bottom: (UIScreen.main.bounds.height)/35, right: 0)
        
        coverView.isHidden = true
        my_Collection.dataSource = self
        my_Collection.delegate = self
        
        //Looks for single or multiple taps.
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "dismissKeyboard")
        
        //Uncomment the line below if you want the tap not not interfere and cancel other interactions.
        //tap.cancelsTouchesInView = false
        
        view.addGestureRecognizer(tap)
        self.hideKeyboardWhenTappedAround()
        GetLogAngLat()
        
        
    }//
    // buuton Location Current ---------------------------
    @IBAction func gotoLocation(_ sender: UIButton) {
        didTapMyLocationButton(for: my_map_view)
    }
    
    // Put this piece of code anywhere you like
    
    func didTapMyLocationButton(for mapView: GMSMapView) -> Bool {
        guard let lat = my_map_view.myLocation?.coordinate.latitude,
            let lng = my_map_view.myLocation?.coordinate.longitude else { return false }
        
        let camera = GMSCameraPosition.camera(withLatitude: lat ,longitude: lng , zoom: 13.0)
        my_map_view.animate(to: camera)
        GetLogAngLat()
        return true
    }
    //--------------------------------------------------
    //Calls this function when the tap is recognized.
    override func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    
    // Put this piece of code anywhere you like
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Hide the navigation bar on the this view controller
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Show the navigation bar on other view controllers
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    
    
    // MARK: Navigation
    
    
    
    
    // MARK: Navigation
    
    //--------------------------------------DropMenu----------------------------------------
    @IBAction func DropdownAtion() {
        if dropper.status == .hidden {
            dropper.items = ["VietNam","Japan","England"]
            dropper.theme = Dropper.Themes.white
            dropper.delegate = self
            dropper.cornerRadius = 3
            dropper.showWithAnimation(0.15, options: Dropper.Alignment.center, button: dropdownBtn)
            
        } else {
            dropper.hideWithAnimation(0.1)
        }
        //---------------------------------------------------------------------------------------------------
        
    }
    func registerNotification() {
        NotificationCenter.default.addObserver(self, selector: #selector(reloadData), name: .openMap, object: nil)
    }
    @objc func reloadData() {
        locateWithLongitude(DataService.shared.lon, andLatitude: DataService.shared.lat, andTitle: DataService.shared.title)
        DispatchQueue.main.async {
            self.searchBar.resignFirstResponder()
            self.searchBar.text?.removeAll()
            self.coverView.isHidden = true
        }
        
    }
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    //--------------------------googleMAp---------------------------------------------------
    func GetLogAngLat () { // lấy long và lat của vị trí hiện tại
        locManager.requestWhenInUseAuthorization()
        if (CLLocationManager.authorizationStatus() == .authorizedWhenInUse ||
            CLLocationManager.authorizationStatus() == .authorizedAlways
            )
        {
            currentLocation = locManager.location
            // print(currentLocation.coordinate.latitude)
            //  print(currentLocation.coordinate.longitude)
        }
        
    }
    
    func addMarker() {
        let marker = GMSMarker()
        marker.position = CLLocationCoordinate2D(latitude: -33.86, longitude: 151.20)
        marker.title = "Sydney"
        marker.snippet = "Australia"
        marker.map = self.my_map_view
    }
    func mapView(_ mapView: GMSMapView, didTapAt coordinate: CLLocationCoordinate2D) {
        self.my_map_view.clear()
        self.addMarker(coordinate: coordinate)
    }
    func addMarker(coordinate: CLLocationCoordinate2D) {
        let marker = GMSMarker()
        marker.position = coordinate
        marker.map = self.my_map_view
    }
    
    
    
    
    
    //-----------------------------------------------------------------------------------
    
    //---------------------------COLLECTIONVIEW--------------------------------------------------
    var array_Image = [#imageLiteral(resourceName: "icon_30"),#imageLiteral(resourceName: "icon_26"),#imageLiteral(resourceName: "icon_06"),#imageLiteral(resourceName: "icon_29"),#imageLiteral(resourceName: "icon_02")]
    var array_Label = [NameCollectionItem]()
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return array_Label.count 
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CollectionViewCell
        cell.my_image.image = array_Image[indexPath.row]
        cell.my_label.text = array_Label[indexPath.row].name
        
        return cell
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let layout = CGSize(width: (UIScreen.main.bounds.width)/5, height : (UIScreen.main.bounds.height)/10)
        return layout
    }
    // nhấn vào trả về được dữ liệu vị trí gần nhất của coleection view
    //-----------------------------------------------------
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let URLs = String(format: "http://192.168.1.67/revivemap/api/getUtiilities/")
        let gotoURL = URLs + "\(currentLocation.coordinate.latitude)/" + "\(currentLocation.coordinate.longitude)?token=" + "\(_token)"
        print(gotoURL)
        let getToURl = URL(string: gotoURL)
        let geToURLrequest = URLRequest(url: getToURl!)
        let tasks = URLSession.shared.dataTask(with: getToURl!) { (data, response, error) in
            if error != nil {
                print(error)
            }
            guard let urlData = data else {return}
            do {
                var results = try JSONSerialization.jsonObject(with: urlData, options: JSONSerialization.ReadingOptions.mutableContainers)
                //  print(results)
                let dictionLocation = results as! JSON
                let locationArray = dictionLocation["body"] as! [JSON]
                
                    for locationInfo in locationArray {
                        if let nameLocation = LocationRdiusOneKm.init(dict: locationInfo)
                        {
                            self.locationOneKm.append(nameLocation)
                            
                        } else {
                            print("Error")
                        }
                    }
                }
            catch {
                print("Json error : \(error)")
            }
        }
        tasks.resume()
        // ===============================================================================================
        
        
        
    }
    //_______________________________________________________________
    
    
    
    func locateWithLongitude(_ lon: Double, andLatitude lat: Double, andTitle title: String) {
        DispatchQueue.main.async {
            let position = CLLocationCoordinate2DMake(lat, lon)
            let marker = GMSMarker(position: position)
            let camera = GMSCameraPosition.camera(withLatitude: lat
                , longitude: lon, zoom: 10)
            marker.title = "addrees : \(title)"
            self.my_map_view.camera = camera
            marker.map = self.my_map_view
        }
    }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.characters.count > 0 {
            coverView.isHidden = false
        } else {
            coverView.isHidden = true
        }
        
        let placeClient = GMSPlacesClient()
        placeClient.autocompleteQuery(searchText, bounds: nil, filter: nil) { (results, error) in
            self.resultsArray.removeAll()
            if results == nil {
                return
            }
            for result in results! {
                if let result = result as? GMSAutocompletePrediction {
                    self.resultsArray.append(result.attributedFullText.string)
                }
            }
            //            self.searchResultController.reloadDataWithArray(self.resultsArray)
            DataService.shared.result = self.resultsArray
            NotificationCenter.default.post(name: .sendRequest, object: nil)
        }
    }
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        searchBar.text?.removeAll()
        coverView.isHidden = true
    }
    //-----------------------------------------------------------------
    
    // ----------login FaKE---------------
    func postAction() {
        let Url = String(format: "http://192.168.1.67/revivemap/api/auth/login")
        guard let serviceUrl = URL(string: Url) else { return }
        //        let loginParams = String(format: LOGIN_PARAMETERS1, "test", "Hi World")
        let parameterDictionary = ["email": "thang@gmail.com",
                                   "password" : "111111"]
        var request = URLRequest(url: serviceUrl)
        request.httpMethod = "POST"
        request.setValue("Application/json", forHTTPHeaderField: "Content-Type")
        guard let httpBody = try? JSONSerialization.data(withJSONObject: parameterDictionary, options: []) else {
            return
        }
        request.httpBody = httpBody
        
        let session = URLSession.shared
        session.dataTask(with: request) { (data, response, error) in
            if let response = response {
                print(response)
            }
            if let data = data {
                do {
                    let json = try JSONSerialization.jsonObject(with: data, options: [])
                    let dictContaintObject = json as! Dictionary<String,Any>
                    let token = dictContaintObject["body"] as! String
                    self._token = token
                    UserDefaults.standard.set(token, forKey: "Token")
                    print(self._token)
                    self.GetNameItemCloction()
                    
                }catch {
                    print(error)
                }
            }
            }.resume()
    }
    //----------------GET NAME Clloction -------------------
    func GetNameItemCloction() {
        
        let baseUrl = "http://192.168.1.67/revivemap/api/getAllCate?token="
        print(_token)
        let urlOfficial = baseUrl + _token
        print(urlOfficial)
        let urlcover = URL(string: urlOfficial)
        let urlRequest = URLRequest(url: urlcover!)
        let task = URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            if error != nil {
                print(error)
            }
            guard let urlContent = data else {return}
            do {
                
                var result = try JSONSerialization.jsonObject(with: urlContent, options: JSONSerialization.ReadingOptions.mutableContainers)
                let _dict_colection_item = result as? JSON
                let array = _dict_colection_item!["body"] as! Array<JSON>
                for dictInfo in array {
                    if let item = NameCollectionItem.init(dict: dictInfo)
                    {
                        self.items.append(item)
                        self.array_Label.append(item)
                    } else {
                        print("cant parse to object")
                    }
                }
                DispatchQueue.main.async {
                    print("reload collectionview")
                    self.my_Collection.reloadData()
                }
            } catch {
                print("ERROR")
            }
            
        }
        task.resume()
        
    }
}
extension Notification.Name {
    static let sendRequest = Notification.Name.init("sendRequest")
    static let openMap = Notification.Name.init("openMap")
}
extension ViewController: DropperDelegate {
    func DropperSelectedRow(_ path : IndexPath, contents: String) {
        text_country.text = contents
    }
}
extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    
}










