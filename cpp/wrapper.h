#ifndef WRAPPER_H_
#define WRAPPER_H_

#ifdef __cplusplus
extern "C"
{
#endif

void *call_Person_Create();
void call_Person_Destroy(void *);
int call_Person_GetAge(void*);
const char *call_Person_GetName(void*);

void call_Person_SetAge(void*, int age);
void call_Person_SetName(void*, char* name);


#ifdef __cplusplus
}
#endif

#endif // WRAPPER_H_
