//  HeroSearch.swift: Search component. Not used

import SwiftUI


struct HeroSearch: View {
    @State private var searchText: String = ""
    @State private var showCancelButton: Bool = false
    
    var body: some View {
    
        VStack (alignment: .leading, spacing: 0){
            TextField("Search...",
                      text: $searchText,
                      onEditingChanged: { isEditing in  self.showCancelButton = true
            }, onCommit: {
                print("onCommit")
            })
                .frame(maxWidth: .infinity)
                .frame(height: 30)
                .background(backgroundMainColor)
                .padding([.trailing], 10)
        }
        .frame(maxWidth: .infinity)
        .frame(height: Dims.search)
        .padding([.leading, .bottom], 10)
        .padding(.top, -10)
        .background(Color(hex: MainColors.green))
        
        if showCancelButton {
            
        }
        
    }
}

#Preview {
    HeroSearch()
}
