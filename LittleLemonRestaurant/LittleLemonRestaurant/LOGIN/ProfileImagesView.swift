//  ProfileImagesView.swift

import SwiftUI

struct ProfileImagesView: View {
    @Environment(\.dismiss) var dismiss
    
    @Binding var profilePic: String
    @Binding var avatarNum: Int
    
    let screenWidth: CGFloat = UIScreen.main.bounds.width
    let screenHeight: CGFloat = UIScreen.main.bounds.height
    let imageDim: CGFloat = 150
    let halo: CGFloat = 20
    
    let backgroundColor = Color.gray.opacity(0.3)
    let highlightColor = Color.orange
    
    var body: some View {
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
                Image("littleLemon")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 200)
                
                VStack {
                    Text("Select an avatar")
                        .font(.custom(llFonts.textFont,
                                      fixedSize: llFonts.subtitleSize2))
                        .fontWeight(.bold)
                
                    HStack (spacing: 20) {
                        ZStack {
                            Circle()
                                .fill(avatarNum == 0 ? highlightColor : backgroundColor)
                                .frame(width: imageDim + halo, height: imageDim + halo)
                                
                            Image("ProfileImage_Tilly2")
                                .resizable()
                                .frame(width: imageDim, height: imageDim)
                                .onTapGesture {
                                    if avatarNum != 0 {
                                        avatarNum = 0
                                        profilePic =
                                        getProfilePic(avatarNum: avatarNum)
                                    }
                                }
                        }
                         
                        ZStack {
                            Circle()
                                .fill(avatarNum == 1 ? highlightColor : backgroundColor)
                                .frame(width: imageDim + halo, height: imageDim + halo)
                            
                            Image("ProfileImage_Rob")
                                .resizable()
                                .frame(width: imageDim, height: imageDim)
                                .onTapGesture {

                                    if avatarNum != 1 {
                                        avatarNum = 1
                                        profilePic =
                                        getProfilePic(avatarNum: avatarNum)
                                    }
                                }
                        }
                    }
                    .padding(.bottom, 10)
                    
                    HStack (spacing: 20) {
                        ZStack {
                            Circle()
                                .fill(avatarNum == 2 ? highlightColor : backgroundColor)
                                .frame(width: imageDim + halo, height: imageDim + halo)
                                
                            Image("ProfileImage_Declan")
                                .resizable()
                                .frame(width: imageDim, height: imageDim)
                                .onTapGesture {
                                    if avatarNum != 2 {
                                        avatarNum = 2
                                        profilePic =
                                        getProfilePic(avatarNum: avatarNum)
                                    }
                                }
                        }
                         
                        ZStack {
                            Circle()
                                .fill(avatarNum == 3 ? highlightColor : backgroundColor)
                                .frame(width: imageDim + halo, height: imageDim + halo)
                            
                            Image("ProfileImage_Emma")
                                .resizable()
                                .frame(width: imageDim, height: imageDim)
                                .onTapGesture {
                                    if avatarNum != 3 {
                                        avatarNum = 3
                                        profilePic =
                                        getProfilePic(avatarNum: avatarNum)
                                    }
                                }
                        }
                    }
                    .padding(.bottom, 10)
                    
                    HStack (spacing: 20) {
                        ZStack {
                            Circle()
                                .fill(avatarNum == 4 ? highlightColor : backgroundColor)
                                .frame(width: imageDim + halo, height: imageDim + halo)
                                
                            Image("ProfileImage_Anisa")
                                .resizable()
                                .frame(width: imageDim, height: imageDim)
                                .onTapGesture {
                                    if avatarNum != 4 {
                                        avatarNum = 4
                                        profilePic =
                                        getProfilePic(avatarNum: avatarNum)
                                    }
                                }
                        }
                         
                        ZStack {
                            Circle()
                                .fill(avatarNum == 5 ? highlightColor : backgroundColor)
                                .frame(width: imageDim + halo, height: imageDim + halo)
                            
                            Image("ProfileImage_Javier")
                                .resizable()
                                .frame(width: imageDim, height: imageDim)
                                .onTapGesture {
                                    if avatarNum != 5 {
                                        avatarNum = 5
                                        profilePic =
                                        getProfilePic(avatarNum: avatarNum)
                                    }
                                }
                        }
                    }
                    
                }
                .frame(width: screenWidth, height: 600)
                .background(backgroundColor)
                
            }
            .padding(.top, 10)
            .padding(.bottom, 30)
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
    
    private func getProfilePic(avatarNum: Int) -> String {
        switch avatarNum {
        case 0:
            return "ProfileImage_Tilly2"
        case 1:
            return "ProfileImage_Rob"
        case 2:
            return "ProfileImage_Declan"
        case 3:
            return "ProfileImage_Emma"
        case 4:
            return "ProfileImage_Anisa"
        case 5:
            return  "ProfileImage_Javier"
        default:
            return "dishImg_NoImage"
        }
    }
    
}

struct ProfileImagesView_Previews: PreviewProvider {
    @State static var profilePic: String = "ProfileImage_Tilly2"
    @State static var avatarNum: Int = 0
    
    static var previews: some View {
        ProfileImagesView(profilePic: $profilePic,
                          avatarNum: $avatarNum)
    }
}


