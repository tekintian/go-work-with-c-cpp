#include <iostream>
#include "person.h"

Person::Person(std::string name, int age)
    : name_(name),
      age_(age) {

      }
/**
 * @brief
 *
 * @param name
 */
void Person::setName(std::string name) {
  this->name_ = name;
  }
/**
 * @brief 
 *
 * @param age
 */
void Person::setAge(int age){
   this->age_=age;
}