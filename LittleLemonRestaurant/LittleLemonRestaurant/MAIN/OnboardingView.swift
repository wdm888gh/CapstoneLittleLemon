// Onboarding (First Screen)
import SwiftUI
import CoreData

let userDefaults = UserDefaults.standard

struct OnboardingView: View {
    //@Environment(\.managedObjectContext) private var viewContext
   
    // For an EnvironmentObject, declare it as a StateObject
    // ONCE. Then it can be accessed in any view with
    // the declaration:
    //   @EnvironmentObject var model:Model
    // or
    //   .environmentObject(model) appended to an
    // enclosing stack
    @StateObject var model = Model()
    @StateObject private var authManager = AuthManager()
    
    let userKeys = UserKeys()
    
    var body: some View {
        
        //let isLoggedIn = userDefaults.object(forKey: userKeys.kIsLoggedIn) as? Bool ?? false
        //if !isLoggedIn {
        
        if authManager.isLoggedIn {
            HomeView(authManager: authManager).environmentObject(model)
        } else {
            //LoginView().environmentObject(model)
            LoginView(authManager: authManager)
        }
        
    }
}

struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingView().environmentObject(Model())
    }
}



/* For testing only
 LoginView().environmentObject(model)
    .onAppear() {
        let fN = userDefaults.object(forKey: userKeys.kFirstName) as? String ?? ""
        let lN = userDefaults.object(forKey: userKeys.kLastName) as? String ?? ""
        let em = userDefaults.object(forKey: userKeys.kEmail) as? String ?? ""
        let lin = userDefaults.object(forKey: userKeys.kIsLoggedIn) as? Bool ?? false
        print("First Name: \(fN)")
        print("Last Name: \(lN)")
        print("Email: \(em)")
        print("isLoggedIn: \(lin)")
    }
 */
