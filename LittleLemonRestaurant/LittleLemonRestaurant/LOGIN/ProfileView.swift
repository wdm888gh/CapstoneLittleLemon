// ProfileView
import SwiftUI

struct ProfileView: View {
    @ObservedObject var authManager: AuthManager
    
    @State private var firstName: String =         UserDefaults.standard.string(forKey: "first name key") ?? ""
    @State private var lastName: String =
        UserDefaults.standard.string(forKey: "last name key") ?? ""
    @State private var email: String =
        UserDefaults.standard.string(forKey: "email key") ?? ""
    @State private var phoneNumber: String =
        UserDefaults.standard.string(forKey: "phone number") ?? ""
    @State private var profilePic: String =
        UserDefaults.standard.string(forKey: "profile pic") ?? "dishImg_NoImage"
    @State private var orderStatus: Bool =
        UserDefaults.standard.bool(forKey: "email notify order")
    @State private var passwordChange: Bool =
        UserDefaults.standard.bool(forKey: "email notify password")
    @State private var specialOffers: Bool =
        UserDefaults.standard.bool(forKey: "email notify special")
    @State private var newsletter: Bool =
        UserDefaults.standard.bool(forKey: "email notify news")
    @State private var userKeys = UserKeys()
    
    // avatar number of profile pic. We don't need to give
    // it a value until we pass it to ProfileImageVew()
    @State private var avatarNum: Int = 0
    @State private var showingProfileImages = false
    @State private var saveChanges = false
    //@State private var temporaryProfile = Profile()

    let screenWidth: CGFloat = UIScreen.main.bounds.width
    let screenHeight: CGFloat = UIScreen.main.bounds.height
    
