main()
 {
 FILE * pfile;
 unsigned int  size,address;
 char ch, vch;
 int i;
 pfile=fopen ("stdaux1", "a+");
 printf("Send Data from PC and press a key\n");
 ch=getchar();
  vch = fgetc(pfile);
  size=vch*256;
    vch = fgetc(pfile);
  size+=vch;
    vch = fgetc(pfile);
  address=vch*256;
    vch = fgetc(pfile);
  address+=vch;
  printf("creation of a %d at %x binary\n",size,address);
 for(i=0;i<size;i++)
 {
vch = fgetc(pfile);
poke(address,vch);
address++;
 }
 printf("\nDONE\n");
 fclose(pfile);
 }