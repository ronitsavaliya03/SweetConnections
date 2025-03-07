import 'package:matrimonial_app/screens/user_list.dart';

import './constants.dart';
class User {
  List<Map<String, dynamic>> userList = [
    {
      NAME: 'Ronit Savaliya',
      CITY: 'New York',
      EMAIL: 'r@gmail.com',
      PHONE: '8488818874',
      AGE: 24,
      DOB: '18/05/2001',
      GENDER: 'Male',
      HOBBIES: ['Cricket', 'Travelling', 'Reading'],
      ISLIKED: false,
      PASSWORD: '123456',
      EDUCATION: 'Btech in Computer Science',
      OCCUPATION: 'Developer',
      WORK_PLACE: 'Weey Bey, Rajkot',
      INCOME: 560000
    },
    {
      NAME: 'Aisha Patel',
      CITY: 'San Francisco',
      EMAIL: 'aisha.p@gmail.com',
      PHONE: '9988776655',
      AGE: 27,
      DOB: '12/09/1996',
      GENDER: 'Female',
      HOBBIES: ['Painting', 'Cooking', 'Yoga'],
      ISLIKED: true,
      PASSWORD: '987654',
      EDUCATION: 'MSc in Data Science',
      OCCUPATION: 'Data Scientist',
      WORK_PLACE: 'Google, California',
      INCOME: 1200000
    },
    {
      NAME: 'Jason Roy',
      CITY: 'Los Angeles',
      EMAIL: 'jroy@gmail.com',
      PHONE: '7676767676',
      AGE: 29,
      DOB: '22/07/1994',
      GENDER: 'Male',
      HOBBIES: ['Gaming', 'Football', 'Blogging'],
      ISLIKED: false,
      PASSWORD: 'abcdef',
      EDUCATION: 'BBA in Marketing',
      OCCUPATION: 'Marketing Manager',
      WORK_PLACE: 'Amazon, Seattle',
      INCOME: 900000
    },
    {
      NAME: 'Sophia Williams',
      CITY: 'Boston',
      EMAIL: 'sophia.w@gmail.com',
      PHONE: '8765432190',
      AGE: 26,
      DOB: '05/04/1997',
      GENDER: 'Female',
      HOBBIES: ['Dancing', 'Photography', 'Swimming'],
      ISLIKED: false,
      PASSWORD: 'sophia123',
      EDUCATION: 'BA in Journalism',
      OCCUPATION: 'Journalist',
      WORK_PLACE: 'CNN, New York',
      INCOME: 750000
    },
    {
      NAME: 'David Miller',
      CITY: 'Chicago',
      EMAIL: 'david.m@gmail.com',
      PHONE: '9876543210',
      AGE: 31,
      DOB: '14/02/1992',
      GENDER: 'Male',
      HOBBIES: ['Gym', 'Cycling', 'Traveling'],
      ISLIKED: false,
      PASSWORD: 'dmiller456',
      EDUCATION: 'MBA in Finance',
      OCCUPATION: 'Investment Banker',
      WORK_PLACE: 'Goldman Sachs, Chicago',
      INCOME: 1500000
    },
    {
      NAME: 'Emily Clark',
      CITY: 'Miami',
      EMAIL: 'emily.c@gmail.com',
      PHONE: '6543219870',
      AGE: 28,
      DOB: '30/11/1995',
      GENDER: 'Female',
      HOBBIES: ['Cooking', 'Tennis', 'Music'],
      ISLIKED: false,
      PASSWORD: 'emilyc123',
      EDUCATION: 'MSc in Psychology',
      OCCUPATION: 'Psychologist',
      WORK_PLACE: 'MindCare, Miami',
      INCOME: 700000
    },
    {
      NAME: 'Alex Johnson',
      CITY: 'Seattle',
      EMAIL: 'alex.j@gmail.com',
      PHONE: '7654321980',
      AGE: 30,
      DOB: '10/06/1993',
      GENDER: 'Male',
      HOBBIES: ['Chess', 'Reading', 'Coding'],
      ISLIKED: false,
      PASSWORD: 'alexj789',
      EDUCATION: 'PhD in Artificial Intelligence',
      OCCUPATION: 'AI Researcher',
      WORK_PLACE: 'OpenAI, San Francisco',
      INCOME: 1800000
    },
    {
      NAME: 'Priya Sharma',
      CITY: 'Delhi',
      EMAIL: 'priya.s@gmail.com',
      PHONE: '9123456780',
      AGE: 25,
      DOB: '20/08/1998',
      GENDER: 'Female',
      HOBBIES: ['Sketching', 'Dancing', 'Writing'],
      ISLIKED: false,
      PASSWORD: 'priya@321',
      EDUCATION: 'Btech in IT',
      OCCUPATION: 'Software Engineer',
      WORK_PLACE: 'Microsoft, Hyderabad',
      INCOME: 850000
    },
    {
      NAME: 'Ethan Parker',
      CITY: 'Toronto',
      EMAIL: 'ethan.p@gmail.com',
      PHONE: '9823456789',
      AGE: 27,
      DOB: '07/03/1996',
      GENDER: 'Male',
      HOBBIES: ['Hiking', 'Photography', 'Fishing'],
      ISLIKED: false,
      PASSWORD: 'ethanp123',
      EDUCATION: 'BSc in Environmental Science',
      OCCUPATION: 'Wildlife Photographer',
      WORK_PLACE: 'National Geographic, Toronto',
      INCOME: 600000
    },
    {
      NAME: 'Olivia Brown',
      CITY: 'Sydney',
      EMAIL: 'olivia.b@gmail.com',
      PHONE: '8901234567',
      AGE: 32,
      DOB: '25/12/1991',
      GENDER: 'Female',
      HOBBIES: ['Yoga', 'Gardening', 'Traveling'],
      ISLIKED: true,
      PASSWORD: 'oliviab@456',
      EDUCATION: 'MA in Literature',
      OCCUPATION: 'Author',
      WORK_PLACE: 'Freelancer',
      INCOME: 950000
    }
  ];

