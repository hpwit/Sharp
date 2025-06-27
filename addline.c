#include <stdio.h>
#include <string.h>
FILE *fptr,*out;
char myString[250];
 
int main()
{
fptr = fopen("code8.asm", "r");
out = fopen("coden_line.asm", "w");
int start_line=10;
while(fgets(myString, 250, fptr)) {
     if(strlen(myString)<=1)
     continue;
     if (myString[0]==';')
     continue;
    
     if (strchr(myString, ':') != NULL)
    fprintf(out,"%d%s", start_line,myString);
    else
     fprintf(out,"%d %s", start_line,myString);
    start_line+=10;
  };
fclose(fptr);
fclose(out);
printf("Done\n");
    return 0;
}