//
// Dish+Extension.swift



import Foundation
import CoreData


extension Dish {
    
    static func createDishesFrom(menuItems:[MenuItem],
                                 _ context:NSManagedObjectContext) {
        for menuItem in menuItems {
            guard let _ = exists(name: menuItem.name, context) else {
                continue
            }
            
            let oneDish = Dish(context: context)
            //oneDish.name = menuItem.title
            oneDish.name = menuItem.name
            if let price = Float(menuItem.price) {
                oneDish.price = price
            }
            oneDish.category = menuItem.category
            oneDish.descr = menuItem.descr
            
        }
    }
    
    
    static func exists(name: String,
                       _ context:NSManagedObjectContext) -> Bool? {
        let request = Dish.request()
        let predicate = NSPredicate(format: "name CONTAINS[cd] %@", name)
        request.predicate = predicate
        
        do {
            guard let results = try context.fetch(request) as? [Dish]
            else {
                return nil
            }
            return results.count > 0
        } catch (let error){
            print(error.localizedDescription)
            return false
        }
    }
    
}
