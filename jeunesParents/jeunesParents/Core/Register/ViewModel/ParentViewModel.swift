import Foundation
import Combine

class ParentViewModel: ObservableObject {
    @Published var parents: [Parent] = []
    @Published var errorMessage: String?
    @Published var isLoading = false
    
    // Variables d'erreur pour chaque champ
    @Published var emailError = ""
    @Published var motDePasseError = ""
    @Published var nomError = ""
    @Published var prenomError = ""
    @Published var token: String?  // Ajouter la variable pour stocker le token
    
    private var cancellables = Set<AnyCancellable>()
    
    func addParent(id: UUID, nom: String, prenom: String, date_de_naissance: Date, motDePasse: String, premiere_experience: Bool, enCouple: Bool, email: String) {
        
        let dateFormatter = ISO8601DateFormatter()
        let formattedDate = dateFormatter.string(from: date_de_naissance)
        
        let newParent = Parent(
            id: id,
            nom: nom,
            prenom: prenom,
            email: email,
            date_de_naissance: formattedDate,
            password: motDePasse,
            premiere_experience: premiere_experience,
            enCouple: enCouple
        )
        
        
           // Appel à la méthode saveParentToDatabase
           ParentService.saveParentToDatabase(parent: newParent) { [weak self] result in
               DispatchQueue.main.async {
                   switch result {
                   case .success(let token):  // Assurez-vous que le token est renvoyé ici
                       self?.token = token  // Stocker le token dans le ViewModel
                       print("Token JWT: \(token)")  // Afficher le token dans la console
                       self?.parents.append(newParent)
                   case .failure(let error):
                       self?.errorMessage = "Erreur lors de l'enregistrement: \(error.localizedDescription)"
                   }
                   self?.isLoading = false
               }
           }
       }
    
    // Validation des champs
    func validateFields(nom: String, prenom: String, email: String, motDePasse: String) -> Bool {
        var isValid = true
        
        // Réinitialiser les erreurs
        emailError = ""
        motDePasseError = ""
        nomError = ""
        prenomError = ""
        
        // Validation des champs
        if nom.isEmpty {
            nomError = "Le nom ne peut pas être vide."
            isValid = false
        }
        
        if prenom.isEmpty {
            prenomError = "Le prénom ne peut pas être vide."
            isValid = false
        }
        
        if !validateEmail(email) {
            emailError = "Veuillez entrer un email valide."
            isValid = false
        }
        
        if motDePasse.isEmpty {
            motDePasseError = "Le mot de passe ne peut pas être vide."
            isValid = false
        }
        
        return isValid
    }
    
    // Fonction pour valider l'email
    func validateEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPred = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
}
