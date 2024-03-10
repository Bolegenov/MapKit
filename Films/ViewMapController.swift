//
//  ViewMapController.swift
//  Films
//
//  Created by Азамат Булегенов on 18.02.2024.
//


import MapKit
import UIKit

class ViewMapController: UIViewController, CLLocationManagerDelegate, UIGestureRecognizerDelegate, MKMapViewDelegate {
    
    @IBOutlet weak var mapView: MKMapView!
    
    @IBOutlet weak var distanceLabel: UILabel!
    
    var cinema = Cinema()
    var film = Films()
    
    var followMe = false
    var rout = false
    
    let locationManager = CLLocationManager()
    var userlocation = CLLocation()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.requestWhenInUseAuthorization()
        locationManager.delegate = self
        locationManager.startUpdatingLocation()
        
        let mapDragRecognizer = UIPanGestureRecognizer(target: self, action: #selector(self.didDragMap))
        
        // UIGestureRecognizerDelegate - чтоб мы могли слушать нажатия пользователя по экрану и отслеживать конкретные жесты
        mapDragRecognizer.delegate = self
        
        // Добавляем наши настройки жестов на карту
        mapView.addGestureRecognizer(mapDragRecognizer)
        
        let lat1: CLLocationDegrees = 40.77790480687565
        let long1: CLLocationDegrees = -73.87365615224674
        
        // Создаем координату передавая долготу и широту
        let location1: CLLocationCoordinate2D = CLLocationCoordinate2DMake(lat1, long1)
        
        // Создаем метку на карте
        let anotation1 = MKPointAnnotation()
        
        // Создаем координаты на метке
        anotation1.coordinate = location1
        
        // Задаем название для нашей метки
        anotation1.title = "Your location"

        // Задаем описание для нашей метки
        // anotation.subtitle = "Something"
        
        // Добавляем метку на карту
        mapView.addAnnotation(anotation1)
        
        let lat:CLLocationDegrees = film.latitude//43.2374454  37.82278260875653, -122.36866826463049
        let long:CLLocationDegrees = film.longitude//76.909891
//

        let location:CLLocationCoordinate2D = CLLocationCoordinate2DMake(lat, long)
        let anotation = MKPointAnnotation()

        anotation.coordinate = location
        anotation.title = film.namecinema
        anotation.subtitle = cinema.detailAbout

        mapView.addAnnotation(anotation)

        mapView.delegate = self
        mapView.setRegion(MKCoordinateRegion(center: location, span: MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5)), animated: true)
        
    }
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        userlocation = locations[0]
        print(userlocation)
        // Проверяем нужно ли следовать за пользователем
        if followMe {
            // Дельта - насколько отдалиться от координат пользователя по долготе и широте
            let latDelta:CLLocationDegrees = 0.05
            let longDelta:CLLocationDegrees = 0.05
            
            // Создаем область шириной и высотой по дельте
            let span = MKCoordinateSpan(latitudeDelta: latDelta, longitudeDelta: longDelta)
            
            // Создаем регион на карте с моими координатоми в центре
            let region = MKCoordinateRegion(center: userlocation.coordinate, span: span)
            
            // Приближаем карту с анимацией в данный регион
            mapView.setRegion(region, animated: true)
        }
        
    }
    
    
    
    @IBAction func showMyLocation(_ sender: Any) {
        followMe = true
        
        let latDelta:CLLocationDegrees = 0.05
        let longDelta:CLLocationDegrees = 0.05
        
        let span = MKCoordinateSpan(latitudeDelta: latDelta, longitudeDelta: longDelta)
        let region = MKCoordinateRegion(center: userlocation.coordinate, span: span)
        
        mapView.setRegion(region, animated: true)
    }

    
    
    // Вызывается каждый раз при изменении местоположения нашего пользователя
    

    @IBAction func showme(_ sender: Any) {
        // Говорим следовать за пользователем
        followMe = true
    }
    
    // Вызывается когда двигаем карту
    @objc func didDragMap(gestureRecognizer: UIGestureRecognizer) {
        // Как только начали двигать карту
        if (gestureRecognizer.state == UIGestureRecognizer.State.began) {
            
            // Говорим не следовать за пользователем
            followMe = false
            
            print("Map drag began")
        }
        
        // Когда закончили двигать карту
        if (gestureRecognizer.state == UIGestureRecognizer.State.ended) {
            
            print("Map drag ended")
        }
        
    }
    
    
    // MARK: -  MapView delegate
    // Вызывается когда нажали на метку на карте
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        mapView.delegate = self
        print(view.annotation?.title)
        if self.rout {
            self.mapView.removeOverlay(mapView.overlays as! MKOverlay)
        }
        // Получаем координаты метки
        let location:CLLocation = CLLocation(latitude: (view.annotation?.coordinate.latitude)!, longitude: (view.annotation?.coordinate.longitude)!)
        
        // Считаем растояние до метки от нашего пользователя
        let meters:CLLocationDistance = location.distance(from: userlocation)
        distanceLabel.text = String(format: "Distance: %.2f m", meters)
        
        
        // Routing - построение маршрута
        // 1 Координаты начальной точки А и точки B
        let sourceLocation = CLLocationCoordinate2D(latitude: userlocation.coordinate.latitude, longitude: userlocation.coordinate.longitude)
        
        let destinationLocation = CLLocationCoordinate2D(latitude: (view.annotation?.coordinate.latitude)!, longitude: (view.annotation?.coordinate.longitude)!)
        
        // 2 упаковка в Placemark
        let sourcePlacemark = MKPlacemark(coordinate: sourceLocation, addressDictionary: nil)
        let destinationPlacemark = MKPlacemark(coordinate: destinationLocation, addressDictionary: nil)
        
        // 3 упаковка в MapItem
        let sourceMapItem = MKMapItem(placemark: sourcePlacemark)
        let destinationMapItem = MKMapItem(placemark: destinationPlacemark)
        
        // 4 Запрос на построение маршрута
        let directionRequest = MKDirections.Request()
        // указываем точку А, то есть нашего пользователя
        directionRequest.source = sourceMapItem
        // указываем точку B, то есть метку на карте
        directionRequest.destination = destinationMapItem
        // выбираем на чем будем ехать - на машине
        directionRequest.transportType = .automobile
        
        // Calculate the direction
        let directions = MKDirections(request: directionRequest)
        
        // 5 Запускаем просчет маршрута
        directions.calculate {
            (response, error) -> Void in
            
            // Если будет ошибка с маршрутом
            guard let response = response else {
                if let error = error {
                    print("Error: \(error)")
                }
                
                return
            }
            
            // Берем первый машрут
            let route = response.routes[0]
            // Рисуем на карте линию маршрута (polyline)
            self.mapView.addOverlay((route.polyline), level: MKOverlayLevel.aboveRoads)
            
            // Приближаем карту с анимацией в регион всего маршрута
            let rect = route.polyline.boundingMapRect
            self.mapView.setRegion(MKCoordinateRegion(rect), animated: true)
            
            self.rout = true
        }
        
    }
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        // Настраиваем линию
        let renderer = MKPolylineRenderer(overlay: overlay)
        // Цвет красный
        renderer.strokeColor = UIColor.red
        // Ширина линии
        renderer.lineWidth = 4.0
        
        return renderer
    }
    
}