  List<Map<String, dynamic>> searchResultList = [];
  // List<Map<String, dynamic>> favoriteUsers =
  // user.userList.where((user) => user[ISLIKED] == true).toList();

  void addUserInList({required name, required age, required email}) {
    Map<String, dynamic> map = {};

    map[NAME] = name;
    map[AGE] = age;
    map[EMAIL] = email;

    userList.add(map);
  }

  List<Map<String, dynamic>> display() {
    return userList;
  }

  // void updateFavoriteList(){
  //   favoriteUsers =
  //   user.userList.where((user) => user[ISLIKED] == true).toList();
  // }

  void updateUser({ name, age, email, required id}) {
    Map<String, dynamic> map = {};

    map[NAME] = name;
    map[AGE] = age;
    map[EMAIL] = email;

    userList[id] = map;
  }

  void deleteUser({required int id}) {
    if (id >= 0 && id < userList.length) {
      userList.removeAt(id);
    }
  }


  // void deleteUser({required id}) {
  //   if(userList[id][ISLIKED]==false){
  //     userList.removeAt(id);
  //   }
  //   else{
  //     favoriteUsers.removeAt(id);
  //   }
  // }

  List<Map<String, dynamic>> searchDeatil({required searchData}) {
    searchResultList = [];

    for (var element in userList) {
      if (element[NAME]
          .toString()
          .toLowerCase()
          .contains(searchData.toString().toLowerCase()) ||
          element[CITY]
              .toString()
              .toLowerCase()
              .contains(searchData.toString().toLowerCase())) {
        searchResultList.add(element);
      }
    }
    // print('SearchList: ${searchResultList}');
    return searchResultList;
  }

  // void deleteUserFromSearchList({required int index}) {
  //   if (index < 0 || index >= searchResultList.length) return;
  //
  //   Map<String, dynamic> userToDelete = searchResultList[index];
  //
  //   userList.removeWhere((user) => user[EMAIL] == userToDelete[EMAIL]);
  //
  //   searchResultList.removeAt(index);
  // }

  void deleteUserFromSearchList({required int index}) {
    if (index >= 0 && index < searchResultList.length) {
      var userToRemove = searchResultList[index];
      userList.remove(userToRemove);
      searchResultList.removeAt(index);
    }
  }


}