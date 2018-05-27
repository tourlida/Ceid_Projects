#include <stdio.h>
#include <stdlib.h>
#include <sys/types.h>
#include <unistd.h>
#include <string.h>
#include <sys/wait.h>

char **parse(char * buffer);
int execute(char **cmd_tokens);
int main(int argc, char *argv[])
{
//int i=0;
char *buffer; //equilevant to the variable cmd
size_t bufsize = 128;
//size_t input;
//char *cmd_tokens;
char **args;
char *path;
size_t path_size=1024;
while(1)
{
buffer=(char *)malloc(bufsize * sizeof(char)); //we allocate memory for the buffer
path=(char *)malloc(bufsize * sizeof(char));
if( buffer == NULL)
{
perror("Unable to allocate memory");
exit(1);
}


   printf("$ ");

  // printf("Type something:\n");
   //getline(&buffer,&bufsize,stdin); //geting my input
  scanf("%[^\n]%*c",buffer); 
  if(strcmp(buffer,"exit")==0)
     {
        exit(-1);
     }
    args=parse(buffer); 
   if(strcmp(buffer,"cd")==0)
   {
    if(args[1]==NULL)
  {break;}
   else{
   path=getcwd(path,path_size);
   strcat(path,"/");
   strcat(path,args[1]);
//path=getcwd(buffer,path_size);
   //printf("%s\n",args[1]);
  // chdir(args[1]);
  // strcat(path,"/");
   //strcat(path,args[1]);
  // chdir(args[1]);
    // path=getcwd(buffer,path_size);
   // printf("%s",path);
   
    chdir(path);
  //printf("%s",path);
     // path=getcwd(path,path_size);
  //  return;  
    

   } 
}
    /*cmd_tokens=strtok(buffer," "); //we parse our tokens taking " " as a delimiter
    while(cmd_tokens!=NULL)
    {
      // printf("%s\n",cmd_tokens);
      // buffer[i]=cmd_tokens;
      printf("%s\n",cmd_tokens);
     //printf("%s\n",buffer[i]);
      
       
       if(i>=bufsize)
       {
          bufsize=bufsize+1;
          buffer=realloc(buffer,bufsize * sizeof(char));
       }
         cmd_tokens=strtok(NULL," ");
      i++;

     // printf("%s\n",cmd_tokens);
}//end of while 

*/

else
{execute(args);
}

}
free(args);
free(buffer); // we free the memory that we allocate
//free(cmd_tokens);
}




char **parse(char * buffer)\
{   int i=0;
    size_t bufsize = 128;
    char **cmd_tokens=malloc(bufsize * sizeof(char));
    char *token;
    token=strtok(buffer," \t"); //we parse our tokens taking " " as a delimiter
    while(token!=NULL)
    {
      // printf("%s\n",cmd_tokens);
      // buffer[i]=cmd_tokens;
     // printf("%s\n",cmd_tokens);
     //printf("%s\n",buffer[i]);
      cmd_tokens[i]=token;
     //printf("%s\n",cmd_tokens[i]);
      i++;
       if(i>=bufsize)
       {
          bufsize=bufsize+1;
          cmd_tokens=realloc(cmd_tokens,bufsize * sizeof(char));
       }
         token=strtok(NULL," \t");
         

}

       cmd_tokens[i]=NULL;
       return cmd_tokens;
}

int execute(char **cmd_tokens)
{

pid_t pid=fork();
pid_t wpid;
int status;
if((pid<0))
{
perror("Fork() Failed!\n");
}

if(pid==0)//child process
{
 //printf("%s",cmd_tokens[0]);
  if(execvp(cmd_tokens[0],cmd_tokens)<0)
  {
  perror("exeC failed");
  }
}
else
{
//parent

 do
{
wpid=waitpid(pid,&status,WUNTRACED);
}while(!WIFEXITED(status) && !WIFSIGNALED(status));
 
}//end of if

return 1;

}



