// ProfileData
import Foundation

struct Profile {
    var firstName:String
    var lastName:String
    var email:String
    
    init(firstName: String = "", lastName: String = "", email: String = "") {
        self.firstName = firstName
        self.lastName = lastName
        self.email = email
    }
}

struct UserKeys {
    var kFirstName: String
    var kLastName: String
    var kEmail: String
    var kIsLoggedIn: String
    var kPhoneNumber: String
    var kProfilePic: String
    var kEmailNotifyOrder: String
    var kEmailNotifyPassword: String
    var kEmailNotifySpecial: String
    var kEmailNotifyNews: String
    
    init() {
        kFirstName = "first name key"
        kLastName = "last name key"
        kEmail = "email key"
        kIsLoggedIn = "isLoggedIn"
        kPhoneNumber = "phone number"
        kProfilePic = "profile pic"
        kEmailNotifyOrder = "email notify order"
        kEmailNotifyPassword = "email notify password"
        kEmailNotifySpecial = "email notify special"
        kEmailNotifyNews = "email notify news"
    }
}

// Mock authentication manager to track login state
class AuthManager: ObservableObject {
    @Published var isLoggedIn: Bool {
        didSet {
            UserDefaults.standard.set(isLoggedIn, forKey: "kIsLoggedIn")
        }
    }
    
    init() {
        // Initialize from UserDefaults
        self.isLoggedIn = UserDefaults.standard.bool(forKey: "kIsLoggedIn")
        print("Init - User login status: \(isLoggedIn)")
    }
    
    func login() {
        isLoggedIn = true
        print("Logged IN - status: \(UserDefaults.standard.bool(forKey: "kIsLoggedIn"))")
    }
    
    func logout() {
        isLoggedIn = false
        print("Logged OUT - status: \(UserDefaults.standard.bool(forKey: "kIsLoggedIn"))")
    }
}

func getFullName() -> String {
    return (UserDefaults.standard.string(forKey: "first name key") ?? "") + " " +
            (UserDefaults.standard.string(forKey: "last name key") ?? "")
}

func getEmail() -> String {
    return (UserDefaults.standard.string(forKey: "email key") ?? "")
}

func getPhoneNumber() -> String {
    return (UserDefaults.standard.string(forKey: "phone number") ?? "")
}

