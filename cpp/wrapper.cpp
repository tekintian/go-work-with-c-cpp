#include "person.h"
#include "wrapper.h"

void *call_Person_Create() {
  return new Person("Alex", 18);
}

void call_Person_Destroy(void *p) {
  delete static_cast<Person*>(p);
}

int call_Person_GetAge(void* p) {
  return static_cast<Person*>(p)->GetAge();
}
const char *call_Person_GetName(void* p) {
   return static_cast<Person *>(p)->GetName();
}

void call_Person_SetAge(void *p, int age) {
  static_cast<Person *>(p)->setAge(age);
 }
 void call_Person_SetName(void *p, char *name) {
   static_cast<Person *>(p)->setName(name);
 }