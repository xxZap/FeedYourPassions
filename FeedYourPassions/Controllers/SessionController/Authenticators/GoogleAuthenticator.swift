//
//  GoogleAuthenticator.swift
//  FeedYourPassions
//
//  Created by Alessio Boerio on 01/06/24.
//

import Firebase
import GoogleSignIn

class GoogleAuthenticator {

    func authenticate(completion: @escaping ((Result<AuthCredential, Error>) -> Void)) {
        guard let presentingViewController = (UIApplication.shared.connectedScenes.first as? UIWindowScene)?.windows.first?.rootViewController else {
            print("❌ Authentication with GoogleSignIn failed: no presenting view controller found")
            completion(.failure(NSError()))
            return
        }

        guard let clientID = FirebaseApp.app()?.options.clientID else {
            print("❌ Authentication with GoogleSignIn failed: no firebase cliend ID found")
            completion(.failure(NSError()))
            return
        }

        let config = GIDConfiguration(clientID: clientID)
        GIDSignIn.sharedInstance.configuration = config

        GIDSignIn.sharedInstance.signIn(withPresenting: presentingViewController) { signInResult, error in
            if let error {
                print("❌ Authentication with GoogleSignIn failed: \(error)")
                completion(.failure(error))
                return
            }

            guard
                let user = signInResult?.user,
                let idToken = user.idToken?.tokenString
            else {
                print("❌ Authentication with GoogleSignIn failed")
                completion(.failure(NSError()))
                return
            }

            let credential = GoogleAuthProvider.credential(
                withIDToken: idToken,
                accessToken: user.accessToken.tokenString
            )

            print("✅ Authentication with GoogleSignIn succeeded. Got credential")
            completion(.success(credential))
        }
    }
}
