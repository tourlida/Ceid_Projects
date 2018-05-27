#include <stdio.h>
#include <stdlib.h>
#include <sys/types.h>
#include <unistd.h>
#include <string.h>
#include <sys/wait.h>
int main(int argc,char **argv)
{
int bufsize=128;
char *buffer=(char *)malloc(sizeof(char) * bufsize);
char *tokens[2];


//int i=0;
printf("$ ");
//fgets(buffer,bufsize,stdin);
scanf("%s",buffer);
if(strcmp(buffer,"exit")==0)
{
exit(0);
}


while(strcmp(buffer,"exit")!=0)
{
int i=0;
//printf("$ ");
//fgets(buffer,bufsize,stdin);
//scanf("%s",buffer);
/*int i=0;
printf("$ ");
//fgets(buffer,bufsize,stdin);
scanf("%s",buffer);
*/
//strcmp(buffer,"exit\n")!=0)

tokens[i]=buffer;
i++;

//null termination
tokens[i]=NULL;
//=====
pid_t pid=fork();
int status;
pid_t wpid;
if((pid<0))
{
perror("Fork() Failed!\n");
}

  if(pid==0)/*child process*/
   {
    if(execvp(tokens[0],tokens)<0)
     {
      perror("exeC failed");
     }
   }
  else
  {
   //waitpid(pid,&status,0);
  
 do
{
wpid=waitpid(pid,&status,WUNTRACED);
}while(!WIFEXITED(status) && !WIFSIGNALED(status));
  }
printf("$ ");
//fgets(buffer,bufsize,stdin);
scanf("%s",buffer);

}


//printf("%s\n",tokens[i]);


}

