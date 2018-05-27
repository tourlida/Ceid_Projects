#include <stdio.h>
#include <string.h>
#include "util.h"
#include <stdlib.h>
#include <sys/types.h>
#include <sys/wait.h>
#include <unistd.h> //include for fork
#include <sys/ipc.h>
//#include <sys/mman.h>
#include <sys/sem.h>	
static int *strings;	
int main(int argc,char *argv[])
{
int rep=atoi(argv[1]); //number of rep 
int i;
int my_sem = semget(IPC_PRIVATE, 1, 0600);   /* CREATE OF THE SEMAPHORES */

    struct sembuf up = {0, 1, 0};       
    struct sembuf down = {0, -1, 0};    

semctl(my_sem, 0, SETVAL,1);
for(i=2;i<argc;i++)
{
pid_t pid=fork();
if(pid<0)
{
perror("Fork error\n");
}else if(pid==0)
{
semop(my_sem, &down, 1);      
init();
semop(my_sem, &up, 1);  

for(int j=0;j<rep;j++)
{ 
semop(my_sem, &down, 1);      /* UP (); */
display(argv[i]);
semop(my_sem, &up, 1);  
}
exit(0);
}

}
//busy wait
for(i=2;i<argc;i++)
{
wait(NULL);
}


semctl(my_sem, 0,IPC_RMID);
return 0;
}
