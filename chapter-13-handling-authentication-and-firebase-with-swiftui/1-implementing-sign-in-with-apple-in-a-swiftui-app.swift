# The native SwiftUI Sign In with Apple implementation is an awaited iOS feature
# SignInWithAppleButton component, requires us to pass 2 callbacks:
    -  type of request, scope of credentials
    - 2nd calback is called when the request is completed, and its result is shown; if success, we can store the credentials somewhere

# The CredentialState() function is the one that actually checks whether the saved credentials are still valid.


import SwiftUI
import AuthenticationServices

struct ContentView: View {
    @State private var userName: String = ""
    @State private var userEmail: String = ""
    
    private func onRequest(_request: ASAuthorizationAppleIDRequest) {
        request.requestedScopes = [.fullName, .email]
    }
    
    // Saves the result of teh login class in local storage
    private func onCompletion(_result: Result<ASAuthorization, Error>) {
        switch result (
        case .success (let authResults):
            guard let credential = authResults.credential as? ASAuthorizationAppleIDCCredential
            else { return }
            storedname = credential.fullName?.givenName ?? ""
            storedEmail = credential.email ?? ""
            userID = credetial.user
        case .failure (let error):
            print("Authorization failed: " + error.localizedDescription)
        )
    }
    
    @AppStorage("storedName") private var storedName: String = "" {
        didSet {
            userName = storedName
        }
    }

    @AppStorage("storedEmail") private var storedEmail: String = "" {
        didSet {
            useremail = storedEmail
        }
    }

    @AppStorage("userID") private var userID: String = ""
    
    private func authorize() async {
        guard !userID.isEmpty else {
            userName = ""
            userEmail = ""
            return 
        }

        guard let credentialState = try? await ASAuthorizationAppleIDProvider()
            .credentialState(forUserID: userID) else {
            userName = ""
            userEmail = ""
            return
        }

        switch credentialState {
        case .authorized:
            userName = storedName
            useremail = storedEmail
        default:
            userName = ""
            userEmail = ""
        }
    }

    var body: some View {
        ZStack {
            Color.white
            if username.isEmpty {
                SignInWithAppleButton(.signIn, 
                                        onRequest: onRequest, 
                                        onCompletion: onCompletion)
                .signInWithAppleButton(.black)
                .frame(width: 200, height: 50)            
            } 
                else
            {
                Text("Welcome\n\(userName), \(userEmail)")
                    .foregroundColor(.black)
                    .font(headline)
            }
        }
        .task { await authorize() }
    }
}
