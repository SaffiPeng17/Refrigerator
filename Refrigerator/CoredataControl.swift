//
//  CoredataControl.swift
//  Refrigerator
//
//  Created by Saffi on 2018/6/23.
//  Copyright © 2018 Saffi. All rights reserved.
//

import UIKit
import CoreData


class RecordData {
    var name: String = ""
    var quantity: Int = 0
    var validdate: String = ""
    var classified: String = ""
    var image: Data?
}

class ClassifiedData {
    var name: String = ""
}

let appDelegate = UIApplication.shared.delegate as! AppDelegate
let context = appDelegate.persistentContainer.viewContext

class Coredata {

    static let shared = Coredata()

    //MARK: - Common Function
    func saveContext() -> Bool {
        do {
            try context.save()
            prepareData()
            return true
        } catch let error as NSError {
            print("Context Save Fail! \(error), \(error.userInfo)")
        }
        return false
    }

    //MARK: - Create
    func createNewRecords(record: RecordData) -> Bool {
        let recordCount = readRecord(fetchLimit: nil, predicate: nil, sortBy: nil).count
        let recordEntity = NSEntityDescription.entity(forEntityName: "Record", in: context)!
        let recordObj = NSManagedObject(entity: recordEntity, insertInto: context)
        let id = (recordCount <= 0) ? 1 : recordCount
        recordObj.setValue(id, forKey: "id")
        recordObj.setValue(record.name, forKey: "name")
        recordObj.setValue(record.classified, forKey: "classified")
        recordObj.setValue(record.quantity, forKey: "quantity")
        recordObj.setValue(record.validdate, forKey: "validdate")
        recordObj.setValue(record.image, forKey: "image")
//        recordObj.setValuesForKeys(["id": (recordCount <= 0 ? 1 : recordCount),
//                                    "name": record.name as Any,
//                                    "classified": record.classified as Any,
//                                    "quantity": record.quantity as Any,
//                                    "vaildDate": record.validdate as Any,
//                                    "image": record.image as Any])

        return saveContext()
    }
    func createNewClassified(classified: ClassifiedData) -> Bool {
        let classifiedCount = readClassified(fetchLimit: nil, predicate: nil, sortBy: nil).count
        let classifiedEntity = NSEntityDescription.entity(forEntityName: "Classified", in: context)!
        let classifiedObj = NSManagedObject(entity: classifiedEntity, insertInto: context)
        classifiedObj.setValuesForKeys(["id": classifiedCount,
                                        "name": classified.name as Any])
        return saveContext()
    }

    //MARK: - Read
    func readRecord(fetchLimit: Int?, predicate: NSPredicate?, sortBy: [NSSortDescriptor]?) -> [Record] {
        var result = [Record]()
        let request = NSFetchRequest<Record>(entityName: "Record")
        if fetchLimit != nil {
            request.fetchLimit = fetchLimit!
        }
        request.predicate = predicate
        request.sortDescriptors = sortBy

        do {
            result = try context.fetch(request)
        } catch let error as NSError {
            print("Fetch Record data Fail! \(error), \(error.userInfo)")
        }
        return result
    }
    func readClassified(fetchLimit: Int?, predicate: NSPredicate?, sortBy: [NSSortDescriptor]?) -> [Classified] {
        var result = [Classified]()
        let request = NSFetchRequest<Classified>(entityName: "Classified")
        if fetchLimit != nil {
            request.fetchLimit = fetchLimit!
        }
        request.predicate = predicate
        request.sortDescriptors = sortBy

        do {
            result = try context.fetch(request)
        } catch let error as NSError {
            print("Fetch Record data Fail! \(error), \(error.userInfo)")
        }
        return result
    }

    //MARK: - Update
    func updateRecords(predicate: NSPredicate, updateValues: [String: Any]) -> Bool {
        let objects = readRecord(fetchLimit: 1, predicate: predicate, sortBy: nil)
        if objects.count > 0 {
            for object in objects {
                for updateValue in updateValues {
                    object.setValue(updateValue.value, forKey: updateValue.key)
                }
            }
            return saveContext()
        }
        return true
    }
    func updateClassified(predicate: NSPredicate, updateValues: [String: Any]) -> Bool {
        let objects = readClassified(fetchLimit: 1, predicate: predicate, sortBy: nil)
        if objects.count > 0 {
            for object in objects {
                for updateValue in updateValues {
                    object.setValue(updateValue.value, forKey: updateValue.key)
                }
            }
            return saveContext()
        }
        return true
    }

    //MARK: - Delete
    func deleteRecords(predicate: NSPredicate) -> Bool {
        let objects = readRecord(fetchLimit: nil, predicate: predicate, sortBy: nil)
        if objects.count > 0 {
            for object in objects {
                context.delete(object)
            }
            return saveContext()
        }
        return true
    }
    func deleteClassified(predicate: NSPredicate) -> Bool {
        let objects = readClassified(fetchLimit: nil, predicate: predicate, sortBy: nil)
        if objects.count > 0 {
            for object in objects {
                context.delete(object)
            }
            return saveContext()
        }
        return true
    }
}