    var body: some View {
                
        VStack {
            VStack {
                //LittleLemonLogoHeader(profilePic: $profilePic)
                
                // Repeating code so that profile pic is updated
                // Figure out a better way later.
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
                Rectangle()
                    .stroke(.gray.opacity(0.3), lineWidth: 1)
                    .frame(width: screenWidth - 40, height: 1)
            }
            
            ScrollView {
                VStack (alignment: .leading) {
                    Text("Personal Information")
                        .font(.custom(llFonts.textFont,
                                      fixedSize: llFonts.subtitleSize2))
                        .fontWeight(.bold)
                        //.padding([.top, .bottom], 10)
                    
                    HStack (spacing: 40){
                        Image(profilePic)
                            .resizable()
                            .frame(width: 70, height: 70)
                        
                        Button(action: {
                            showingProfileImages.toggle()
                            avatarNum = getAvatarNum(profilePic: profilePic)
                        }, label: {
                            Text("Change")
                                .font(.custom(llFonts.textFont,
                                              fixedSize: llFonts.cardSize))
                                .fontWeight(.bold)
                            
                        })
                        //.padding(.init(top: 10, leading: 30, bottom: 10, trailing: 30))
                        .padding(10)
                        .font(.system(size: 20))
                        .fontWeight(.semibold)
                        .foregroundColor(llYellow)
                        .background(llGreen)
                        .cornerRadius(10)
                        .sheet(isPresented: $showingProfileImages) {
                            ProfileImagesView(profilePic: $profilePic,
                                              avatarNum: $avatarNum)
                        }
                        
                        Button(action: {
                            profilePic = "dishImg_NoImage"
                        }, label: {
                            Text("Remove")
                                .font(.custom(llFonts.textFont,
                                              fixedSize: llFonts.cardSize))
                                .fontWeight(.bold)
                            
                        })
                        //.padding(.init(top: 10, leading: 30, bottom: 10, trailing: 30))
                        .padding(10)
                        .font(.system(size: 20))
                        .fontWeight(.semibold)
                        .foregroundColor(llYellow)
                        .background(llGreen)
                        .cornerRadius(10)
                    } // End profile HStack
                    
                    Text("First name")
                        .font(.custom(llFonts.textFont,
                                      fixedSize: llFonts.cardSize))
                        .fontWeight(.medium)
                        .padding(.bottom, -5)
                    ProfileTextField(profileProp: $firstName, propertyKey: $userKeys.kFirstName)
                    
                    Text("Last name")
                        .font(.custom(llFonts.textFont,
                                      fixedSize: llFonts.cardSize))
                        .fontWeight(.medium)
                        .padding(.bottom, -5)
                    ProfileTextField(profileProp: $lastName, propertyKey: $userKeys.kLastName)
                    
                    Text("E-mail")
                        .font(.custom(llFonts.textFont,
                                      fixedSize: llFonts.cardSize))
                        .fontWeight(.medium)
                        .padding(.bottom, -5)
                    ProfileTextField(profileProp: $email, propertyKey: $userKeys.kEmail)
                    
                    Text("Phone number")
                        .font(.custom(llFonts.textFont,
                                      fixedSize: llFonts.cardSize))
                        .fontWeight(.medium)
                        .padding(.bottom, -5)
                    ProfileTextField(profileProp: $phoneNumber, propertyKey: $userKeys.kPhoneNumber)
                    
                    Text("Email Notifications")
                        .font(.custom(llFonts.textFont,
                                      fixedSize: llFonts.sectionSize))
                        .fontWeight(.bold)
                        //.padding([.top], 10)
                        .padding(.bottom, -5)
                    
                    VStack  {
                        HStack {
                            Toggle(isOn: $orderStatus) {
                                Text("Order status")
                                    .font(.custom(llFonts.textFont,
                                                  fixedSize: llFonts.cardSize))
                                    .fontWeight(.medium)
                            }
                            .toggleStyle(.switch)
                            Toggle(isOn: $passwordChange) {
                                Text("Password changes")
                                    .font(.custom(llFonts.textFont,
                                                  fixedSize: llFonts.cardSize))
                                    .fontWeight(.medium)
                            }
                            .toggleStyle(.switch)
                        }
                        HStack {
                            Toggle(isOn: $specialOffers) {
                                Text("Special offers")
                                    .font(.custom(llFonts.textFont,
                                                  fixedSize: llFonts.cardSize))
                                    .fontWeight(.medium)
                            }
                            .toggleStyle(.switch)
                            Toggle(isOn: $newsletter) {
                                Text("Newsletter")
                                    .font(.custom(llFonts.textFont,
                                                  fixedSize: llFonts.cardSize))
                                    .fontWeight(.medium)
                            }
                            .toggleStyle(.switch)
                        }
                    } // End Toggle VStack
                    .padding(.bottom, 10)
                    
                    HStack (spacing: 40){
                        Button(action: {
                            DiscardChanges()
                        }, label: {
                            Text("Discard Changes")
                                .font(.custom(llFonts.textFont,
                                              fixedSize: llFonts.cardSize))
                                .fontWeight(.bold)
                            
                        })
                        //.padding(.init(top: 10, leading: 30, bottom: 10, trailing: 30))
                        .padding(10)
                        .font(.system(size: 20))
                        .fontWeight(.semibold)
                        .foregroundColor(llYellow)
                        .background(llGreen)
                        .cornerRadius(10)
                        
                        Button(action: {
                            SaveChanges()
                            saveChanges.toggle()
                        }, label: {
                            Text("Save Changes")
                                .font(.custom(llFonts.textFont,
                                              fixedSize: llFonts.cardSize))
                                .fontWeight(.bold)
                            
                        })
                        .alert("Profile changes saved.",
                               isPresented: $saveChanges) {
                            Button("OK", role: .cancel) { }
                        }
                        //.padding(.init(top: 10, leading: 30, bottom: 10, trailing: 30))
                       .padding(10)
                       .font(.system(size: 20))
                       .fontWeight(.semibold)
                       .foregroundColor(llYellow)
                       .background(llGreen)
                       .cornerRadius(10)
                    } // End profile HStack
                    
                }
                .padding([.leading, .trailing, .bottom], 20)
                
                Button(action: {
                    // Log out
                    logOut()
                }, label: {
                    Text("Log out")
                        .font(.custom(llFonts.textFont,
                                      fixedSize: llFonts.cardSize))
                        .fontWeight(.bold)
                    
                })
                .frame(width: screenWidth - 40, height: 40)
                //.padding(10)
                .font(.system(size: 20))
                .fontWeight(.semibold)
                .foregroundColor(llBlack)
                .background(llYellow)
                .cornerRadius(10)
                //.padding(.bottom, 30)

            } // End ScrollView
            
        } // End VStack
        //.frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
    }
    
