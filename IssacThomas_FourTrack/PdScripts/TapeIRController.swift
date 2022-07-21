//
//  TapeIRController.swift
//  PdTest
//
//  Created by Issac  Jay on 04/11/2021.
//

import CoreData ///For accessing Core Data files
import MobileCoreServices ///For use with File App
class TapeIRController{
 
    static let shared = TapeIRController() ///Ensure that this script is a singleton (only instatiated once)
    var patch: PDPatch? ///Object of objective-c class PDPatch
    
    
    private init() { ///Private Init can only be called internally
        patch = PDPatch(file: "TapeIR.pd") ///Assign TapeIR patch to PDPatch Object.
       
    }
    ///DIRECTORY/SAVE MANAGER
    ///CORE DATA PATH
    func getCoreDataDBPath() { ///Find Documents folder path in CoreData -(StackOverflow, 2016)
            let path = FileManager
                .default
                .urls(for: .documentDirectory, in: .userDomainMask) ///User Documents 'FourTrack' Folder
                .first?
                .absoluteString ///Convert from URL fromat to String
                .replacingOccurrences(of: "file://", with: "") ///Remove the URL text from string
                .removingPercentEncoding
     
        print("Path:  \(path ?? "Not Found")") ///Print file not found if file not avaialble
        patch?.saveLocation(path!) ///Send path String to Patch.
        }
   
    
    ///SET RECORDING TRACK TITLE
    open func setTrackTitle(forTrack: Int, title: String)
    {
        switch forTrack {
        case 1: patch?.title_Track1(title); getCoreDataDBPath(); ///Set ttitle for track 1 in Pd Patch and call getCoreDataDBPatch to append save location URL
        case 2: patch?.title_Track2(title); getCoreDataDBPath();
        case 3: patch?.title_Track3(title); getCoreDataDBPath();
        case 4: patch?.title_Track4(title); getCoreDataDBPath();
            default: print("player does not exist")
        }
    }
    
    ///OPEN AUDIO FILES
    open func openTrackAudioFiles(forTrack: Int, title: String) ///Receives Track URL and Track Index
    {
        switch forTrack {
        case 1: patch?.open_Track1(title); ///Open Track 1 using track URL
        case 2: patch?.open_Track2(title);
        case 3: patch?.open_Track3(title);
        case 4: patch?.open_Track4(title);
            default: print("player does not exist")
        }
    }
    
    ///TRACK PARAMETERS
    ///Track Volume
    open func setTrackVolume(forTrack: Int, toVolume: Float) ///Receives track index and volume value
    {
        switch forTrack {
            case 1: patch?.volume_Track1(toVolume) ///Set volume for Track 1
            case 2: patch?.volume_Track2(toVolume)
            case 3: patch?.volume_Track3(toVolume)
            case 4: patch?.volume_Track4(toVolume)
            default: print("Track does not exist")
        }
    }
    ///Track Pans
    open func setTrackPan(forTrack: Int, toPan: Float) ///Receives track index and pan value
    {
        switch forTrack {
            case 1: patch?.pan_Track1(toPan) ///Set pan for Track 1
            case 2: patch?.pan_Track2(toPan)
            case 3: patch?.pan_Track3(toPan)
            case 4: patch?.pan_Track4(toPan)
            default: print("Track does not exist")
        }
    }
    
    ///EFFECT PARAMETERS
    ///WOW
    ///Wow Frequency Rate
    open func setWowRate(wowRate: Float){
        patch?.wowRate(wowRate) ///Set Wow Rate
    }
    ///Wow Effect Depth
    open func setWowDepth(wowDepth: Float){
        patch?.wowExtent(wowDepth) ///Set Wow Depth
    }
    ///REVERB
    ///ReverbMix
    open func setreverbMix(reverbMix: Float){
        patch?.reverbMix(reverbMix) ///Set Reverb Mix
    }
    ///reverbSize
    open func setreverbSize(reverbSize: Float){
        patch?.reverbSize(reverbSize) ///Set Reverb Size
    }
    ///reverbCrossover
    open func setreverbCrossOver(reverbCrossOver: Float){
        patch?.reverbCrossOver(reverbCrossOver) ///Set Reverb CrossOver Frequency
    }
    ///reverbLPF
    open func setreverbLPF(reverbLPF: Float){
        patch?.reverbLPF(reverbLPF) ///Set Reverb Dampening
    }
    
    open func setTape(Tape: Int)
    {
        switch Tape {
            case 1: patch?.tape_D90(1) ///Set Tape Type to D90
            case 2: patch?.tape_XLII90(1)
            case 3: patch?.tape_UR90(1)
            case 4: patch?.tape_Micro(1)
            default: print("Tape does not exist")
        }
    }
    
    
    
    ///MASTER PARAMETERS
    ///Pitch Mod value
    open func setPitch(pitch: Float){
        patch?.pitch_mod(pitch) ///Set Playback Speed
    }
    ///Reverse Value
    open func setReversed(reversed: Bool){
        patch?.reverse(reversed) ///Reverse Playback
    }
    ///Start Record
    open func startRecord(){
        patch?.startRecord(1) ///Trigger startrecord function in Tape Controller
    }
    ///Stop Record
    open func stopRecord(){
        patch?.stopRecord(1) ///Trigger stopRecord function in Tape Controller
    }
    ///Squelch Level (Output Gain)
    open func squelchLevel(squelch: Float){
        patch?.squelchLevel(squelch) ///Set Output Gain
    }
    
    

}

///CODE REFERENCES

///StackOverflow(2016) 'Core Data file's Location iOS 10', Available at:     https://stackoverflow.com/questions/39722844/core-data-files-location-ios-10/39723368 Accessed: 04/01/22
