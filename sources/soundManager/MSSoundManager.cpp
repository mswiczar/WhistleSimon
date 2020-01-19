#include <string.h>
#include <stdio.h>
#include "MSSoundManager.h"


static ARRAY_SUM elresult[10];

static int posicion=0;
PARRAY_DATA elarreglo;



int getNext()
{
	if (posicion==9)
	{
		posicion=0;
	}
	else
	{
		posicion++;
	}
	return posicion;
}



int getPrev(int entrada)
{
	
	
	if (entrada ==0)
	{
		return 10;
	}
	
	else
	{
		return entrada-1;;
	}
	return 0;
}


/*
 char R;
 char G;
 char B;
 
 int  is_ruido;
 int  is_silence;
 
 int  cant_01_30_RED;	
 int  cant_21_30_RED;
 int  cant_31_50_RED;
 int  cant_51_90_RED;
 
 */


int process_Line(int posicion)
{
	
	
	
	elresult[posicion].cant_01_20_RED=0;
	elresult[posicion].cant_21_30_RED=0;
	elresult[posicion].cant_31_50_RED=0;
	elresult[posicion].cant_51_90_RED=0;	
	elresult[posicion].silbido=0;
	elresult[posicion].ruido=0;
	elresult[posicion].silencio=0;
	elresult[posicion].abajo=0;
	
	
	
	 for (int i=0; i<80 ; i++)
	 {
		 if (elarreglo[i].R !=0 )
		 {
			 if((i >20) && (i <30))
			 {
				 if(elarreglo[i].R>60) 
				 {
					// printf("+++++++++++Level: %d , RGB (%d , %d , %d )\n",i,elarreglo[i].R,elarreglo[i].G,elarreglo[i].B);
				 }
			 }
		 }
	 
	 }
	
	for (int i=0; i<80 ; i++)
	{
		
		if(elarreglo[i].R >10)
		{
			if (i < 19)
			{
				elresult[posicion].cant_01_20_RED++;
			}
			if(elarreglo[i].R >10)
			{
				
				if ((i < 30) && (i >= 19))
				{
					elresult[posicion].cant_21_30_RED++;
				}
			}
			if ((i < 50) && (i >= 30))
			{
				elresult[posicion].cant_31_50_RED++;
			}	
			if( (i < 90) && (i >= 50))
			{
				elresult[posicion].cant_51_90_RED++;
			}
		}
	}
	
	
	//printf("cant_01_20_RED : %d \n",elresult[posicion].cant_01_20_RED );
	//printf("cant_21_30_RED : %d \n",elresult[posicion].cant_21_30_RED );
	//printf("cant_31_50_RED : %d \n",elresult[posicion].cant_31_50_RED );
	//printf("cant_51_90_RED : %d \n",elresult[posicion].cant_51_90_RED);
	
	
	
	if(    (elresult[posicion].cant_31_50_RED > 1) )
	{
		elresult[posicion].ruido=1;
	}
	
	if(  (elresult[posicion].cant_51_90_RED > 2) )
	{
		elresult[posicion].ruido=1;
	}
	
	if( (elresult[posicion].cant_21_30_RED >= 1) )
	{
		elresult[posicion].silbido = 1;
	}
	
	if( (elresult[posicion].cant_01_20_RED >2) )
		
	{
		elresult[posicion].abajo = 1;
	}
	return 0;
}


int analyze (int posicion_insertar)
{
	
	//WCHAR salida[512];
	int prev;
	
	int sum_ruido=0;
	int sum_silbido=0;
	int sum_vocal=0;
	prev=posicion_insertar;
	for (int i=5; i>0 ; i--)
	{
		if (elresult[prev].ruido ==1)
		{
			sum_ruido = sum_ruido + 10*i;
		}
		if (elresult[prev].abajo ==1)
		{
			sum_vocal = sum_vocal + 10*i;
		}
		if (elresult[prev].silbido ==1)
		{
			sum_silbido = sum_silbido + 10*i;
		}
		prev=getPrev(prev);
	}
	
	//printf("sum_ruido: %d  sum_vocal: %d sum_silbido: %d \n",sum_ruido ,sum_vocal,sum_silbido  );

	
	if ((sum_ruido) >=10)
	{

		return 0;
	}
	
	if ((sum_vocal) >=50)
	{
		return 0;
	}
	
	if (sum_silbido >60)
	{
		return 1;
	}
	

	return 0;
}



int procesar(int posicion)
{
	process_Line(posicion);
	return analyze(posicion);
}



int InitArray()
{
	memset(elresult, 0, sizeof(elresult));
	return 0;
}



int anterior_sil=0;
int anterior_pos=0;


int SetArray(PARRAY_DATA lamuestra)
{

	PARRAY_DATA theelarreglo = lamuestra;
	int total_por = 0;
	
	int varsilvo =0;
	for (int y=0; y<100 ; y++)
	{
		if ((theelarreglo[y].R > 50) )
		{
			total_por++;
			if ((y >= 35) && (y < 45))
			{
				varsilvo=1;
			}
			if ((y >= 45) && (y < 55))
			{
				varsilvo=2;
			}
			if ((y >= 55) && (y < 65))
			{
				varsilvo=3;
			}
			if ((y >= 65) && (y < 80))
			{
				varsilvo=4;
			}
		}
		
	}
	
	int lasalida=0;
	int thepos = theelarreglo[0].POS;
	
	if (total_por> 30)
	{
		return 0;
	}
	if (varsilvo!=0)
	{
			
		if (anterior_sil == varsilvo)
		{
			if ((thepos - anterior_pos)<3 )
			{
				lasalida = varsilvo;
				printf("SII silvo!!!!!! (%d - %d) (%d - %d) \n",thepos , varsilvo , anterior_pos ,anterior_sil );

			}
		}
		
		anterior_sil = varsilvo;
		anterior_pos = thepos;
	}
	return lasalida;

	/*
	 int posicion_insertar;
	 posicion_insertar = getNext();
	 elarreglo = lamuestra;
	 return  procesar(posicion_insertar);
	*/
	
	
}



