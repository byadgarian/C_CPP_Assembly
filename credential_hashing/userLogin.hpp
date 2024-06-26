#pragma once
#include <string>
#include <fstream>
#include <iostream>
#include <unordered_map>

using namespace std;

class userLogin {
public:
    userLogin(); // default constructor
    void readIn(const string& filename); // add data from file to hash table
    size_t numberOfUsers(); // return the number of users
    string passWordCheck(const string& userName); // returns the passWord of the given user
    size_t wordBucketIdMethod1(const string& userName); // return the bucket number where the given user is located
    size_t wordBucketIdMethod2(const string& userName); // another way to find the bucket number where the given user is located
    bool validateUser(const string& userName); // look up given user
    bool authenticateUser(const string& userName, const string& passWord);// authenticate given user and password
private:
    unordered_map< string, string > table;
};

userLogin::userLogin() {
}



// COMPLETE THE FOLLOWING FUNCTIONS



// TO BE COMPLETED
void userLogin::readIn(const string& filename) {
    string username, password;
    ifstream file(filename);                    //open the file containing usernames and passwords
    if(file.is_open()){                         //make sure the file is open, if not throw an exception
        while(file >> username >> password){    //read data from file as long as reading retuns true (the end of file is not reached)
            table.insert({username, password}); //insert() inserts each pair (set of key and value) that was read from file into hash table
        }
        file.close();                           //close the file at the end of reading
    }
    else
    {
        throw std::invalid_argument(filename + " not found.");  //exit with error message indicating file was not found
    }
}

// TO BE COMPLETED
size_t userLogin::numberOfUsers() {
    return table.size();    //size() returns the number of elements in the hash table
}

// TO BE COMPLETED
string userLogin::passWordCheck(const string& userName) {
    if(table.count(userName) != 0){     //can't use contains() in C++17 - see authenticateUser() comments
                                        //ensures invalid usernames are skipped to prevent out_of_range exception
        return table.at(userName);      //if key is valid, at() returns the value of the pair with key 'userName'
    }
    return "Non-existent User";         //if key is invalid, return this statement
}

// TO BE COMPLETED
size_t userLogin::wordBucketIdMethod1(const string& userName) {
    return table.bucket(userName);  //bucket() returns the number of buckets which is the same as the number of vector indices
}

// TO BE COMPLETED
size_t userLogin::wordBucketIdMethod2(const string& userName) {
            unordered_map<string, string>::hasher hashFunction = table.hash_function(); //create a variable of type 'hash function' and insert
                                                                                        //the string generated by hash_function into it to form a usable
                                                                                        //function.
            return hashFunction(userName) % table.bucket_count();                       //hashFunction returns the hash code for key 'username',
                                                                                        //table_count returns number of indices, and mod operator converts
                                                                                        //hash code to index #
}                                                                                   

// TO BE COMPLETED
bool userLogin::validateUser(const string& userName) {
     if(table.count(userName) != 0){    //can't use contains() in C++17 - see authenticateUser() comments
        return true;                    //return true if number of elements with key 'userName' is not 0 (is 1)
     }
     return false;                      //return false if number of elements with key 'userName' is 0
}

// TO BE COMPLETED
bool userLogin::authenticateUser(const string& userName, const string& passWord) { 
    if(table.count(userName) != 0){             //can't use contains() in C++17 - function only available in C++20 and later versions
        if(table.at(userName) == passWord){     //in unordered_map, count() returns the number of elements in a bucket
            return true;                        //since duplicate valuse are not allowed, count() either reutns 1 (if element exists) or 0 (otherwise)
        }
    }
    return false;                               //returns false if number of elements with key 'userName' is 0
}