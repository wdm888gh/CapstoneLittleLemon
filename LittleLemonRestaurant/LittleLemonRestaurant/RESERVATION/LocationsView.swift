// LocationsView
import SwiftUI

struct LocationsView: View {
    @EnvironmentObject var model:Model
    
    @State var showingReservation = false
    @State var makingReservation = false
    let screenWidth: CGFloat = UIScreen.main.bounds.width
    let screenHeight: CGFloat = UIScreen.main.bounds.height
    
    var body: some View {
        ZStack {
            VStack {
                LittleLemonLogo()
                    //.padding(.top, 10)
                
                Text (model.displayingReservationForm ? "Reservation Details" :
                        "Select a location")
                .padding([.leading, .trailing], 40)
                .padding([.top, .bottom], 8)
                .background(Color.gray.opacity(0.2))
                .cornerRadius(20)
                
                NavigationView {
                    // EmptyView()
                    List(model.restaurants, id: \.self) { restaurant in
                        NavigationLink(destination: ReservationFormView(restaurant)) {
                            RestaurantView(restaurant)
                        }
                    }
                    .background(.white)
                    .navigationBarTitle("")
                    .navigationBarHidden(true)
                }
                .onDisappear{
                    if model.tabBarChanged { return }
                    
                    // this changes the phrase from "Select a location"
                    // to "RESERVATION"
                    model.displayingReservationForm = true
                    model.makingReservation = false
                }
                //.frame(maxHeight: .infinity)
                .padding(.top, -10)
                // makes the list background invisible, default is gray
                .scrollContentBackground(.hidden)
                
                if !model.makingReservation {
                    VStack {
                        Text("View reservation")
                            .padding(.init(top: 10, leading: 30, bottom: 10, trailing: 30))
                            .font(.custom(llFonts.textFont,
                                          fixedSize: llFonts.cardSize))
                            .fontWeight(.bold)
                            .foregroundColor(llYellow)
                            .background(llGreen)
                            .cornerRadius(10)
                            .onTapGesture {
                                showingReservation.toggle()
                            }
                            .sheet(isPresented: $showingReservation) {
                                ReservationView()
                            }
                    }
                }
                // End VStack
                
                
            }
            .padding(.bottom, 30)
            // End VStack
            

            
        } // End ZStack
        .background(
            Image("Background_lemons1")
                .resizable()
                .scaledToFill()
                .edgesIgnoringSafeArea(.all)
                .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
                .opacity(0.8)
        )
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        LocationsView().environmentObject(Model())
    }
}
