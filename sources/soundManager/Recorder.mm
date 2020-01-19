/*
 *  Recorder.c
 *  Purina
 *
 *  Created by Moises Swiczar on 2/27/10.
 *  Copyright 2010 __MyCompanyName__. All rights reserved.
 *
 */
#import "wistleDogAppDelegate.h"
#include "MSSoundManager.h"
#include "Recorder.h"
#include <CoreFoundation/CoreFoundation.h>
#include <CoreAudio/CoreAudioTypes.h>
#include <AudioToolbox/AudioToolbox.h>
#include <AudioUnit/AudioUnit.h>
#import "FFTBufferManager.h"
#define CLAMP(min,x,max) (x < min ? min : (x > max ? max : x))
#include "CAStreamBasicDescription.h"
#define kAudioUnitSampleFractionBits 24
typedef struct SpectrumLinkedTexture {
	unsigned int 							texName; 
	struct SpectrumLinkedTexture	*nextTex;
} SpectrumLinkedTexture;

int varsilvo=0;
int run=0;

NSUInteger start = 0; 



static const int kNumberBuffers = 3;                            // 1
typedef struct AQRecorderStateD {
    AudioStreamBasicDescription  mDataFormat;                   // 2
    AudioQueueRef                mQueue;                        // 3
    AudioQueueBufferRef          mBuffers[3];      // 4
    AudioFileID                  mAudioFile;                    // 5
    UInt32                       bufferByteSize;                // 6
    SInt64                       mCurrentPacket;                // 7
    bool                         mIsRunning;                    // 8
	FFTBufferManager*			fftBufferManager;
	int32_t*					l_fftData;
	SInt32*						fftData;
	unsigned int					fftLength;
	bool						hasNewFFTData;
	UInt32*						texBitBuffer;
	SpectrumLinkedTexture*		firstTex;

}AQRecorderStateD;
AQRecorderStateD    aqData;      

float  colorLevels[] = {
0., 1., 0., 0., 0., 
.333, 1., .7, 0., 0., 
.667, 1., 0., 0., 1., 
1., 1., 0., 1., 1., 
};






static void setFFTData(int32_t * FFTDATA, int32_t LENGTH)
{
	if (LENGTH != aqData.fftLength)
	{
		aqData.fftLength = LENGTH;
		aqData.fftData = (SInt32 *)(realloc(aqData.fftData, LENGTH * sizeof(SInt32)));
	}
	memmove(aqData.fftData, FFTDATA, aqData.fftLength * sizeof(Float32));
	
	
	aqData.hasNewFFTData = true;
}




static void HandleInputBuffer (
							   void                                 *aqData,
							   AudioQueueRef                        inAQ,
							   AudioQueueBufferRef                  inBuffer,
							   const AudioTimeStamp                 *inStartTime,
							   UInt32                               inNumPackets,
							   const AudioStreamPacketDescription   *inPacketDesc
) {
	
    AQRecorderStateD *pAqData = (AQRecorderStateD *) aqData;               // 1
	
	SInt32 musetra[1024];
	short int *in =(short int *) inBuffer->mAudioData;
	memset(musetra, 0, sizeof(musetra));

	if( pAqData->fftBufferManager != NULL)
	{
		if (pAqData->fftBufferManager->NeedsNewAudioData())
		{
			wistleDogAppDelegate *appDelegate = (wistleDogAppDelegate *)[[UIApplication sharedApplication] delegate];
			if (!appDelegate.is_simulator)
			{
				for (int zzz=0; zzz<inBuffer->mAudioDataByteSize/2; zzz++)
				{
					musetra[zzz] = (in[zzz]<<8) / 3;
				}
				
			}
			else
			{
				for (int zzz=0; zzz<inBuffer->mAudioDataByteSize/2; zzz++)
				{
					musetra[zzz] = (in[zzz]<<8) ;
				}
				
			}
			

			pAqData->fftBufferManager->GrabAudioData(  musetra, inBuffer->mAudioDataByteSize*2); 
		}
	}
	
	dibujar();
	
	AudioQueueEnqueueBuffer (                                            // 6
								 pAqData->mQueue,
								 inBuffer,
								 0,
								 NULL
								 );

}


