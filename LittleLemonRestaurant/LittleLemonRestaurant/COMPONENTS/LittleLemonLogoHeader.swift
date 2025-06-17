//
//  LittleLemonLogoHeader.swift
//  LittleLemonLogoHeader

import SwiftUI


struct LittleLemonLogoHeader: View {
    
    @Binding var profilePic: String
    let userKeys = UserKeys()
    
    var body: some View {
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
        
        //UserDefaults.standard.string(forKey: userKeys.kProfilePic
        
        /*
        Image("littleLemon")
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: 200)
         */
    }
}

struct LittleLemonLogoHeader_Previews: PreviewProvider {
    @State static var profilePic: String = "ProfileImage_Tilly2"
    
    static var previews: some View {
        LittleLemonLogoHeader(profilePic: $profilePic)
    }
}

