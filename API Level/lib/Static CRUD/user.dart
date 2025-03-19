import './constants.dart';
class User {
  List<Map<String, dynamic>> userList = [];
  List<Map<String, dynamic>> searchResultList = [];

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

  void updateUser({ name, age, email, required id}) {
    Map<String, dynamic> map = {};

    map[NAME] = name;
    map[AGE] = age;
    map[EMAIL] = email;

    userList[id] = map;
  }

  void deleteUser({required id}) {
    userList.removeAt(id);
  }

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
              .contains(searchData.toString().toLowerCase()) ||
          element[EMAIL]
              .toString()
              .toLowerCase()
              .contains(searchData.toString().toLowerCase())) {
        searchResultList.add(element);
      }
    }
    print('SearchList: ${searchResultList}');
    return searchResultList;
  }
}