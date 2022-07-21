//
//  ViewController.swift
//  PdTest
//
//  Created by Issac  Jay on 19/10/2021.
//

import UIKit
import CoreData ///For Storing Audio Files
import MobileCoreServices ///For use with Files App

///VIEW CONTROLLER FOR PERFORMANCE VIEW (MAIN VIEW COTROLLER)
class ViewController: UIViewController {

    ///VARIABLES
    ///Secondary View Controllers
    var effectsVC = EffectsViewController() ///Effects View Controller Variable
    var helpsVC = HelpViewController() ///Help Page View Controller
    var recordingTrack = 1 ///Index of track being recorded to
    
    ///External Scripts
    var tapeController: TapeIRController! ///Create Object of type TapeIRController to communicate with Tape Controller script
    
    ///STORAGE AND DATA VARIABLES
    var saveURL: String! ///Files app documents folder URL variable
    var RecordingTitle: String = "Recording1" ///Title of latest file recording
    
    ///PUBLIC VALUES
    var PitchSpeed:Double = 0.0 ///Speed of Tape Cassette Gif (Determined by Pitch Knob Value)
    
    ///USER INTERFACE
    ///
    ///POTENTIOMETERS
    ///Volume Knobs
    @IBOutlet weak var vol_Knob1: ImageKnob! ///Volume Knob Variables
    @IBOutlet weak var vol_Knob2: ImageKnob! ///Volume Knob Variables
    @IBOutlet weak var vol_Knob3: ImageKnob! ///Volume Knob Variables
    @IBOutlet weak var vol_Knob4: ImageKnob! ///Volume Knob Variables
    ///Pan Knobs
    @IBOutlet weak var pan_Track1: ImageKnob! ///Pan Knob Variables
    @IBOutlet weak var pan_Track2: ImageKnob! ///Pan Knob Variables
    @IBOutlet weak var pan_Track3: ImageKnob! ///Pan Knob Variables
    @IBOutlet weak var pan_Track4: ImageKnob! ///Pan Knob Variables
    ///Pitch Knob
    @IBOutlet weak var pitch_Knob: ImageKnob! ///Pitch Knob Variable
    ///Output Knob
    @IBOutlet weak var output_KNob: ImageKnob!
    
    
    ///BUTTONS
    ///Record Enable Buttons
    @IBOutlet weak var recTRK1: UIButton! ///Track Record Enable Buttons
    @IBOutlet weak var recTRK2: UIButton! ///Track Record Enable Buttons
    @IBOutlet weak var recTRK3: UIButton! ///Track Record Enable Buttons
    @IBOutlet weak var recTRK4: UIButton! ///Track Record Enable Buttons
    var trackRecButtons = [UIButton]() ///Array for Record Buttons
    ///Open Track Buttons
    @IBOutlet weak var openTRK1: UIButton! ///Open File Buttons
    @IBOutlet weak var openTRK2: UIButton! ///Open File Buttons
    @IBOutlet weak var openTRK3: UIButton! ///Open File Buttons
    @IBOutlet weak var openTRK4: UIButton! ///Open File Buttons
    //Transport Buttons
    @IBOutlet weak var masterRecord: UIButton! ///Master Record Button
    @IBOutlet weak var stopRecord: UIButton! ///Master Stop Recording Button
    
    ///SLIDERS
    @IBOutlet weak var squelchSlider: UISlider! ///Output gain slider
    
    ///SWITCHES
    ///Reverse Switch
    @IBOutlet weak var reverseSwitch: UISwitch! ///Reverse Switch
    @IBOutlet weak var reverseSwitchImage: UIImageView! ///Reverse Swift Image (placed over top of UISwitch)
    
    ///IMAGES
    @IBOutlet weak var cassetteGif: UIImageView! ///Gif of Cassette
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ///INITIALISE EXTERNAL SCRIPTS
        tapeController = TapeIRController.shared ///Access TapeIRController Singleton
        
