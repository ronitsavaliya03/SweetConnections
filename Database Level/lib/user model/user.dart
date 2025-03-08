import 'package:matrimonial_app/database/my_database.dart';
import 'package:sqflite/sqflite.dart';
import './constants.dart';

class User {
  List<Map<String, dynamic>> userList = [];

  List<Map<String, dynamic>> searchResultList = [];
  static const String tableName = 'users';

  /// Adds a new user to the common database.
  static Future<int> addUser(Map<String, dynamic> user) async {
    int id = await DatabaseHelper.instance.createUser(user);
    print('User Added with id: $id');
    return id;
  }

  /// Retrieves a user by [id] from the common database.
  static Future<Map<String, dynamic>?> getUser(int id) async {
    return await DatabaseHelper.instance.getUser(id);
  }

  /// Retrieves all users from the common database.
  static Future<List<Map<String, dynamic>>> getAllUsers() async {
    return await DatabaseHelper.instance.getAllUsers();
  }

  /// Updates the user with the given [id] in the common database.
  // static Future<bool> updateUser(Map<String, dynamic> userData) async {
  //   if (!userData.containsKey('ID')) {
  //     throw Exception("User ID is missing for update");
  //   }
  //
  //   int result = await DatabaseHelper.instance.updateUser(userData);
  //   return result > 0;
  // }

  /// Deletes the user with the given [id] from the common database.
  static Future<bool> deleteUser(int id) async {
    int result = await DatabaseHelper.instance.deleteUser(id);
    return result > 0;
  }

  // void deleteUser({required int id}) {
  //   if (id >= 0 && id < userList.length) {
  //     userList.removeAt(id);
  //   }
  // }

  List<Map<String, dynamic>> searchDetail({required searchData}) {
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

  List<Map<String, dynamic>> display() {
    return userList;
  }

  // static Map<String, dynamic> toMap({
  //   int? id,
  //   required String name,
  //   required String email,
  //   required String phone,
  //   required String city,
  //   required String dob,
  //   required String gender,
  //   required String hobbies,
  //   required String othHobbies,
  //   required String education,
  //   required String occupation,
  //   required String workPlace,
  //   required String income,
  //   required String password,
  //   required String conPass,
  //   required int age,
  //   required int isLiked,
  // }) {
  //   return {
  //     'ID': id,
  //     'NAME': name,
  //     'EMAIL': email,
  //     'PHONE': phone,
  //     'CITY': city,
  //     'DOB': dob,
  //     'GENDER': gender,
  //     'HOBBIES': hobbies,
  //     'OTH_HOBBIES': othHobbies,
  //     'EDUCATION': education,
  //     'OCCUPATION': occupation,
  //     'WORK_PLACE': workPlace,
  //     'INCOME': income,
  //     'PASSWORD': password,
  //     'CON_PASS': conPass,
  //     'AGE': age,
  //     'ISLIKED': isLiked,
  //   };
  // }

  // static Map<String, dynamic> fromMap(Map<String, dynamic> map) {
  //   return User.toMap(
  //     id: map['ID'],
  //     name: map['NAME'],
  //     email: map['EMAIL'],
  //     phone: map['PHONE'],
  //     city: map['CITY'],
  //     dob: map['DOB'],
  //     gender: map['GENDER'],
  //     hobbies: map['HOBBIES'],
  //     othHobbies: map['OTH_HOBBIES'],
  //     education: map['EDUCATION'],
  //     occupation: map['OCCUPATION'],
  //     workPlace: map['WORK_PLACE'],
  //     income: map['INCOME'],
  //     password: map['PASSWORD'],
  //     conPass: map['CON_PASS'],
  //     age: map['AGE'],
  //     isLiked: map['ISLIKED'],
  //   );
  // }

  // static Future<bool> updateUser(Map<String, dynamic> userData) async {
  //   if (!userData.containsKey('ID')) {
  //     throw Exception("2. User ID is missing for update");
  //   }
  //
  //   int result = await DatabaseHelper.instance.updateUser(userData);
  //   return result > 0;
  // }
}
