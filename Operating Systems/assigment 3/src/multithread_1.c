#include <stdio.h>
#include <stdlib.h>
#include <pthread.h>
#include "util.h"
#include <sys/wait.h>
void *print_hello_world (void *threadargs);
pthread_mutex_t mutex1 = PTHREAD_MUTEX_INITIALIZER;
//we define a struct thread_data in order to pass the info that we need into thread function
struct thread_data{
char *argument;
int repetitions;
};
int main(int argc,char *argv[])
{   int NumOfStrings=argc-2;
    pthread_t threads[NumOfStrings];
    int err;
    int i;
//we create a struct array in order to pass info for every string that we need to create a thread
struct thread_data td[NumOfStrings];
int rep=atoi(argv[1]); //we convert our argv[1] into an integer 

//creation of threads for every input string
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
//after thread creation we need to join them at the end
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

    int i;
  //every thread display the input string "rep" times
    for (i=0; i<p->repetitions;  i++){
        pthread_mutex_lock( &mutex1 );    
         display(p->argument);
        pthread_mutex_unlock ( &mutex1 );
    }

}
