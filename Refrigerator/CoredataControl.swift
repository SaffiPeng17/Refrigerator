//
//  CoredataControl.swift
//  Refrigerator
//
//  Created by Saffi on 2018/6/23.
//  Copyright © 2018 Saffi. All rights reserved.
//

import UIKit
import CoreData


let appDelegate = UIApplication.shared.delegate as! AppDelegate
let context = appDelegate.persistentContainer.viewContext

class Coredata {

    static let shared = Coredata()

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
    func createNewRecords(record: Record) -> Bool {
        let recordCount = readRecord(fetchLimit: nil, predicate: nil, sortBy: nil).count
        let enRecords = NSEntityDescription.entity(forEntityName: "Records", in: context)!
        enRecords.setValuesForKeys(["id": recordCount,
                                    "name": record.name as Any,
                                    "classified": record.classified as Any,
                                    "quantity": record.quantity as Any,
                                    "vaildDate": record.validdate as Any,
                                    "image": record.image as Any])
        return saveContext()
    }
    func createNewClassified(classified: Classified) -> Bool {
        let classifiedCount = readClassified(fetchLimit: nil, predicate: nil, sortBy: nil).count
        let enClassified = NSEntityDescription.entity(forEntityName: "Classified", in: context)!
        enClassified.setValuesForKeys(["id": classifiedCount,
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
