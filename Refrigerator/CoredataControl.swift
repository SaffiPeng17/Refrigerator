//
//  CoredataControl.swift
//  Refrigerator
//
//  Created by Saffi on 2018/6/23.
//  Copyright © 2018 Saffi. All rights reserved.
//

import UIKit
import CoreData


class RecordsObj: NSManagedObject {
    var id: Int32?
    var name: String!
    var classified: String!
    var quantity: Double?
    var vaildDate: Date!
    var image: UIImage?
}

class ClassifiedObj: NSManagedObject {
    var id: Int32?
    var name: String!
}

class Coredata {

    static let shared = Coredata()

    let context = AppDelegate.shared.persistentContainer.viewContext

    //MARK: - Common Function
    func saveContext() -> Bool {
        do {
            try context.save()
            return true
        } catch let error as NSError {
            print("Context Save Fail! \(error), \(error.userInfo)")
        }
        return false
    }

    //MARK: - Create
    func createNewRecords(record: RecordsObj) -> Bool {
        let recordCount = readRecord(fetchLimit: nil, predicate: nil, sortBy: nil).count
        let enRecords = NSEntityDescription.entity(forEntityName: "Records", in: context)!
        enRecords.setValuesForKeys(["id": recordCount,
                                    "name": record.name,
                                    "classified": record.classified,
                                    "quantity": record.quantity as Any,
                                    "vaildPeriod": record.vaildDate,
                                    "image": record.image as Any])
        return saveContext()
    }
    func createNewClassified(classified: ClassifiedObj) -> Bool {
        let classifiedCount = readClassified(fetchLimit: nil, predicate: nil, sortBy: nil).count
        let enClassified = NSEntityDescription.entity(forEntityName: "Classified", in: context)!
        enClassified.setValuesForKeys(["id": classifiedCount,
                                       "classname": classified.name])
        return saveContext()
    }

    //MARK: - Read
    func readRecord(fetchLimit: Int?, predicate: NSPredicate?, sortBy: [NSSortDescriptor]?) -> [RecordsObj] {
        var result = [RecordsObj]()
        let request = NSFetchRequest<RecordsObj>(entityName: "Records")
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
    func readClassified(fetchLimit: Int?, predicate: NSPredicate?, sortBy: [NSSortDescriptor]?) -> [ClassifiedObj] {
        var result = [ClassifiedObj]()
        let request = NSFetchRequest<ClassifiedObj>(entityName: "Classified")
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