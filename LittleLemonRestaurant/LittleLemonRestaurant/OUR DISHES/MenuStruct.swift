import Foundation

struct JSONMenu: Codable {
    // add code here
    var menu: [MenuItem]
    
    enum CodingKeys: String, CodingKey {
        case menu = "menu"
    }
}

struct MenuItem: Codable, Hashable, Identifiable {
    let id = UUID()
    
    // add code here
    var name: String
    var price: String
    var category: String = ""
    var descr: String = ""
    
    enum CodingKeys: String, CodingKey {
        case name = "title"
        case price = "price"
    }
}

// CaseIterable allows us to use enum.allCases
// Comparable allows us to compare enums for sort ordering
enum MenuCategory: String, Comparable {
    case Appetizers = "Appetizers"
    case Main = "Main"
    case Drinks = "Drinks"
    case Desserts = "Desserts"
    
    // Define sort order of enums
    private var sortOrder: Int {
        switch self {
        case .Appetizers:
            return 0
        case .Main:
            return 1
        case .Drinks:
            return 2
        case .Desserts:
            return 3
        }
    }
    
    // Create overloaded operators for enum.
    // Make sure they are static functions.
    // e.g. data.sort { $0.menuItem.category! < $1.menuItem.category! }
    // I assume we need the '!' to force unwrap the value.
    static func ==(lhs: MenuCategory, rhs: MenuCategory) -> Bool {
        return lhs.sortOrder == rhs.sortOrder
    }
    
    static func <(lhs: MenuCategory, rhs: MenuCategory) -> Bool {
        return lhs.sortOrder < rhs.sortOrder
    }
}

let menuCategorySortDict = [
    "Appetizers": 0,
    "Main": 1,
    "Desserts": 2,
    "Drinks": 3,
]

// Get MenuCategory from rawValue string
func getMenuCategoryFromString(categoryString: String?) -> MenuCategory {
    if let catStr = categoryString {
        if let menuCat = MenuCategory(rawValue: catStr) {
            return menuCat
        }
    }
    return .Appetizers
}

// Returns array of all MenuCategory strings
func getAllMenuCategoryStrings() -> [String] {
    var catString = [String]()
    menuCategorySortDict.forEach { key, value in
        catString.append(key)
    }
    return catString.sorted(by: { menuCategorySortDict[$0] ?? 0 < menuCategorySortDict[$1] ?? 0 })
}

// Return a set containing all category strings
func loadSelectedCategories() -> Set<String> {
    let categories = getAllMenuCategoryStrings()
    var categorySet = Set<String>()
    for category in categories {
        categorySet.insert(category)
    }
    return categorySet
}

// Return array of ordered category strings found in selectedCategories set
func getCategoryStringsFromSet(_ categorySet: Set<String>) -> [String] {
    return Array(categorySet).sorted(by: { menuCategorySortDict[$0] ?? 0 < menuCategorySortDict[$1] ?? 0})
}

let CategoryDict = [
    "Beer": "Drinks",
    "Caesar": "Appetizers",
    "Coke": "Drinks",
    "Fried Calamari Rings": "Appetizers",
    "Fried Mushroom": "Appetizers",
    "Greek": "Appetizers",
    "Grilled Chicken Salad": "Appetizers",
    "Hummus": "Appetizers",
    "Iced Tea": "Drinks",
    "Mediterranean Tuna Salad": "Appetizers",
    "Spinach Artichoke Dip": "Appetizers",
    "Water":"Drinks"
]

let UpdatedPricedDict = [
    "Fried Calamari Rings": "12.99",
]

let DescDict = [
    "Beer": "A wide of selection of beers",
    "Caesar": "Caesar salad with Romaine, Parmesan cheese, & croutons",
    "Coke": "Coca-Cola",
    "Fried Calamari Rings": "Calamari breaded in panko. Comes with marinara dipping sauce",
    "Fried Mushroom": "Fried mushrooms with Mediterranean seasoning",
    "Greek": "Greek Salad with tomatoes, feta cheese, olives and house dressing",
    "Grilled Chicken Salad": "Grilled seasoned chicken breast and fresh salad with house dressing",
    "Hummus": "Our delicious hummus, made fresh daily. Served with garlic pita chips",
    "Iced Tea": "Iced tea with lemon",
    "Mediterranean Tuna Salad": "Pan-seared tuna with Mediterranean salad and house dressing",
    "Spinach Artichoke Dip": "Creamy spinach and artichoke dip, served with garlic chips",
    "Water": "Sparkling water"
]

let MainMenuItems = [
    MenuItem(
        name: "Pizza Margherita",
        price: "13.99",
        category: "Main",
        descr: "Margherita pizza with fresh mozzarella & basil baked in our wood-fired oven"
    ),
    MenuItem(
        name: "Moussaka",
        price: "14.99",
        category: "Main",
        descr: "Greek eggplant casserole in a lamb and tomato sauce"
    ),
    MenuItem(
        name: "Shish Kebab",
        price: "17.99",
        category: "Main",
        descr: "Fire-grilled lamb, chicken and vegetable skewers. Served with rice"
    ),
    MenuItem(
        name: "Lobster Risotto",
        price: "21.99",
        category: "Main",
        descr: "Creamy risotto with lobster"
    ),
    MenuItem(
        name: "Tajine",
        price: "18.99",
        category: "Main",
        descr: "Slow-cooked Moroccan stew of chicken & vegetables. Served with rice"
    ),
    MenuItem(
        name: "Grilled Swordfish with Lemon",
        price: "24.99",
        category: "Main",
        descr: "Fresh swordfish, grilled and served with roasted lemons on a bed of rice"
    ),
    MenuItem(
        name: "Paella",
        price: "59.99",
        category: "Main",
        descr: "Shrimp, mussels, chorizo and chicken on a bed of rice. Serves 4"
    ),
    MenuItem(
        name: "Tiramisu",
        price: "8.99",
        category: "Desserts",
        descr: "The legendary Italian dessert"
    ),
    MenuItem(
        name: "Gelato",
        price: "7.99",
        category: "Desserts",
        descr: "Three scoops of creamy gelato in your choice of five different flavors"
    ),
    MenuItem(
        name: "Cheesecake",
        price: "8.99",
        category: "Desserts",
        descr: "A slice of delicious and decadent New York cheesecake"
    ),
]

let dishImgFile = [
    "Beer": "dishImg_Beer",
    "Caesar": "dishImg_Caesar",
    "Coke": "dishImg_CocaCola",
    "Fried Calamari Rings": "dishImg_FriedCalamari",
    "Fried Mushroom": "dishImg_FriedMushroom",
    "Greek": "dishImg_Greek",
    "Grilled Chicken Salad": "dishImg_GrilledChicken",
    "Hummus": "dishImg_Hummus",
    "Iced Tea": "dishImg_IcedTea",
    "Mediterranean Tuna Salad": "dishImg_MediterraneanTuna",
    "Spinach Artichoke Dip": "dishImg_SpinachArtichoke",
    "Water": "dishImg_Water",
    "Pizza Margherita": "dishImg_Pizza",
    "Moussaka": "dishImg_Moussaka",
    "Shish Kebab": "dishImg_ShishKebab",
    "Lobster Risotto": "dishImg_LobsterRisotto",
    "Tajine": "dishImg_Tajine",
    "Grilled Swordfish with Lemon": "dishImg_GrilledSwordfish",
    "Paella": "dishImg_Paella",
    "Tiramisu": "dishImg_Tiramisu",
    "Gelato": "dishImg_Gelato",
    "Cheesecake": "dishImg_Cheesecake",
    "NoName": "dishImg_NoImage"
]