    // DiscardChanges
    private func DiscardChanges() {
        firstName = UserDefaults.standard.string(forKey: "first name key") ?? ""
        lastName = UserDefaults.standard.string(forKey: "last name key") ?? ""
        email = UserDefaults.standard.string(forKey: "email key") ?? ""
        phoneNumber = UserDefaults.standard.string(forKey: "phone number") ?? ""
        profilePic = UserDefaults.standard.string(forKey: "profile pic") ?? "dishImg_NoImage"
        orderStatus = UserDefaults.standard.bool(forKey: "email notify order")
        passwordChange = UserDefaults.standard.bool(forKey: "email notify password")
        specialOffers = UserDefaults.standard.bool(forKey: "email notify special")
        newsletter = UserDefaults.standard.bool(forKey: "email notify news")
    }
    
    // Save changes to UserDefaults
    private func SaveChanges() {
        UserDefaults.standard.set(firstName, forKey: userKeys.kFirstName)
        UserDefaults.standard.set(lastName, forKey: userKeys.kLastName)
        UserDefaults.standard.set(email, forKey: userKeys.kEmail)
        UserDefaults.standard.set(phoneNumber, forKey: userKeys.kPhoneNumber)
        UserDefaults.standard.set(profilePic, forKey: userKeys.kProfilePic)
        UserDefaults.standard.set(orderStatus, forKey: userKeys.kEmailNotifyOrder)
        UserDefaults.standard.set(passwordChange, forKey: userKeys.kEmailNotifyPassword)
        UserDefaults.standard.set(specialOffers, forKey: userKeys.kEmailNotifySpecial)
        UserDefaults.standard.set(newsletter, forKey: userKeys.kEmailNotifyNews)
    }
    
    // Return avatar number of profile pic
    private func getAvatarNum(profilePic: String) -> Int {
        switch profilePic {
        case "ProfileImage_Tilly2":
            return 0
        case "ProfileImage_Rob":
            return 1
        case "ProfileImage_Declan":
            return 2
        case "ProfileImage_Emma":
            return 3
        case "ProfileImage_Anisa":
            return 4
        case "ProfileImage_Javier":
            return 5
        default:
            return 6
        }
    }
    
    // Log out: Reset UserDefault values
    private func logOut() {
        UserDefaults.standard.set("", forKey: userKeys.kFirstName)
        UserDefaults.standard.set("", forKey: userKeys.kLastName)
        UserDefaults.standard.set("", forKey: userKeys.kEmail)
        UserDefaults.standard.set("", forKey: userKeys.kPhoneNumber)
        UserDefaults.standard.set("", forKey: userKeys.kProfilePic)
        UserDefaults.standard.set(true, forKey: userKeys.kEmailNotifyOrder)
        UserDefaults.standard.set(true, forKey: userKeys.kEmailNotifyPassword)
        UserDefaults.standard.set(true, forKey: userKeys.kEmailNotifySpecial)
        UserDefaults.standard.set(true, forKey: userKeys.kEmailNotifyNews)
        //UserDefaults.standard.set(false, forKey: userKeys.kIsLoggedIn)
        authManager.logout()
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {        
        ProfileView(authManager: authManager())
    }
    static func authManager() -> AuthManager {
        let aM = AuthManager()
        return aM
    }
}

