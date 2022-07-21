//
//  EffectsViewController.swift
//  PdTest
//
//  Created by Issac  Jay on 31/12/2021.
//

import UIKit

///VIEW CONTROLLER FOR EFFECT VIEW
class EffectsViewController: UIViewController {

    ///ETERNAL SCRIPTS
    var tapeController: TapeIRController! ///Create Object of type TapeIRController to communicate with Tape Controller script
    var gVars: GlobalStoredVariables! ///Global effect variables script
    ///UI INTERFACE
    ///POTENTIOMETERS
    ///Wow Knobs
    @IBOutlet weak var wowRateKnob: ImageKnob!
    @IBOutlet weak var wowDepthKnob: ImageKnob!
    
    ///Reverb Knobs
    @IBOutlet weak var reverbMix: ImageKnob!
    @IBOutlet weak var reverbSize: ImageKnob!
    @IBOutlet weak var reverbCrossover: ImageKnob!
    @IBOutlet weak var reverbLPF: ImageKnob!
    
    ///OTHER UI
    ///Tape Segmented Control
    @IBOutlet weak var segmentedControl: UISegmentedControl!
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ///INIT EXTERNAL SCRIPTS
        tapeController = TapeIRController.shared ///Access TapeIRController Singleton
        gVars = GlobalStoredVariables()///Instantiate Global Variables
        let gvs = GlobalStoredVariables.StoredVariables.self ///Make variable to reduce repeated use of long method
        
        ///CALL SETUP FUNCTIONS
        setUpEffectKnobCallback() ///Call back function for all UI elements of type "ImageKnob" - (AudioKit, 2017)
        
        
        ///INIT UI VALUES (Called from GlobalStoredVariables.StoredVariables)
        ///Wow
        wowRateKnob.value = gvs.wowRate ///Wow Rate
        wowDepthKnob.value = gvs.wowDepth ///Wow Depth
        ///Reverb
        reverbMix.value = gvs.reverbMix ///Reverb Dry/Wet
        reverbSize.value = gvs.reverbSize ///Reverb Size
        reverbCrossover.value = gvs.reverbCO ///Reverb Crossover frequency (for LPF Dampening)
        reverbCrossover.value = gvs.reverbCOLPF ///Reverb Crossover Dampening factor
        segmentedControl.selectedSegmentIndex = gvs.cassetteType ///Tape Type
        
     
    }
    
    ///KNOB CALLBACK FUNCTION
    func setUpEffectKnobCallback(){
        let gsv = GlobalStoredVariables.StoredVariables.self ///Make variable to reduce repeated use of long method (access struct for stored variables)
        ///Wow Callbacks
        wowRateKnob.callback = { value in
            gsv.wowRate = value ///Store new value as Wow Rate in Global Variables Script
            self.tapeController.setWowRate(wowRate: Float(value)) ///Set Wow Rate (--> Tape Controller Script --> Pd Patch)
            
        }
        wowDepthKnob.callback = { value in
            gsv.wowDepth = value ///Store Wow Depth
            self.tapeController.setWowDepth(wowDepth: Float(value)) ///Set Wow Depth
            
        }
        reverbMix.callback = {value in
            gsv.reverbMix = value ///Store Reverb Mix
            self.tapeController.setreverbMix(reverbMix: Float(value)) ///Set Reverb Mix
        }
        reverbSize.callback = {value in
            gsv.reverbSize = value ///Store Reverb Size
            self.tapeController.setreverbSize(reverbSize: Float(value)) ///Set Reverb Size
        }
        reverbCrossover.callback = {value in
            gsv.reverbCO = value ///Store CO Frequency
            self.tapeController.setreverbCrossOver(reverbCrossOver: Float(value)) ///Set CO Frequency
        }
        reverbLPF.callback = {value in
            gsv.reverbCOLPF = value ///Store CO Dampening
            self.tapeController.setreverbLPF(reverbLPF: Float(value)) ///Set CO Dampening
        }
    }
    
    ///TAPE SYPE SEGMENTED CONTROL
    @IBAction func tapeTypeSC(_ sender: UISegmentedControl) {
        GlobalStoredVariables.StoredVariables.cassetteType = sender.selectedSegmentIndex ///Store new Tape Value
        let tape = sender.selectedSegmentIndex + 1 ///Set value from 0-3 to 1-4
        self.tapeController.setTape(Tape: tape) ///Set Tape Type (--> TapeIRController --> PdPatch)
    }
    
    ///PERFORM VIEW BUTTON
    @IBAction func PerformView(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil) ///Close Effects View Controller, returning to Perform View
    }
    
    
}


///CODE REFERENCES

///AudioKit (2017), '3D-Knobs', Available at https://github.com/analogcode/3D-Knobs , Accessed 04/01/2022
