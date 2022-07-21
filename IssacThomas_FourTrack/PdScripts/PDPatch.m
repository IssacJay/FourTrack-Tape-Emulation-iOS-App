//
//  PDPatch.m
//  PdTest
//
//  Modified by Issac  Jay on 19/10/2021.
//  Created by hdez on 19/04/2015
//  Copywright (c) hdez 2015. All rights reserved

#import "PDPatch.h"

@implementation PDPatch
//LOCATIONS

//Audio recording Save location
-(void)saveLocation:(NSString *)saveURL{
    NSString *url = (NSString *) saveURL;
    [PdBase sendSymbol:url toReceiver:@"saveURL"]; ///A String is sent the receive object in the PdPatch called "saveURL"
}

//TRACK SPECIFIC//
///Send New recording titles
-(void) title_Track1: (NSString*)title{
    NSString *title1 = (NSString *) title;
    [PdBase sendSymbol:title1 toReceiver:@"title_Track1"]; ///The Title of new recording for track 1 is sent a string to "title_Track1
}
-(void) title_Track2: (NSString*)title{
    NSString *title2 = (NSString *) title;
    [PdBase sendSymbol:title2 toReceiver:@"title_Track2"];
}
-(void) title_Track3: (NSString*)title{
    NSString *title3 = (NSString *) title;
    [PdBase sendSymbol:title3 toReceiver:@"title_Track3"];
}
-(void) title_Track4: (NSString*)title{
    NSString *title4 = (NSString *) title;
    [PdBase sendSymbol:title4 toReceiver:@"title_Track4"];
}

///Open Audio Track
-(void) open_Track1: (NSString*)open{
    NSString *open1 = (NSString *) open;
    [PdBase sendSymbol:open1 toReceiver:@"open_Track1"]; ///The the string of an audio file is sent to the open function of track 1 in the Patch
}
-(void) open_Track2: (NSString*)open{
    NSString *open2 = (NSString *) open;
    [PdBase sendSymbol:open2 toReceiver:@"open_Track2"];
}
-(void) open_Track3: (NSString*)open{
    NSString *open3 = (NSString *) open;
    [PdBase sendSymbol:open3 toReceiver:@"open_Track3"];
}
-(void) open_Track4: (NSString*)open{
    NSString *open4 = (NSString *) open;
    [PdBase sendSymbol:open4 toReceiver:@"open_Track4"];
}

///Track Play or Pause ///Currently unused
-(void) play_Track1: (BOOL)playPause{
    float play1 = (float)playPause;
    [PdBase sendFloat:play1 toReceiver:@"play_Track1"];
}
-(void) play_Track2: (BOOL)playPause{
    float play2 = (float)playPause;
    [PdBase sendFloat:play2 toReceiver:@"play_Track2"];
}
-(void) play_Track3: (BOOL)playPause{
    float play3 = (float)playPause;
    [PdBase sendFloat:play3 toReceiver:@"play_Track3"];
}
-(void) play_Track4: (BOOL)playPause{
    float play4 = (float)playPause;
    [PdBase sendFloat:play4 toReceiver:@"play_Track4"];
}

///Track Volumes
-(void) volume_Track1: (Float32) volume{
    float vol1 = (Float32)volume;
    [PdBase sendFloat:vol1 toReceiver:@"volume_Track1"];
}
-(void) volume_Track2: (Float32) volume{
    float vol2 = (Float32)volume;
    [PdBase sendFloat:vol2 toReceiver:@"volume_Track2"];
}
-(void) volume_Track3: (Float32) volume{
    float vol3 = (Float32)volume;
    [PdBase sendFloat:vol3 toReceiver:@"volume_Track3"];
}
-(void) volume_Track4: (Float32) volume{
    float vol4 = (Float32)volume;
    [PdBase sendFloat:vol4 toReceiver:@"volume_Track4"];
}

