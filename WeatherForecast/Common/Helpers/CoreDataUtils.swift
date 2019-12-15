//
//  CoreDataUtils.swift
//  WeatherForecast
//
//  Created by Dilip Kosuri on 14/12/19.
//  Copyright © 2019 Dilip Kosuri. All rights reserved.
//

import Foundation
import UIKit
import CoreData


func retrieveData(complition: ([FavouriteDataModel]) -> Void) {
  //As we know that container is set up in the AppDelegates so we need to refer that container.
  guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return  }
  
  //We need to create a context from this container
  let managedContext = appDelegate.persistentContainer.viewContext
  
  var favModel = [FavouriteDataModel]()
  
  //Prepare the request of type NSFetchRequest  for the entity
  let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "FavouriteDataSourceModel")
  do {
    let result = try managedContext.fetch(fetchRequest)
    for data in result as! [NSManagedObject] {
      var singleFavouriteModel = FavouriteDataModel()
      singleFavouriteModel.icon = data.value(forKey: "weatherIconDesc") as! String
      singleFavouriteModel.latitude = data.value(forKey: "latitude") as? String ?? ""
      singleFavouriteModel.longitude = data.value(forKey: "longitude") as? String ?? ""
      singleFavouriteModel.currentLocation = data.value(forKey: "currentLocation") as! String
      singleFavouriteModel.temperature = data.value(forKey: "temperature") as! String
      singleFavouriteModel.humidity = data.value(forKey: "humidity") as! String
      singleFavouriteModel.precipitation = data.value(forKey: "precipitation") as! String
      singleFavouriteModel.pressureCheck = data.value(forKey: "pressureCheck") as! String
      singleFavouriteModel.wind = data.value(forKey: "wind") as! String
      singleFavouriteModel.date = data.value(forKey: "date") as! String
      singleFavouriteModel.tempDesc = data.value(forKey: "temperatureDesc") as! String
      favModel.append(singleFavouriteModel)
    }
    
  } catch {
    print("Failed")
  }
  
  return complition(favModel)
}

func createData(model: [Home.CircleViewModel.LocationData], mock: Bool){
  
  let data = model
  
  //As we know that container is set up in the AppDelegates so we need to refer that container.
  guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
  
  //We need to create a context from this container
  let managedContext = appDelegate.persistentContainer.viewContext
  
  //Now let’s create an entity and new user records.
  let userEntity = NSEntityDescription.entity(forEntityName: "FavouriteDataSourceModel", in: managedContext)!
  
  for item in data {
    let entityObject = NSManagedObject(entity: userEntity, insertInto: managedContext)
    entityObject.setValue(item.currentLocation, forKey: "currentLocation")
    entityObject.setValue(item.dateTime, forKey: "date")
    entityObject.setValue(item.humidity?.labelTextValue, forKey: "humidity")
    entityObject.setValue(item.weatherIconDesc, forKey: "imageName")
    entityObject.setValue(item.precipitation, forKey: "latitude")
    entityObject.setValue(item.precipitation, forKey: "longitude")
    entityObject.setValue(item.precipitation, forKey: "precipitation")
    entityObject.setValue(item.pressureCheck, forKey: "pressureCheck")
    entityObject.setValue(item.weatherID, forKey: "temperature")
    entityObject.setValue(item.temperatureDesc, forKey: "temperatureDesc")
    entityObject.setValue(item.weatherIconDesc, forKey: "weatherIconDesc")
    entityObject.setValue(item.weatherID, forKey: "weatherID")
    entityObject.setValue(item.wind?.labelTextValue, forKey: "wind")
    
  }
  
  do {
    try managedContext.save()
    
  } catch let error as NSError {
    print("Could not save. \(error), \(error.userInfo)")
  }
}

func deleteData(){
  //As we know that container is set up in the AppDelegates so we need to refer that container.
  guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
  //We need to create a context from this container
  let managedContext = appDelegate.persistentContainer.viewContext
  let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "FavouriteDataSourceModel")
  do
  {
    let test = try managedContext.fetch(fetchRequest)
    if test.count > 0 {
      let objectToDelete = test[0] as! NSManagedObject
      managedContext.delete(objectToDelete)
      
      do{
        try managedContext.save()
      }
      catch
      {
        print(error)
      }
    }
  }
  catch
  {
    print(error)
  }
}



