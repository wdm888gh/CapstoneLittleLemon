// Login View
import SwiftUI


struct LoginView: View {
    //@EnvironmentObject var model:Model
    @ObservedObject var authManager: AuthManager
    
    @State var profilePic: String =
        // "dishImg_NoImage1" deliberately misnamed so
        // profile pic doesn't appear if no profile
        UserDefaults.standard.string(forKey: "profile pic") ?? "dishImg_NoImage"
    @State private var firstName: String = ""
    @State private var lastName: String = ""
    @State private var email: String = ""
    //@State private var temporaryProfile = Profile()
    @State private var formComplete = false
    let userKeys = UserKeys()
    
    @State private var showFormInvalidMessage = false
    @State private var errorMessage = ""

    /*  presentationMode is deprecated, but still works
     ----------------------------------------------------
     This environment variable stores the presentation mode status of this view. This will be used to dismiss this view when the user taps on the RESERVE */
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    /* For use when using .sheet */
    //@Environment(\.dismiss) var dismiss

    
    var body: some View {
        VStack {
            LittleLemonLogoHeader(profilePic: $profilePic)
                .padding(.bottom, 10)
            Hero()
            
            VStack (alignment: .leading) {
                //Line
                Text("First name*")
                    .frame(maxWidth: .infinity)
                    .frame(height: 30)
                    .foregroundColor(llWhite)
                    .background(llGreen)
                
                TextField("First name...", text: $firstName)
                    .disableAutocorrection(true)
                    .frame(maxWidth: .infinity)
                    .frame(height: 30)
                    .background(.white)
                //Line
                
                Text("Last name*")
                    .frame(maxWidth: .infinity)
                    .frame(height: 30)
                    .foregroundColor(llWhite)
                    .background(llGreen)
                TextField("Last name...", text: $lastName)
                    .disableAutocorrection(true)
                    .frame(maxWidth: .infinity)
                    .frame(height: 30)
                    .background(.white)
                //Line
                
                Text("E-Mail*")
                    .frame(maxWidth: .infinity)
                    .frame(height: 30)
                    .foregroundColor(llWhite)
                    .background(llGreen)
                TextField("E-Mail...", text: $email)
                    .keyboardType(.emailAddress)
                    .textContentType(.emailAddress)
                    .disableAutocorrection(true)
                    .autocapitalization(.none)
                    .frame(maxWidth: .infinity)
                    .frame(height: 30)
                    .background(.white)
                //Line
                
                
                HStack {
                    Spacer()  // Used to center button
                    
                    Button(action: {
                        validateForm()
                    }, label: {
                        Text("Register")
                    })
                    .padding(.init(top: 10, leading: 30, bottom: 10, trailing: 30))
                    .font(.system(size: 20))
                    .fontWeight(.semibold)
                    .foregroundColor(llGreen)
                    .background(llYellow)
                    .cornerRadius(20)
                    .padding(.top, 10)
                    
                    Spacer()
                }
                
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(20)
            .font(.custom(llFonts.textFont,
                  fixedSize: llFonts.regularSize))
            .foregroundColor(llBlack)
            
        }
        .background(backgroundMainColor)
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
        .alert(isPresented: $showFormInvalidMessage) {
            Alert(title: Text("Login Form Error"), message: Text(errorMessage))
        }
        .onChange(of: formComplete) { _ in
            //model.profile = temporaryProfile
            //print("VStack.onChange: formComplete: \(formComplete)")
            //print("   model.loggedIn: \(model.loggedIn)")
        }
    }
    
    var Line: some View {
        VStack {
            Divider()
                .background(.gray)
                .padding(.bottom, 5)
        }
    }
    
    private func validateForm() {
        
        // customerName must contain just letters
        let firstNameIsValid = isValid(name: firstName)
        let lastNameIsValid = isValid(name: lastName)
        let emailIsValid = isValid(email: email)
        
        guard firstNameIsValid && lastNameIsValid && emailIsValid
        else {
            var invalidFirstNameMessage = ""
            if !firstNameIsValid {
                if firstName.isEmpty {
                    print("First name empty")
                } else {
                    print ("First name invalid")
                }
                invalidFirstNameMessage = "Names can only contain letters and must have at least 3 characters\n\n"
            }
            
            var invalidLastNameMessage = ""
            if !lastNameIsValid {
                if lastName.isEmpty {
                    print("Last name empty")
                } else {
                    print ("Last name invalid")
                }
                invalidLastNameMessage = "Names can only contain letters and must have at least 3 characters\n\n"
            }
            
            var invalidEmailMessage = ""
            if !emailIsValid {
                if email.isEmpty {
                    print("E-mail empty")
                } else {
                    print("E-mail invalid")
                }
                invalidEmailMessage = "The e-mail is invalid and cannot be blank."
            }
            
            self.errorMessage = "Found these errors in the form:\n\n\(invalidFirstNameMessage)\(invalidLastNameMessage)\(invalidEmailMessage)"
            
            showFormInvalidMessage.toggle()
            return
        }
        
        // ********************************
        // Login form is valid:
        // - Store profile
        // - Update vars to dismiss form
        // ********************************
        
        /*
        let tempProfile = Profile(firstName: firstName,
                                  lastName: lastName,
                                  email: email)
        self.temporaryProfile = tempProfile
        model.loggedIn = true
         */
         
        UserDefaults.standard.set(firstName, forKey: userKeys.kFirstName)
        UserDefaults.standard.set(lastName, forKey: userKeys.kLastName)
        UserDefaults.standard.set(email, forKey: userKeys.kEmail)
        UserDefaults.standard.set("", forKey: userKeys.kPhoneNumber)
        UserDefaults.standard.set("ProfileImage_Tilly2", forKey: userKeys.kProfilePic)
        UserDefaults.standard.set(true, forKey: userKeys.kEmailNotifyOrder)
        UserDefaults.standard.set(true, forKey: userKeys.kEmailNotifyPassword)
        UserDefaults.standard.set(true, forKey: userKeys.kEmailNotifySpecial)
        UserDefaults.standard.set(true, forKey: userKeys.kEmailNotifyNews)
        //UserDefaults.standard.set(true, forKey: userKeys.kIsLoggedIn)
        authManager.login()
        
        // For console verification
        print("\nLogin form valid")
        print(UserDefaults.standard.string(forKey: userKeys.kFirstName)!)
        print(UserDefaults.standard.string(forKey: userKeys.kLastName)!)
        print(UserDefaults.standard.string(forKey: userKeys.kEmail)!)
        print("Logged in: \(UserDefaults.standard.bool(forKey: userKeys.kIsLoggedIn))")
        
        self.formComplete = true
        //dismiss()
        self.presentationMode.wrappedValue.dismiss()
    }
    
    func isValid(name: String) -> Bool {
        guard !name.isEmpty,
              name.count > 2
        else { return false }
        for chr in name {
            if (!(chr >= "a" && chr <= "z") && !(chr >= "A" && chr <= "Z") && !(chr == " ") ) {
                return false
            }
        }
        return true
    }
    
    func isValid(email:String) -> Bool {
        guard !email.isEmpty else { return false }
        let emailValidationRegex = "^[\\p{L}0-9!#$%&'*+\\/=?^_`{|}~-][\\p{L}0-9.!#$%&'*+\\/=?^_`{|}~-]{0,63}@[\\p{L}0-9-]+(?:\\.[\\p{L}0-9-]{2,7})*$"
        let emailValidationPredicate = NSPredicate(format: "SELF MATCHES %@", emailValidationRegex)
        return emailValidationPredicate.evaluate(with: email)
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        //LoginView().environmentObject(Model())
        
        LoginView(authManager: authManager())
    }
    static func authManager() -> AuthManager {
        let aM = AuthManager()
        return aM
    }
}
