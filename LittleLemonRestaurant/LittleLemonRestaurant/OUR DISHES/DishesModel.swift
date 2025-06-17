import Foundation
import CoreData


@MainActor
class DishesModel: ObservableObject {
    
    @Published var menuItems = [MenuItem]()
    
    func reload(_ coreDataContext:NSManagedObjectContext) async {
        let url = URL(string: "https://raw.githubusercontent.com/Meta-Mobile-Developer-PC/Working-With-Data-API/main/littleLemonSimpleMenu.json")!
        let urlSession = URLSession.shared
        
        do {
            let (data, _) = try await urlSession.data(from: url)
            let fullMenu = try JSONDecoder().decode(JSONMenu.self, from: data)
            print("JSON decoded")
            
            /* Jerry-rigged data: Messy arrangement of data, because we want to make use of
             downloaded JSON data for demonstration purposes.
             But the JSON provided by the Coursera server is limited, so we will extend it. */
            for item in fullMenu.menu {
                var dish = item
                dish.category = CategoryDict[dish.name] ?? "Appetizers"
                dish.price = UpdatedPricedDict[dish.name] ?? dish.price
                dish.descr = DescDict[dish.name] ?? "Description unavailable"
                menuItems.append(dish)
            }
            
            menuItems.append(contentsOf: MainMenuItems)
        
            //menuItems = fullMenu.menu
            
            // populate Core Data
            Dish.deleteAll(coreDataContext)
            Dish.createDishesFrom(menuItems:menuItems, coreDataContext)
        }
        catch (let error) {
            print("JSON LOAD ERROR:")
            print(error)
        }
    }
}

// return sample dish for initialization
func getSampleDish() -> Dish {
   let context = PersistenceController.shared.container.viewContext

    let dish = Dish(context: context)
    dish.name = "Hummus"
    dish.price = 10
    dish.size = "Extra Large"
    dish.category = "Appetizer"
    dish.descr = "Our delicious hummus, made fresh daily. Served with garlic pita chips"
    return dish
}

func newJSONDecoder() -> JSONDecoder {
    let decoder = JSONDecoder()
    decoder.dateDecodingStrategy = .iso8601
    return decoder
}

func newJSONEncoder() -> JSONEncoder {
    let encoder = JSONEncoder()
    encoder.dateEncodingStrategy = .iso8601
    return encoder
}


extension URLSession {
    fileprivate func codableTask<T: Codable>(with url: URL, completionHandler: @escaping (T?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        return self.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                completionHandler(nil, response, error)
                return
            }
            completionHandler(try? newJSONDecoder().decode(T.self, from: data), response, nil)
        }
    }
    
    func itemsTask(with url: URL, completionHandler: @escaping (JSONMenu?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        return self.codableTask(with: url, completionHandler: completionHandler)
    }
}

