// Main/Home page view after logging in
import SwiftUI

struct HomeView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @EnvironmentObject var model:Model
    
    @ObservedObject var authManager: AuthManager
    @ObservedObject var dishesModel = DishesModel()
    
    // Monitor if page is loaded for the first time so
    // we only load data once
    @State var firstTime = true
    @State var tabSelection = 0
    @State var previousTabSelection = -1 // any invalid value
    
    var body: some View {
        VStack {
            
            TabView (selection: $model.tabViewSelectedIndex) {
                OurDishesView()
                    .tag(0)
                    .tabItem {
                        Label("Menu", systemImage: "fork.knife")
                    }
                    .onAppear() {
                        tabSelection = 0
                        if firstTime {
                            firstTime = false
                        }
                    }
                    // runs when the view appears
                   .task {
                       if firstTime {
                           await dishesModel.reload(viewContext)
                       }
                   }
                
                ProfileView(authManager: authManager)
                    .tag(1)
                    .tabItem {
                        Label("Profile", systemImage: "person.crop.circle")
                    }
                    .onAppear() {
                        tabSelection = 1
                    }
                
                LocationsView()
                    .tag(2)
                    .tabItem {
                        Label("Reservations", systemImage: "calendar.and.person")
                    }
                    .onAppear() {
                        tabSelection = 2
                    }
            }
             
        }
        .background(backgroundMainColor)
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
    }
    
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(authManager: authManager())
    }
    static func authManager() -> AuthManager {
        let aM = AuthManager()
        return aM
    }
}

