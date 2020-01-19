/*
 *  MSSoundManager.h
 *  debuger
 *
 *  Created by Moises Swiczar on 3/5/10.
 *  Copyright 2010 __MyCompanyName__. All rights reserved.
 *
 */

typedef struct _ARRAY_DATA
{
	unsigned char R;
	unsigned char G;
	unsigned char B;
	unsigned int  POS;
} ARRAY_DATA, *PARRAY_DATA;


typedef struct _ARRAY_SUM
{
	int  cant_01_20_RED;	
	int  cant_21_30_RED;
	int  cant_31_50_RED;
	int  cant_51_90_RED;
	
	int silbido;
	int ruido;
	int silencio;
	int abajo;
	
} ARRAY_SUM , *PARRAY_SUM;



int SetArray(PARRAY_DATA lamuestra );
int InitArray();


