#include <stdio.h>
#include <stdlib.h>
#include <pthread.h>
#include "util.h"
#include <sys/wait.h>
static int arguments;
void *print_hello_world (void *threadargs);
pthread_mutex_t mutex1 = PTHREAD_MUTEX_INITIALIZER;
struct thread_data{
char *argument;
int repetitions;
};
int main(int argc,char *argv[])
{   int NumOfStrings=argc-2;
    pthread_t threads[NumOfStrings];
    int err;
    int i;
    arguments=argc-2;
struct thread_data td[NumOfStrings];
int rep=atoi(argv[1]);


for(i=2;i<argc;i++){ 
   td[i].argument=argv[i];
   td[i].repetitions=rep;
   err= pthread_create (&threads[i], NULL, print_hello_world,(void *)&td[i]);
    if(err)
    {
        fprintf(stderr, "Error - pthread_create() return code: %d\n",err);
        exit(EXIT_FAILURE);
    }

}
   for(i=2;i<argc;i++){ 
    pthread_join(threads[i], NULL);
    }
    pthread_mutex_destroy(&mutex1);

exit(EXIT_SUCCESS);
pthread_exit(NULL);
return 0;
}

void *print_hello_world (void* parameters)
{   struct thread_data *p=(struct thread_data *) parameters; 

  pthread_mutex_lock( &mutex1 );    
    init();
  --arguments;
   pthread_mutex_unlock ( &mutex1 );
    int i;
//we make use of busy wait in order to keep busy our threads until every thread have execute init();
while(arguments>0)
{
wait(NULL);
}


 
 for (i=0; i<p->repetitions;  i++){
        pthread_mutex_lock( &mutex1 );    
         display(p->argument);
        pthread_mutex_unlock ( &mutex1 );
    }

}
