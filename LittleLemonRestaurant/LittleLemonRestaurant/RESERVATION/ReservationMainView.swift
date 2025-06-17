import SwiftUI
import CoreData

struct ReservationMainView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @StateObject var model = Model()
    @State var tabSelection = 0
    @State var previousTabSelection = -1 // any invalid value
    
    
    var body: some View {
        TabView (selection: $model.tabViewSelectedIndex){
            LocationsView()
                .tag(0)
                .tabItem {
                    if !model.displayingReservationForm {
                        Label("Locations", systemImage: "fork.knife")
                    }
                }
                .onAppear() {
                    tabSelection = 0
                }
            
            ReservationView()
                .tag(1)
                .tabItem {
                    if !model.displayingReservationForm {
                        Label("Reservation", systemImage: "square.and.pencil")
                    }
                }
                .onAppear() {
                    tabSelection = 1
                }
        }
        .id(tabSelection)
        .environmentObject(model)
        
    }
}

struct ReservationMainView_Previews: PreviewProvider {
    static var previews: some View {
        ReservationMainView().environmentObject(Model())
    }
}




