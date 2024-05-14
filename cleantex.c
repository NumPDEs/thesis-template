/*
 * moegliche Aufrufe:
 * ./a.out                 ==> fragt nach Filename, eliminiert DEFAULT
 * ./a.out filename        ==> eliminiert DEFAULT
 * ./a.out filename string ==> eliminiert string
 *
 * OUTPUT: Datei out_filename
 */

/*################################################*/
/* Die Konstante enthaelt den default Suchstring. */
#define DEFAULT "revision"
/*################################################*/

#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int main(int nargin, char* input[]){

  char search[255]="\\";
  char filename[255];
  char outputfilename[255]="out_";

  char defaultstring[] = DEFAULT;
  char string[255];

  if (nargin == 1) {
    printf("Filename: ");
    scanf("%s",filename);
    strcpy(string,defaultstring);
  }
  else if (nargin == 2) {
    strcpy(filename,input[1]);
    strcpy(string,defaultstring);
  }
  else if (nargin == 3) {
    strcpy(filename,input[1]);
    strcpy(string,input[2]);
  }
    
  strcat(search,string);
  strcat(search,"{");
  int length = strlen(string);
  int N=length+2;

  char ch;
  int rpl=0;
  char buffer[N+1];
  int sbuffer[N];
  int counter=0,i=0,j=0,rev=0;;
  FILE* fpread,*fpwrite;
  
  fpread=fopen(filename,"r");
  strcat(outputfilename,filename);
  fpwrite=fopen(outputfilename,"w");
  for(i=0;i<N;++i){
    sbuffer[i]=0;
    buffer[i]=' ';
  }
  buffer[N]='\0';
  while(1){
    if((ch=fgetc(fpread))!=EOF){
      for(i=1;i<N;++i){
	buffer[i-1]=buffer[i];
	sbuffer[i-1]=sbuffer[i];
      }
      sbuffer[N-1]=0;
      buffer[N-1]=ch;
      if(strstr(buffer,search) && rev==0){
	rpl++;
	for(i=0;i<N;++i){
	  sbuffer[i]=1;
	}
	rev=1;
      }
      if(ch=='{' && rev==1 && buffer[N-2]!='\\'){
	counter++;
      }
      if(ch=='}' && rev==1 && buffer[N-2]!='\\'){
	counter--;
      }
      if(counter==0 && rev==1){
	rev=0;
	sbuffer[N-1]=1;
      }
      if(j>=N-1 && sbuffer[0]==0){
	fputc(buffer[0],fpwrite);
      }
      j++;
    }else{
      break;
    }
  }
  for(i=1;i<N;++i){
    if(sbuffer[i]==0){
      fputc(buffer[i],fpwrite);
    }
  }
  fclose(fpread);
  fclose(fpwrite);
  printf("Cleaned %d times \"%s\"\n",rpl,string);
}