        ///INITIALISE FUNCTIONS
        setupVolCallbacks() ///Call back function for all UI elements of type "ImageKnob" - (AudioKit, 2017)
        trackRecButtons = [recTRK1, recTRK2, recTRK3, recTRK4] ///Store track Record Enable Buttons in Array
        
      
        
        
        ///INITIALISE UI PARAMETERS
        ///POTS
        ///Volume Knobs
        vol_Knob1.value = 0.5
        vol_Knob2.value = 0.5
        vol_Knob3.value = 0.5
        vol_Knob4.value = 0.5
        ///Pan Knobs
        pan_Track1.value = 0.5
        pan_Track2.value = 0.5
        pan_Track3.value = 0.5
        pan_Track4.value = 0.5
        ///Pitch Knob
        pitch_Knob.value = 0.5
        ///Output KNob
        output_KNob.value = 2.5
       
        ///SWITCHES
        reverseSwitch.isOn = false ///Reverse off when initialised
        
        ///IMAGES
        cassetteGif.loadGif(name: "CassetteCrop") ///Load Cassette Gif into Image View
        
    
        
    }

    ///KNOB CALLBACK FUNCTIONS
    func setupVolCallbacks() { ///Callback function for each Image Knob
       ///Volume callbacks
        vol_Knob1.callback = { value in
            self.tapeController.setTrackVolume(forTrack: 1, toVolume: Float(value)) ///Set Volume For Track 1 (--> TapeIRController --> Pd Patch)
        }
        vol_Knob2.callback = { value in
            self.tapeController.setTrackVolume(forTrack: 2, toVolume: Float(value))
        }
        vol_Knob3.callback = { value in
            self.tapeController.setTrackVolume(forTrack: 3, toVolume: Float(value))
        }
        vol_Knob4.callback = { value in
            self.tapeController.setTrackVolume(forTrack: 4, toVolume: Float(value))
        }
        ///Pan Callbacks
        pan_Track1.callback = { value in
            self.tapeController.setTrackPan(forTrack: 1, toPan: Float(value)) ///Set Pan For Track 1 (--> TapeIRController --> Pd Patch)
        }
        pan_Track2.callback = { value in
            self.tapeController.setTrackPan(forTrack: 2, toPan: Float(value))
        }
        pan_Track3.callback = { value in
            self.tapeController.setTrackPan(forTrack: 3, toPan: Float(value))
        }
        pan_Track4.callback = { value in
            self.tapeController.setTrackPan(forTrack: 4, toPan: Float(value))
        }
        ///Pitch callback
        pitch_Knob.callback = { value in
            self.tapeController.setPitch(pitch: Float(value)) ///Set Playback Speed (--> TapeIRController --> PdPatch)
//            self.cassetteGif.image?.gifSpeed(Speed: Double(value))
//            self.PitchSpeed = Double(value)
//            let valueF = Float(value)*100
//            let valueI = Int(valueF)
//
//            var valueC:Int = 0
//            if valueI != valueC{
//                if valueI.isMultiple(of: 25){
//                    valueC = valueI
//                    if self.masterSwitch.isOn == true{
//                        self.cassetteGif.loadGif(name: "Cassette")
//                    }
//
//
//                }
            
//            } ///Code for Controlling Speed of Gif (Currently Buggy -- Gif.swift causes gif to reload each time playback speed is changed, causing buffering issues)
        }
        output_KNob.callback = {value in
            self.tapeController.squelchLevel(squelch: Float(value)) //Set Output Gain (--> TapeIRController --> Pd Patch)
        }
    }
    
    ///SWITCHES
    ///Reverse Switches
    @IBAction func reverseSwitch(_ sender: UISwitch) {
        let reverseValue = sender as UISwitch ///variable for switch state
        if reverseValue.isOn == false{ ///If Switch is off
            print("Reverse Off")
            reverseSwitchImage.image = UIImage(named: "Reverse_Switch_0")! ///Change the Switch Image to off State
            self.tapeController.setReversed(reversed: false) ///Set Reverse off (--> TapeIRController --> Pd Patch)
        }
        else if reverseValue.isOn == true{ ///If Switch is on
            print("Reverse On")
            reverseSwitchImage.image = UIImage(named: "Reverse_Switch_1")! ///Change the Switch Image to on State
            self.tapeController.setReversed(reversed: true) ///Set Reverse on (--> TapeIRController --> Pd Patch)
        }
        else{
            return ///If neither On/offReturn
        }
    }
    
    
    
    ///BUTTON FUNCTIONS
    ///RECORD TRACK BUTTON
    @IBAction func recordButton(_ sender: UIButton) { ///Record Button prompts textfield input for track title ///Connected to each of the 4 record enable buttons
        
        let trackNumb: Int = sender.tag ///Button tags for tracks 1-4
        recordingTrack = trackNumb
        inputTrackName(trackNumber: trackNumb, sender: sender) ///Calls the inputTrackName Function (Sending the track name, and the button that was pressed)
    }

    
    @objc func inputTrackName(trackNumber: Int, sender: UIButton){ ///Alert for Record Ttitle textfield
        
        let titleAlert = UIAlertController( ///New Alert for Inputing Title for new recording
            
            title: "Title your recording", ///Title of Alert
            message: "Give your recording a sensible title", ///Message for alert
            preferredStyle: .alert ///Type Alert
            ) ///Alert contains title and message for user
        
            titleAlert.addTextField{field in ///Text field for user to type title for new recording
            field.placeholder = "Title" ///Placeholder is replaced by input
            field.returnKeyType = .next} ///Type of Keyboard (Pressing next closes alert)
            
            ///Cancel Button Removed to avoid issues with changing Button Colours
            //titleAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil)) ///User can close the Alert
            
            ///Adds Button called "Record Enable", that gathers input text and closes alert
            titleAlert.addAction(UIAlertAction(title: "Record Enable", style: .default, handler: { _ in
                    guard let fields = titleAlert.textFields, fields.count == 1 else { ///Get index of input fields
                        return
                    }
                    let titleField = fields[0] ///Constant for title field
//                    guard let title = titleField.text, !title.isEmpty
//                    else{ ///Ensure that input is not empty before continuing
//                        let date = Date()
//                        let dateFormat = DateFormatter()
//                        dateFormat.dateFormat = "yyyy.MM.dd"
//                        let currentDate = dateFormat.string(from: date)
//                        titleField = currentDate
//                        return
//                    }
                    var title = titleField.text ///Get Title from Input
                    if title!.isEmpty == true{ ///If Input is empty
                        let date = Date() ///Get Current Date
                        let dateFormat = DateFormatter() ///Format the date
                        dateFormat.dateFormat = "yyyy.MM.dd_HH.mm.ss" ///Format the date is year.month.day_hours.mins.sec
                        let currentDate = dateFormat.string(from: date) ///Set current date and time as string
                        title = currentDate ///Set title as current date/time
                    }
                    else{ ///If input is not empty
                        title = titleField.text
                    }
                self.RecordingTitle = title! ///Set latest title
                
                self.tapeController.setTrackTitle(forTrack: trackNumber, title: title!) ///Set title as new filename in the correct track in the PdPatch (--> TapeIRController --> PdPatch)
                })) ///User can save title and record when ready using master controls
            sender.tintColor = #colorLiteral(red: 1, green: 0.3732684978, blue: 0.4040847841, alpha: 1) ///Set selected Record Button to Red
            for button in trackRecButtons{ ///For all Record Enable Buttons
                if button != sender{ ///For all record buttons exept pressed button
                    button.tintColor = .systemGray5 ///Turn Dark Grey
                }
            }
            present(titleAlert, animated: true) //Show Input Title alert
    }
    
    
    ///OPEN AUDIO FILE INTO TRACK
    var OpenTrack = 1 ///Init Int of selected Open Track Button (1-4)
    @IBAction func openAudioFile(_ sender: UIButton) { ///Open file button (Connected to each 4 buttons, for each 4 tracks)
        OpenTrack = sender.tag ///Set OpenTrack Variable for Button tags for tracks 1-4
        ///Files Management
        let documentPicker = UIDocumentPickerViewController(documentTypes: [String(kUTTypeWaveformAudio)], in: .import)  ///Creates a document picker controller, showing only .wav type files
        documentPicker.delegate = self ///Create the interface for the document picker
        documentPicker.allowsMultipleSelection = false ///Only allows one document to be picked at a time
        present(documentPicker, animated: true, completion: nil) ///Present the UI Document Picker
        ///Extention as bottom of Script shows the code that handles the document Picker
    }
    ///Handle the URL from the Document Picker
    func openAudioFileManager(AudioFileURL: String){
        
        tapeController.openTrackAudioFiles(forTrack: OpenTrack, title: AudioFileURL) ///Send URL of Selected Audio File, as well as its destination Track
        let trackName = (AudioFileURL as NSString).lastPathComponent ///Take File Name from URL
        switch OpenTrack{ ///Set the Selected Track Open Button text to the TrackName
        case 1: openTRK1.setTitle(trackName, for: .normal)
        case 2: openTRK2.setTitle(trackName, for: .normal)
        case 3: openTRK3.setTitle(trackName, for: .normal)
        case 4: openTRK4.setTitle(trackName, for: .normal)
        default: print("Track does not exist")
        }
        
        
        
    }
    func renameOpenButtonAfterRecording(){
        
        
        let trackName = RecordingTitle ///Take File Name from URL
        switch recordingTrack{ ///Set the Selected Track Open Button text to the TrackName
        case 1: openTRK1.setTitle(trackName, for: .normal)
        case 2: openTRK2.setTitle(trackName, for: .normal)
        case 3: openTRK3.setTitle(trackName, for: .normal)
        case 4: openTRK4.setTitle(trackName, for: .normal)
        default: print("Track does not exist")
        }
        
        
        
    }
    
    ///START RECORDING
    @IBAction func startRecording(_ sender: UIButton) {
        self.tapeController.startRecord() ///Call start record function in Tape Controller Script
        masterRecord.tintColor = #colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1)
    }
    ///STOP RECORDING
    @IBAction func stopRecording(_ sender: UIButton) {
        self.tapeController.stopRecord() ///Call stop record function in Tape Controller Script
        masterRecord.tintColor = #colorLiteral(red: 0.8978799582, green: 0.8977256417, blue: 0.9183328748, alpha: 1)
        for button in trackRecButtons{
            button.tintColor = #colorLiteral(red: 0.8978799582, green: 0.8977256417, blue: 0.9183328748, alpha: 1)
        }
        renameOpenButtonAfterRecording() ///Rename Open Button of Recording Track when recording finished
    }

    ///OPEN EFFECTS VIEW CONTROLLER
    @IBAction func effectViewController(_ sender: Any) {
        guard let effectVC = storyboard?.instantiateViewController(identifier: "EffectVC") as? EffectsViewController ///Instantiate the Effect View Controller
        else{
            return
        }
        
        let effectVCnav = UINavigationController(rootViewController: effectsVC) ///Create a Navigation Controller
        effectVCnav.setNavigationBarHidden(true, animated: true) ///Remove the navigation bar from the top of the view controller
        present(effectVC, animated: true, completion: nil) ///Present the Effect View Controller
    }
    
    @IBAction func helpViewController(_ sender: UIButton) {
        guard let helpVC = storyboard?.instantiateViewController(identifier: "HelpVC") as? HelpViewController ///Instantiate the Help View Controller
        else{
            return
        }
        
        let helpVCnav = UINavigationController(rootViewController: helpsVC) ///Create a Navigation Controller
        helpVCnav.setNavigationBarHidden(true, animated: true) ///Remove the navigation bar from the top of the view controller
        present(helpVC, animated: true, completion: nil) ///Present the Effect View Controller
    }
    
}

///ViewController Extention for Document Picker
extension ViewController: UIDocumentPickerDelegate{
    func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
        guard let selectedAudioFile = urls.first?.absoluteString.replacingOccurrences(of: "file://", with: "").removingPercentEncoding ///Format URL of selected Document in Files App to match URL format in Pd
        else{
            return
        }
        
        openAudioFileManager(AudioFileURL: selectedAudioFile) ///Call openAudioFileManager sending the selectedAudioFile URL
    }
}


///CODE REFERENCES

///AudioKit (2017), '3D-Knobs', Available at https://github.com/analogcode/3D-Knobs , Accessed 04/01/2022

