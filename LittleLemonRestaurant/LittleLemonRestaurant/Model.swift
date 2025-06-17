import Foundation


class Model:ObservableObject {
  let restaurants = [
    RestaurantLocation(city: "Chicago",
                       neighborhood: "Downtown North",
                       phoneNumber: "(312) 456-7890"),
    RestaurantLocation(city: "Chicago",
                       neighborhood: "Lake Shore",
                       phoneNumber: "(312) 555-3434"),
  ]
  
  @Published var loggedIn = false
  @Published var profile = Profile()
    
  @Published var reservation = Reservation()
  @Published var displayingReservationForm = false
  @Published var makingReservation = false
  @Published var temporaryReservation = Reservation()
  @Published var followNavitationLink = false
  
  @Published var displayTabBar = true
  @Published var tabBarChanged = false
  @Published var tabViewSelectedIndex = Int.max {
    didSet {
      tabBarChanged = true
    }
  }
}


