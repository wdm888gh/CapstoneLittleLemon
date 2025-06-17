// Displays each individual dish with details (name, description, price, image)
import SwiftUI


struct DishPreviewView: View {
    @ObservedObject private var dish: Dish
    
    // To accept @ObservedObject parameter
    init(_ dish: Dish) {
        self.dish = dish
    }
    
    var body: some View {
        HStack (spacing: 0) {
            let dishName = dish.name ?? "NoName"
            
            VStack (alignment: .leading) {
                Text(dishName)
                    .font(.custom(llFonts.textFont,
                                  fixedSize: llFonts.cardSize))
                    .fontWeight(.semibold)
                    .foregroundColor(llBlack)
                Text(dish.formatPrice())
                    .font(.custom(llFonts.textFont,
                                  fixedSize: llFonts.cardSize))
                    .foregroundColor(llBlack)
            }
            Spacer()
            
            let imgFile = dishImgFile[dishName] ?? "dishImg_NoImage"
            Image(imgFile)
                .resizable()
                .frame(width: 60, height: 50)
                .cornerRadius(5)
            
            
            /* Old, but keeping just in case
            VStack (alignment: .leading) {
                Text(dishName)
                    .font(.custom(llFonts.textFont,
                                  fixedSize: llFonts.cardSize))
                    .fontWeight(.bold)
                Text(dish.descr ?? "Description")
                    .font(.custom(llFonts.textFont,
                                  fixedSize: llFonts.regularSize))
                Text(dish.formatPrice())
                    .font(.custom(llFonts.textFont,
                                  fixedSize: llFonts.cardSize))
                    .fontWeight(.bold)
                
            }

            Spacer()
            
            let imgFile = dishImgFile[dishName] ?? "dishImg_NoImage"
            Image(imgFile)
                .resizable()
                .frame(width: 120, height: 100)
                .cornerRadius(10)
            */
            
        }
        .padding([.leading, .trailing], 10)
        .contentShape(Rectangle())
        
    }
}

struct DishPreviewView_Previews: PreviewProvider {
    static let context = PersistenceController.shared.container.viewContext
    let dish = Dish(context: context)
    static var previews: some View {
        DishPreviewView(oneDish())
    }
    static func oneDish() -> Dish {
        let dish = Dish(context: context)
        dish.name = "Hummus"
        dish.price = 10
        dish.size = "Extra Large"
        dish.category = "Appetizer"
        dish.descr = "Our delicious hummus, made fresh daily. Served with garlic pita chips"
        return dish
    }
}