OSStatus SetMagicCookieForFile (
								AudioQueueRef inQueue,                                      // 1
								AudioFileID   inFile                                        // 2
) {
    OSStatus result = noErr;                                    // 3
    UInt32 cookieSize;                                          // 4
	
    if (
		AudioQueueGetPropertySize (                         // 5
								   inQueue,
								   kAudioQueueProperty_MagicCookie,
								   &cookieSize
								   ) == noErr
		) {
        char* magicCookie =
		(char *) malloc (cookieSize);                       // 6
        if (
			AudioQueueGetProperty (                         // 7
								   inQueue,
								   kAudioQueueProperty_MagicCookie,
								   magicCookie,
								   &cookieSize
								   ) == noErr
			)
            result =    AudioFileSetProperty (                  // 8
											  inFile,
											  kAudioFilePropertyMagicCookieData,
											  cookieSize,
											  magicCookie
											  );
        free (magicCookie);                                     // 9
    }
    return result;                                              // 10
}
;
#pragma mark	This file needs to compile on more earlier versions of the OS, so please keep that in mind when editing it



void startRecording()
{
	if (run!=0) {
		return;
	}
	run=1;
	
    InitArray();
	memset (&aqData.mDataFormat, 0, sizeof (aqData.mDataFormat));

	aqData.mDataFormat.mSampleRate = 44100;

	aqData.mDataFormat.mFormatID = kAudioFormatLinearPCM;
	aqData.mDataFormat.mFormatFlags =  kAudioFormatFlagsCanonical ;
	aqData.mDataFormat.mBytesPerPacket = 2;
	aqData.mDataFormat.mFramesPerPacket = 1; 
	aqData.mDataFormat.mBytesPerFrame = 2;
	aqData.mDataFormat.mChannelsPerFrame = 1;
	aqData.mDataFormat.mBitsPerChannel = 16;   
	
	
	aqData.fftBufferManager =  new FFTBufferManager(4096);
	aqData.l_fftData = new int32_t[4096/2];

	

	SInt32 result;
	 result = AudioQueueNewInput (                              // 1
						&aqData.mDataFormat,                          // 2
						HandleInputBuffer,                            // 3
						&aqData,                                      // 4
						NULL,                                         // 5
						kCFRunLoopCommonModes,                        // 6
						0,                                            // 7
						&aqData.mQueue                                // 8
						);
	
	
	
	UInt32 dataFormatSize = sizeof (aqData.mDataFormat);       // 1
	
	result=	AudioQueueGetProperty (                                    // 2
						   aqData.mQueue,                                           // 3
						   kAudioConverterCurrentOutputStreamDescription,           // 4
						   &aqData.mDataFormat,                                     // 5
						   &dataFormatSize                                          // 6
						   );


	aqData.bufferByteSize=2048;
	
	
	for (int i = 0; i < kNumberBuffers; ++i) {           // 1
		result= AudioQueueAllocateBuffer (                       // 2
								  aqData.mQueue,                               // 3
								  aqData.bufferByteSize,                              // 4
								  &aqData.mBuffers[i]                          // 5
								  );
		result= AudioQueueEnqueueBuffer (                        // 6
								 aqData.mQueue,                               // 7
								 aqData.mBuffers[i],                          // 8
								 0,                                           // 9
								 NULL                                         // 10
								 );
	}
	
	aqData.mCurrentPacket = 0;                           // 1
	aqData.mIsRunning = true;                            // 2
	
	result= AudioQueueStart (                                    // 3
					 aqData.mQueue,                                   // 4
					 NULL                                             // 5
					 );

}

void stopRecording()
{
	if (run==0) {
		return;
	}
	run=0;

	// Wait, on user interface thread, until user stops the recording
	AudioQueueStop (                                     // 6
					aqData.mQueue,                                   // 7
					true                                             // 8
					);
	
	aqData.mIsRunning = false;    
	
	AudioQueueDispose (                                 // 1
					   aqData.mQueue,                                  // 2
					   true                                            // 3
					   );
	
	//AudioFileClose (aqData.mAudioFile);                 // 4
	
    return ;
}

