//  DishDetailsView.swift

import SwiftUI

struct DishDetailsView: View {
    @Environment(\.dismiss) var dismiss
    private var dish: Dish
    
    init(_ dish: Dish) {
        self.dish = dish
    }
    
    @State var profilePic: String =
        UserDefaults.standard.string(forKey: "profile pic") ?? "dishImg_NoImage"
    
    @State private var showOrderAlert = false
    
    let cardWidth: CGFloat = UIScreen.main.bounds.width - 50
    let cardHeight: CGFloat = 220
    
    var body: some View {
        
        let userKeys = UserKeys()
        
        let dishName = dish.name ?? "NoName"
        let dishDesc = dish.descr ?? "No description"
        let imgFile = dishImgFile[dishName] ?? "dishImg_NoImage"
        
        ZStack {
            VStack (alignment: .leading) {
                Button {
                    dismiss()
                } label: {
                    Image(systemName: //"arrowshape.backward.circle.fill"
                          "chevron.left"
                    )
                    //.imageScale(.large)
                    .font(.system(size: 24, weight: .bold))
                }
                .padding(10)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
            
            VStack {
                //LittleLemonLogoHeader(profilePic: $profilePic).padding(.top, 10).padding(.bottom, 30)
                
                VStack {
                    HStack {
                        Spacer()
                        Spacer()
                        Image("littleLemon")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 200)
                        
                        Spacer()
                        Image(UserDefaults.standard.string(forKey: userKeys.kProfilePic) ?? "dishImg_NoImage")
                            .resizable()
                            .frame(width: 50, height: 50)
                    }
                    .padding(.trailing, 10)
                }
                .padding(.top, 10)
                .padding(.bottom, 30)
                
                Image(imgFile)
                    .resizable()
                    .frame(maxWidth: .infinity)
                    .frame(height: 350)
                
                ZStack {
                    VStack (alignment: .leading) {
                        HStack {
                            Text(dishName)
                                .font(.custom(llFonts.textFont,
                                              fixedSize: llFonts.sectionSize))
                                .fontWeight(.bold)
                                .foregroundColor(llBlack)
                            Spacer()
                            Text(dish.formatPrice())
                                .font(.custom(llFonts.textFont,
                                              fixedSize: llFonts.cardSize))
                                .fontWeight(.semibold)
                                .foregroundColor(llBlack)
                        }
                        
                        
                        Rectangle()
                            .stroke(.black, lineWidth: 1)
                            .border(llOrange, width: 1)
                            .frame(width: cardWidth - 50, height: 2)
                        
                        Text(dishDesc)
                            .font(.custom(llFonts.textFont,
                                          fixedSize: llFonts.regularSize))
                            .fontWeight(.medium)
                            .foregroundColor(llBlack)
                        
                    }
                    .padding([.leading, .trailing], 15)
                    .frame(width: cardWidth - 20, height: cardHeight - 20)
                    .border(llOrange, width: 3)
                }
                .frame(width: cardWidth, height: cardHeight)
                .background(llWhite)
                //.padding(.bottom, 10)
                
                Button(action: {
                    showOrderAlert.toggle()
                }, label: {
                    Text("Order dish")
                        .font(.custom(llFonts.textFont,
                                      fixedSize: llFonts.cardSize))
                        .fontWeight(.bold)
                })
                .padding(10)
                .font(.system(size: 20))
                .fontWeight(.semibold)
                .foregroundColor(llYellow)
                .background(llGreen)
                .cornerRadius(10)
                .alert("Order placed. Thank you.",
                       isPresented: $showOrderAlert) {
                    Button("OK", role: .cancel) { }
                }
                /*
                .alert(isPresented: $showOrderAlert) {
                    Alert(title: Text("Order confirmation"),
                          message: Text("Dish ordered placeholder"))
                }*/

                
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        }
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

struct DishDetailsView_Previews: PreviewProvider {
    static let context = PersistenceController.shared.container.viewContext
    //let dish = Dish(context: context)
    static var previews: some View {
        DishDetailsView(getSampleDish())
    }
    /*
    static func oneDish() -> Dish {
        let dish = Dish(context: context)
        dish.name = "Hummus"
        dish.price = 10
        dish.size = "Extra Large"
        dish.category = "Appetizer"
        dish.descr = "Our delicious hummus, made fresh daily. Served with garlic pita chips"
        return dish
    }
     */
}