///Track pans
-(void) pan_Track1: (Float32) pan{
    float pan1 = pan;
    [PdBase sendFloat:pan1 toReceiver:@"pan_Track1"];
}
-(void) pan_Track2: (Float32) pan{
    float pan2 = pan;
    [PdBase sendFloat:pan2 toReceiver:@"pan_Track2"];
}
-(void) pan_Track3: (Float32) pan{
    float pan3 = pan;
    [PdBase sendFloat:pan3 toReceiver:@"pan_Track3"];
}
-(void) pan_Track4: (Float32) pan{
    float pan4 = pan;
    [PdBase sendFloat:pan4 toReceiver:@"pan_Track4"];
}
//EFFECTS CONTROLS
//Wow
-(void)wowRate:(Float32) wowRate{
    [PdBase sendFloat:wowRate toReceiver: @"wowRate"];
}
-(void)wowExtent:(Float32)wowExtent{
    [PdBase sendFloat:wowExtent toReceiver: @"wowExtent"];
}
//Reverb
-(void)reverbMix:(Float32)reverbMix{
    [PdBase sendFloat:reverbMix toReceiver: @"revDryWet"];
}
-(void)reverbSize:(Float32)reverbSize{
    [PdBase sendFloat:reverbSize toReceiver: @"revSize"];
}
-(void)reverbCrossOver:(Float32)reverbCO{
    [PdBase sendFloat:reverbCO toReceiver: @"revCross"];
}
-(void)reverbLPF:(Float32)reverbLPF{
    [PdBase sendFloat:reverbLPF toReceiver: @"revDamp"];
}
//Tape Type
-(void)Tape_D90:(int)Tape_D90{
    [PdBase sendBangToReceiver:@"D90"];
}
-(void)Tape_XLII90:(int)Tape_XLII90{
    [PdBase sendBangToReceiver:@"XLII90"];
}
-(void)Tape_UR90:(int)Tape_UR90{
    [PdBase sendBangToReceiver:@"UR90"];
}
-(void)Tape_Micro:(int)Tape_Micro{
    [PdBase sendBangToReceiver:@"MicroCassette"];
}



///MASTER CONTROLS///
///Start Recording
-(void)startRecord:(int) startR{
    [PdBase sendBangToReceiver:@"startRecording"]; 
}
///Stop Recording
-(void)stopRecord:(int) stopR{
    [PdBase sendBangToReceiver:@"stopRecording"];
}
///Pitch
-(void)pitch_mod:(Float32)pitch{
    float pitchmod = pitch;
    [PdBase sendFloat:pitchmod toReceiver:@"pitch_mod"];
}
///Reversed
-(void)reverse:(BOOL)reversed{
    float isReversed = (float)reversed;
    [PdBase sendFloat:isReversed toReceiver:@"reverse"];
}

///Connect on/off toggle from viewcontroller to Pd patch
-(void)onOff:(BOOL)yesNo{
    NSLog(@"Switch recieved");
    float yn = (float) yesNo;
    [PdBase sendFloat:yn toReceiver:@"sampleOnOff"];
}

-(void)squelchLevel:(Float32)Squelch{
    float sLevel = (float) Squelch;
    [PdBase sendFloat:sLevel toReceiver:@"squelch"];
}

-(void)dryWetLevel:(Float32)dryWet{
    float mix = (float) dryWet;
    [PdBase sendFloat:mix toReceiver:@"drywet"];
}

-(void)master:(BOOL)volume{
    float dsp = (float) volume;
    [PdBase sendFloat:dsp toReceiver:@"dsp"];
}




///Check there is a Pd Patch
-(instancetype)initWithFile:(NSString *)pdFile{
    void *patch;
    self = [super init];
    if(self){
        patch = [PdBase openFile:pdFile path:[[NSBundle mainBundle] resourcePath]];
        if(!patch){
            NSLog(@"App could not load patch");
        }
        else{
            NSLog(@"Patch Loaded successfully"); 
        }
    }
    return self;
}

@end


///CODE REFERENCES

///Hernandez, R(2015), 'Using pd-for-ios (libPD) within a Swift project', Online Video, Avaialble at: https://www.youtube.com/watch?v=R_-vTybbTn4 Accessed: 04/01/2022
