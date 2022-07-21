//
//  PDPatch.h
//  PdTest
//
//  Modified by Issac  Jay on 19/10/2021.
//  Created by hdez on 19/04/2015
//  Copywright (c) hdez 2015. All rights reserved

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "PdDispatcher.h"

NS_ASSUME_NONNULL_BEGIN

///SCRIPT RECEIVES CALLS FROM TAPEIRCONTROLLER VIA BRIDGING HEADER
@interface PDPatch : NSObject

///Each void function recieves a varaible from the TapeIRController. These functions are accessed in PDPatch.m and sent to the PdPatch (via receive objects)
///TapeIRController --bridging header-->PDPatch.h-->PDPatch.m-->PdPatch

//TRACK SPECIFIC//
//Title a new recording
-(void) title_Track1: (NSString*)title;
-(void) title_Track2: (NSString*)title;
-(void) title_Track3: (NSString*)title;
-(void) title_Track4: (NSString*)title;
//Open an audio file to track
-(void) open_Track1: (NSString*)title;
-(void) open_Track2: (NSString*)title;
-(void) open_Track3: (NSString*)title;
-(void) open_Track4: (NSString*)title;
//Track Play or Pause
-(void) play_Track1: (BOOL)playPause;
-(void) play_Track2: (BOOL)playPause;
-(void) play_Track3: (BOOL)playPause;
-(void) play_Track4: (BOOL)playPause;
//Track Volumes
-(void) volume_Track1: (Float32) volume;
-(void) volume_Track2: (Float32) volume;
-(void) volume_Track3: (Float32) volume;
-(void) volume_Track4: (Float32) volume;
//Track pans
-(void) pan_Track1: (Float32) pan;
-(void) pan_Track2: (Float32) pan;
-(void) pan_Track3: (Float32) pan;
-(void) pan_Track4: (Float32) pan;

//EFFECTS CONTROLS
//Wow
-(void)wowRate:(Float32) wowRate;
-(void)wowExtent:(Float32)wowExtent;
//Reverb
-(void)reverbMix:(Float32)reverbMix;
-(void)reverbSize:(Float32)reverbSize;
-(void)reverbCrossOver:(Float32)reverbCO;
-(void)reverbLPF:(Float32)reverbLPF;
//Tape Type
-(void)Tape_D90:(int)Tape_D90;
-(void)Tape_XLII90:(int)Tape_XLII90;
-(void)Tape_UR90:(int)Tape_UR90;
-(void)Tape_Micro:(int)Tape_Micro;

//MASTER CONTROLS//
//Recording
-(void)startRecord:(int) startR;
-(void)stopRecord:(int) stopR;
//Store Save location
-(void)saveLocation:(NSString*)saveURL;
//Pitch
-(void) pitch_mod: (Float32) pitch;
//Reversed
-(void) reverse: (BOOL) reversed;

//Sample ADC
-(void)onOff:(BOOL)yesNo;

//Recieve squelch button
-(void)squelchLevel:(Float32)Squelch;

//Recieve squelch button
-(void)dryWetLevel:(Float32)dryWet;

//Recieve master button
-(void)master:(BOOL)volume;

-(instancetype)initWithFile:(NSString *)pdFile; ///Initialise the Pd Patch


@end

NS_ASSUME_NONNULL_END


///CODE REFERENCES

///Hernandez, R(2015), 'Using pd-for-ios (libPD) within a Swift project', Online Video, Avaialble at: https://www.youtube.com/watch?v=R_-vTybbTn4 Accessed: 04/01/2022
