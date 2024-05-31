#include <string>
#include <iostream>
#include <fstream>
#include <stdexcept>
#include "SensorCluster.hpp"

using std::string;
using std::ifstream;
using std::cout;
using std::endl;



// COMPLETE THE FOLLOWING FUNCTIONS



// TO BE COMPLETED
// function to return the hash value based on the first digit
unsigned int hashfct1(unsigned int nic) {
  std::string int_string = std::to_string(nic);
  int first = (int)int_string[0] - (int)'0';  //subtract ASCII value of desired element form ASCII value of '0' to find char value of element
  return first;
}

// TO BE COMPLETED
// function to return the hash value based on the second digit
unsigned int hashfct2(unsigned int nic) {
  std::string int_string = std::to_string(nic);
  int second = (int)int_string[1] - (int)'0';  //subtract ASCII value of desired element form ASCII value of '0' to find char value of element
  return second;
}

// TO BE COMPLETED
// function to return the hash value based on the third digit
unsigned int hashfct3(unsigned int nic) {
  std::string int_string = std::to_string(nic);
  int third = (int)int_string[2] - (int)'0'; //subtract ASCII value of desired element form ASCII value of '0' to find char value of element
  return third;
}

// TO BE COMPLETED
// function to return the hash value based on the fourth digit
unsigned int hashfct4(unsigned int nic) {
  std::string int_string = std::to_string(nic);
  int forth = (int)int_string[3] - (int)'0'; //subtract ASCII value of desired element form ASCII value of '0' to find char value of element
  return forth;
}

// TO BE COMPLETED
// function to return the hash value based on the fifth digit
unsigned int hashfct5(unsigned int nic) {
  std::string int_string = std::to_string(nic);
  int fifth = (int)int_string[4] - (int)'0'; //subtract ASCII value of desired element form ASCII value of '0' to find char value of element
  return fifth;
}

// TO BE COMPLETED
// function to return the hash value based on the fourth digit
unsigned int hashfct6(unsigned int nic) {
  std::string int_string = std::to_string(nic);
  int sixth = (int)int_string[5] - (int)'0'; //subtract ASCII value of desired element form ASCII value of '0' to find char value of element
  return sixth;
}

// Constructor for struct Item
Item::Item(string itemName, unsigned int nic):itemName_(itemName), nic_(nic)
{};

// THIS FUNCTION IS COMPLETE
// Load information from a text file with the given filename
void SensorNIC::readTextfile(string filename) {
  ifstream myfile(filename);

  if (myfile.is_open()) {
    cout << "Successfully opened file " << filename << endl;
    string itemName;
    unsigned int nic;
    while (myfile >> itemName >> nic) {
			if (itemName.size() > 0)
      	addItem(itemName, nic);
    }
    myfile.close();
  }
  else
    throw std::invalid_argument("Could not open file " + filename);
}



// COMPLETE THE FOLLOWING FUNCTIONS



// TO BE COMPLETED
// function that adds the specified NIC to the sensor network (i.e., to all hash tables)
void SensorNIC::addItem(string itemName, unsigned int nic) {
  Item item;
  item.itemName_ = itemName;
  item.nic_ = nic;
  hT1.insert({nic, item});
  hT2.insert({nic, item});
  hT3.insert({nic, item});
  hT4.insert({nic, item});
  hT5.insert({nic, item});
  hT6.insert({nic, item});
}

// TO BE COMPLETED
// function that removes the sensor specified by the nic value from the network
// if sensor is found, then it is removed and the function returns true
// else returns false
bool SensorNIC::removeItem(unsigned int nic) {
  if(hT1.find(nic) != hT1.end()){   //if nic exists in one table, it exists in all tables - end() returns a pointer to the element past the end
    hT1.erase(nic);
    hT2.erase(nic);
    hT3.erase(nic);
    hT4.erase(nic);
    hT5.erase(nic);
    hT6.erase(nic);
    return true;
  }
  return false;
}

// TO BE COMPLETED
//function that decides the best hash function
unsigned int SensorNIC::bestHashing() {
  int min = hT1.bucket_size(0);   //assume first bucket is min
  int max = hT1.bucket_size(0);   //assume first bucket is also max
  for(int i = 1; i < 10; i++){
    if(hT1.bucket_size(i) < min)
      min = hT1.bucket_size(i);
    if(hT1.bucket_size(i) > max)
      max = hT1.bucket_size(i);
  }
  int balance = max - min;
  int min_balance = balance;    //assume first table has minimum balance
  int min_table = 1;            //assume first table is minimum table

  min = hT2.bucket_size(0);   //assume first bucket is min
  max = hT2.bucket_size(0);   //assume first bucket is also max
  for(int i = 1; i < 10; i++){
    if(hT2.bucket_size(i) < min)
      min = hT2.bucket_size(i);
    if(hT2.bucket_size(i) > max)
      max = hT2.bucket_size(i);
  }
  balance = max - min;
  if(balance < min_balance){    //if this table has a lower balance, choose as minimum table
    min_balance = balance;
    min_table = 2;
  }

  min = hT3.bucket_size(0);   //assume first bucket is min
  max = hT3.bucket_size(0);   //assume first bucket is also max
  for(int i = 1; i < 10; i++){
    if(hT3.bucket_size(i) < min)
      min = hT3.bucket_size(i);
    if(hT3.bucket_size(i) > max)
      max = hT3.bucket_size(i);
  }
  balance = max - min;
  if(balance < min_balance){    //if this table has a lower balance, choose as minimum table
    min_balance = balance;
    min_table = 3;
  }

  min = hT4.bucket_size(0);   //assume first bucket is min
  max = hT4.bucket_size(0);   //assume first bucket is also max
  for(int i = 1; i < 10; i++){
    if(hT4.bucket_size(i) < min)
      min = hT4.bucket_size(i);
    if(hT4.bucket_size(i) > max)
      max = hT4.bucket_size(i);
  }
  balance = max - min;
  if(balance < min_balance){    //if this table has a lower balance, choose as minimum table
    min_balance = balance;
    min_table = 4;
  }

  min = hT5.bucket_size(0);   //assume first bucket is min
  max = hT5.bucket_size(0);   //assume first bucket is also max
  for(int i = 1; i < 10; i++){
    if(hT5.bucket_size(i) < min)
      min = hT5.bucket_size(i);
    if(hT5.bucket_size(i) > max)
      max = hT5.bucket_size(i);
  }
  balance = max - min;
  if(balance < min_balance){    //if this table has a lower balance, choose as minimum table
    min_balance = balance;
    min_table = 5;
  }

  min = hT6.bucket_size(0);   //assume first bucket is min
  max = hT6.bucket_size(0);   //assume first bucket is also max
  for(int i = 1; i < 10; i++){
    if(hT6.bucket_size(i) < min)
      min = hT6.bucket_size(i);
    if(hT6.bucket_size(i) > max)
      max = hT6.bucket_size(i);
  }
  balance = max - min;
  if(balance < min_balance){    //if this table has a lower balance, choose as minimum table
    min_balance = balance;
    min_table = 6;
  }

  return min_table;
}

// THIS FUNCTION IS COMPLETE
size_t SensorNIC::size() {
    if ((hT1.size() != hT2.size()) || (hT1.size() != hT3.size()) || (hT1.size() != hT4.size()) || (hT1.size() != hT5.size())|| (hT1.size() != hT6.size()) )
  	throw std::length_error("Hash table sizes are not the same");
    
	return hT1.size();
}