void pauseRecording()
{

}

void resumeRecording()
{
	
}

inline double linearInterp(double valA, double valB, double fract)
{
	return valA + ((valB - valA) * fract);
}






void renderFFTToTex()
{
	int imprimio=0;
	start++;
	static int numLevels = sizeof(colorLevels) / sizeof(float) / 5;
	ARRAY_DATA arraydata[100];
	int y, maxY;
	maxY= 770;
	memset(arraydata, 0, sizeof(arraydata));

	for (y=0; y<maxY; y++)
	{
		float yFract = (float)y / (float)(maxY - 1);
		float fftIdx = yFract * ((float)aqData.fftLength-1);
		
		double fftIdx_i, fftIdx_f;
		fftIdx_f = modf(fftIdx, &fftIdx_i);
		
		SInt8 fft_l, fft_r;
		float fft_l_fl, fft_r_fl;
		float interpVal;
		
		fft_l = (aqData.fftData[(int)fftIdx_i] & 0xFF000000) >> 24;
		fft_r = (aqData.fftData[(int)fftIdx_i + 1] & 0xFF000000) >> 24;
		fft_l_fl = (float)(fft_l + 80) / 64.;
		fft_r_fl = (float)(fft_r + 80) / 64.;

		
		
		interpVal = fft_l_fl * (1. - fftIdx_f) + fft_r_fl * fftIdx_f;

		interpVal = sqrt(CLAMP(0., interpVal, 1.));
		
		UInt32 newPx = 0xFF000000;
	
		int level_i;
		const float *thisLevel = colorLevels;
		const float *nextLevel = colorLevels + 5;
		for (level_i=0; level_i<(numLevels-1); level_i++)
		{
			if ( (*thisLevel <= interpVal) && (*nextLevel >= interpVal) )
			{
				double fract = (interpVal - *thisLevel) / (*nextLevel - *thisLevel);
				newPx = 
				((UInt8)(255. * linearInterp(thisLevel[1], nextLevel[1], fract)) << 24)
				|
				((UInt8)(255 * linearInterp(thisLevel[2], nextLevel[2], fract)) << 16)
				|
				((UInt8)(255. * linearInterp(thisLevel[3], nextLevel[3], fract)) << 8)
				|
				(UInt8)(255. * linearInterp(thisLevel[4], nextLevel[4], fract))
				;
				
				if(y<100)
				{
					unsigned char 	B = ((unsigned char) (255 * linearInterp(thisLevel[2], nextLevel[2], fract)) );
					unsigned char 	G = ((unsigned char)(255. * linearInterp(thisLevel[3], nextLevel[3], fract)) );
					unsigned char 	R = (unsigned char)(255. * linearInterp(thisLevel[4], nextLevel[4], fract));
					
					arraydata[y].R   = R;
					arraydata[y].G   = G;
					arraydata[y].B   = B;
					arraydata[y].POS = start;

					if ((R !=0 ) ||(G !=0 )|| (B !=0 ))
					{
						if ((R >30 ))
						{
							if((y >0) && (y <100))
							{
								if(imprimio==0)
								{
									//printf("%d ---- %d \n",start,start);
								}
								imprimio=1;
							}
						}
					}
				}
				break;
			}
			thisLevel+=5;
			nextLevel+=5;
		}
	}
	
	
	int retornoFuncion = SetArray(arraydata);
	if (retornoFuncion != 0)
	{
		varsilvo = retornoFuncion;
	}

	
	aqData.hasNewFFTData  = false;
}

int silvo()
{
	return varsilvo;
}


void resetsilvo()
{
	varsilvo=0;
}


void dibujar()
{

	if(aqData.fftBufferManager!=NULL)
	{
		if (aqData.fftBufferManager->HasNewAudioData())
		{
			if (aqData.fftBufferManager->ComputeFFT(aqData.l_fftData))
			{
				setFFTData(aqData.l_fftData,aqData.fftBufferManager->GetNumberFrames() / 2);
				
			}
			else
				aqData.hasNewFFTData = false;
	
	
			if (aqData.hasNewFFTData)
			{
				renderFFTToTex();
			}
		}
	
	}
	

	
}
