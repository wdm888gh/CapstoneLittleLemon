// Primary menu dish page/container view
import SwiftUI
import CoreData

struct OurDishesView: View {
    //@Environment(\.managedObjectContext) private var viewContext
    //@ObservedObject var dishesModel = DishesModel()
    
    @State var profilePic: String =
        UserDefaults.standard.string(forKey: "profile pic") ?? "dishImg_NoImage"
    @State var showCategoryAlert = false
    @State var searchText = ""
    
    let categories = getAllMenuCategoryStrings()
    let sortOptions = ["Most Popular", "Price", "A-Z"]
    // State vars, if initialized, should be done inline and use global vars
    @State var selectedCategories = loadSelectedCategories()
    @State var selectedCategoryStr: [String] =
                                    getAllMenuCategoryStrings()
    @State var selectedSortOption = "Most Popular"
    @State var showingDishDetails = false
    @State var showingReservations = false
    
    let userKeys = UserKeys()
    
    var body: some View {
        
        var selectedDish: Dish = Dish()  // Raises an error flag, but doesn't matter

        VStack {
            //LittleLemonLogoHeader(profilePic: $profilePic)
            
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
            
            Hero()
            
            NavigationStack {
                VStack (spacing: 0) {
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack (spacing: 20) {
                            ForEach(categories,
                                    id:\.self) { category in
                                Text(category)
                                    .padding(7)
                                    .font(.custom(llFonts.textFont,
                                                  fixedSize: llFonts.regularSize))
                                    .foregroundColor(.black)
                                    .background(selectedCategories.contains(category) ?
                                                llYellow :
                                            .gray.opacity(0.5))
                                    .cornerRadius(10)
                                    .contentShape(Rectangle())
                                    .onTapGesture {
                                        toggleCategorySelection(category)
                                    }
                                /*
                                 .alert(isPresented: $showCategoryAlert) {
                                 Alert(title: Text("Select Menu Category"),
                                 message: Text("At least one menu category must remain selected"),
                                 dismissButton: .cancel())
                                 } */
                                
                            } // End ForEach
                        } // End HStack
                        .padding(.leading, 10)
                        .frame(height: 75)
                        
                    } // End ScrollView
                    .padding(.top, -10)
                    
                    ScrollView {
                        FetchedObjects(
                            predicate:buildPredicate(),
                            sortDescriptors: buildSortDescriptors()) {
                                (dishes: [Dish]) in
                                
                                ForEach(selectedCategoryStr, id: \.self) { category in
                                    let filteredDishes = dishes.filter { (dish) -> Bool in dish.category == category }
                                    
                                    if filteredDishes.count > 0 {
                                        Text(category)
                                            .font(.custom(llFonts.textFont,
                                                          fixedSize: llFonts.sectionSize))
                                            .fontWeight(.bold)
                                        
                                        LazyVStack {
                                            ForEach(filteredDishes, id: \.id) { filteredDish in
                                                DishPreviewView(filteredDish)
                                                    .contentShape(.rect)
                                                    .onTapGesture {
                                                        showingDishDetails = true
                                                        // Stores currently selected Dish
                                                        selectedDish = filteredDish
                                                    }
                                                    .sheet(isPresented: $showingDishDetails) {
                                                        //DishDetailsView(filteredDish)
                                                        
                                                        /* There is a 'lag' between when onTapGesture is
                                                         triggered and the selected filteredDish vs
                                                         when the .Sheet() event is triggered which
                                                         means in most cases, the filteredDish
                                                         sent to DishDetailsView will be different
                                                         than the one we selected */
                                                        DishDetailsView(selectedDish)
                                                    }
                                            }
                                        } // End LazyVStack
                                        
                                        /* Using NavigationLink instead of sheet
                                         LazyVStack {
                                         ForEach(filteredDishes, id: \.id) { filteredDish in
                                         NavigationLink (destination:
                                         DishDetailsView(filteredDish)) {
                                         DishPreviewView(filteredDish)
                                         }
                                         }
                                         }
                                         */
                                    } // End if filteredDishes
                                    
                                } // End ForEach
                                
                                
                            } // End Fetched Objects
                            .searchable(text: $searchText, placement:
                                    .navigationBarDrawer(displayMode: .always),
                                        prompt: "search menu..."
                            )
                        
                    } // End ScrollView
                    
                } // End VStack
                
            }
            /* SwiftUI has this space between the title and the list that is amost impossible to remove without incurring into complex steps that run out of the scope of this course, so, this is a hack, to bring the list up try to comment this line and see what happens. */
            .padding(.top, -10)//
            
            // makes the list background invisible.
            // default is gray
            .scrollContentBackground(.hidden)

            // End NavigationView
        }

    } // End Body
    
    private func getKeys(_ keys: [String?]) -> [String] {
        var tmpStr: [String] = []
        keys.forEach { key in
            tmpStr.append(key!)
        }
        return tmpStr
    }
    
    private func buildPredicate() -> NSPredicate {
        
        let searchPredicate = searchText == "" ?
        NSPredicate(value: true) :
        NSPredicate(format: "name CONTAINS[cd] %@", searchText)
        
        let categoryPredicate = NSPredicate(format:
                                                "category IN %@", selectedCategories)
        
        return NSCompoundPredicate(type: .and,
                                   subpredicates: [
                                    searchPredicate,
                                    categoryPredicate
                                   ])
    }
    
    private func buildSortDescriptors() -> [NSSortDescriptor] {
        [NSSortDescriptor(key: "name",
                          ascending: true,
                          selector:
                            #selector(NSString.localizedStandardCompare))]
    }
    
    private func toggleCategorySelection(_ category: String) {
        if selectedCategories.contains(category) {
            if selectedCategories.count > 1 {
                selectedCategories.remove(category)
                selectedCategoryStr =
                    getCategoryStringsFromSet(selectedCategories)
            } else {
                showCategoryAlert.toggle()
            }
        } else {
            selectedCategories.insert(category)
            selectedCategoryStr =
                getCategoryStringsFromSet(selectedCategories)
        }
    }
    
}

struct OurDishesView_Previews: PreviewProvider {
    static var previews: some View {
        OurDishesView()
    }
}






