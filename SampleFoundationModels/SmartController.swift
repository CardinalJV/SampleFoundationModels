//
//  AIController.swift
//  SampleFoundationModels
//
//  Created by Viranaiken Jessy on 06/12/25.
//

/* Rules for instructions
 - What the model’s role is
 - What the model should do
 - What the style preferences are
 - What the possible safety measures are
 
 Before proceed new request, verify isResponding to be sur that the previous request has finished
 
 
 */
import Playgrounds
import FoundationModels
import SwiftUI
import Vision

@Observable
class SmartController {
    
    let session = LanguageModelSession(instructions: "You will analyze a text and generate a quiz regarding it. Generate only a quiz where you can get the response inside the text. Give also the main topics.")
    var language: String? = nil
    
    init() {
        self.localeInstructions()
    }
    
    private func localeInstructions(for locale: Locale = Locale.current) {
        if !Locale.Language(identifier: "en_US").isEquivalent(to: locale.language) {
            self.language = locale.identifier
        }
    }
    
    func getModelAvailability() -> String {
        let model = SystemLanguageModel.default.availability
        switch model {
        case .available:
            return "Available"
        case .unavailable(.appleIntelligenceNotEnabled):
            return "Thanks to turn on Apple Intelligence feature"
        case .unavailable(.deviceNotEligible):
            return "Sorry but your device is no longer compatible"
        case .unavailable(.modelNotReady):
            return "Model is not ready yet"
        default:
            return "Unknown"
        }
    }
    
//    func classify(_ dishes: [String], with filters: [String]) async throws {
//        let response = try await self.session.respond(generating: Dish.self) {
//        "Sort and give me only the dishes that don't have \(filters) in \(dishes), with the results create an array of \(Dish.self)."
//        "Here is an example of the data that you have to create and give me."
//        Dish.example
//        }
//    }
}

#Playground {
    let session = LanguageModelSession(instructions: "You will analyze a text and generate a quiz regarding it. Generate only a quiz where you can get the response inside the text. The quiz should have 5 questions.")
    
    let text = """
        LESSON – HIGH SCHOOL – PHYSICS & CHEMISTRY
        TOPIC: ENERGY, WORK, AND POWER (Grade 10 / “Première” level)
            1.    Concept of energy
        Energy is a quantity that describes a system’s ability to produce work or cause a transformation. It is measured in joules (J). Energy can take different forms: kinetic energy, gravitational potential energy, thermal energy, chemical energy, etc. In an isolated system, total energy is conserved, but it can be converted from one form to another.
            2.    Kinetic energy
        The kinetic energy of an object depends on its mass and its speed. For an object of mass m (in kilograms) moving at speed v (in meters per second), kinetic energy is:
        Ec = 1/2 × m × v²
        So, if the speed doubles, kinetic energy is multiplied by 4.
            3.    Gravitational potential energy
        When an object is placed at a height, it has gravitational potential energy related to its altitude. For an object of mass m at height h (in meters) relative to a reference level, we define:
        Ep = m × g × h
        where g is the acceleration due to gravity, close to 9.81 m·s⁻² on Earth. The higher the object, the greater its potential energy.
            4.    Work done by a force
        The work W done by a force corresponds to the transfer of energy due to the action of that force during a displacement. If a force F (in newtons) is constant and the displacement d (in meters) is straight, the work is:
        W = F × d × cos(θ)
        where θ is the angle between the direction of the force and the direction of the displacement.

            •    If the force is in the same direction as the displacement, θ = 0°, cos(0°)=1, and the work is positive.
            •    If the force is opposite to the displacement, θ = 180°, cos(180°)= -1, and the work is negative.
            •    If the force is perpendicular to the displacement, θ = 90°, cos(90°)=0, and the work is zero.

            5.    Power
        Power P measures how quickly work is done (or energy is transferred). It is measured in watts (W), with 1 W = 1 J/s. Average power is:
        P = W / Δt
        where Δt is the time interval in seconds.
        For example, delivering 600 J in 10 s corresponds to an average power of 60 W.
            6.    Application example (without detailed calculation)
        A student lifts a 5 kg bag up to a shelf located 1.5 m above the ground. The bag gains gravitational potential energy. If the lift takes 3 s, we can also determine the average power delivered by the student during this action.

        KEY POINTS
            •    Energy is measured in joules (J).
            •    Ec = 1/2 m v² and Ep = m g h.
            •    Work depends on the angle: W = F d cos(θ).
            •    Average power: P = W / Δt.
        """
    do {
        let respond = try await session.respond(to: "Analyze this text \(text) and genere a quiz.")
    } catch {
        print(error.localizedDescription)
    }
}
