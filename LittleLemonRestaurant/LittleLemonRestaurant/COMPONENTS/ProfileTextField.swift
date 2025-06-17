// Profile TextField Component
import SwiftUI


struct ProfileTextField: View {
    
    @Binding var profileProp: String
    @Binding var propertyKey: String
    
    var body: some View {
        TextField("",
                  text: $profileProp,
                  prompt: Text(profileProp)
                    .foregroundColor(llBlack))
            .font(.custom(llFonts.textFont,
                          fixedSize: llFonts.regularSize))
            .fontWeight(.medium)
            .disableAutocorrection(true)
            .frame(maxWidth: .infinity)
            .frame(height: 30)
            .background(.white)
            .textFieldStyle(.roundedBorder)
            .border(.black)
            //.padding(.bottom, 10)
    }
}


struct ProfileTextFieldPreviews: PreviewProvider {
    @State static var profileProp: String = "Profile property"
    @State static var propertyKey: String = "first name key"
    
    static var previews: some View {
        ProfileTextField(profileProp: $profileProp, propertyKey: $propertyKey)
    }
}

