int main(int argc, char const *argv[])
{
char * pos;
unsigned int p;

p=0x100;
pos=(char *)p;

*pos=0xff;
pos++;
*pos=0x41;
pos++;
*pos=0x41;
pos++;
*pos=0x41;
pos++;
*pos=0xff;

}
