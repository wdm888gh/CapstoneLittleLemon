//  Hero.swift: Hero component


import SwiftUI

struct Hero: View {
    var body: some View {
        VStack (alignment: .leading, spacing: 0){
            VStack (alignment: .leading) {
                Text("Little Lemon")
                    .font(.custom(llFonts.titleFont,
                                  fixedSize: llFonts.displaySize))
                    .foregroundColor(llYellow)
                    //.padding(.top, 30)
            }
            
            HStack (alignment: .center, spacing: 0) {
                VStack {
                    Text("Chicago")
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .font(.custom(llFonts.titleFont,
                              fixedSize: llFonts.subtitleSize))
                        .foregroundColor(llWhite)
                        
                    
                    Text("We are a family-owned Mediterranean restaurant, focused on traditional recipes with a modern twist.")
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .font(.custom(llFonts.textFont,
                                      fixedSize: llFonts.regularSize))
                        .foregroundColor(Color(hex: SecondaryColors.lightGrey))
                        .padding(.trailing, 40)
                        
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                
                Image("frontpagepic")
                    .resizable()
                    .frame(width: Dims.imWidth, height: Dims.imHeight)
                    .cornerRadius(10)
                    .padding([.trailing], 10)
            }
            .padding(.bottom, 10)
            

        }
        .frame(maxWidth: .infinity)
        .frame(height: Dims.hero)
        .padding(.leading, 10)
        .background(Color(hex: MainColors.green))
        
    }
}

#Preview {
    Hero()
}
