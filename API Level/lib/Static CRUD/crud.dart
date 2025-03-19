import 'dart:io';

import './user.dart';

void main(){
  User user=User();

  while(true){
    print('Select Your Choice From Below Available Options:'
        '\n1. Insert User'
        '\n2. List User'
        '\n3. Update User'
        '\n4. Delete User'
        '\n5. Exit Application');

    print("Enter the choice:");
    int choice=int.parse(stdin.readLineSync()!);

    switch(choice){
      case 1:
        stdout.write("Enter the name:");
        String name=stdin.readLineSync()!;
        stdout.write("Enter the age:");
        int age=int.parse(stdin.readLineSync()!);
        stdout.write("Enter the Email:");
        String email=stdin.readLineSync()!;

        user.addUserInList(name: name, age: age, email: email);
        break;
      case 2:
        List<Map<String,dynamic>> list=user.display();

        for(var element in list){
          print('${element['Name']}.${element['Age']}.${element['Email']}');
        }
        break;
      case 3:
        stdout.write("Enter the id:");
        int id=int.parse(stdin.readLineSync()!);

        stdout.write("which field you want to change?: \n1.Name \n2.Age \n3.Email \nSelect: ");
        int what=int.parse(stdin.readLineSync()!);
        switch(what){
          case 1:
            stdout.write("Enter the name:");
            String name=stdin.readLineSync()!;
            user.updateUser(name: name,id: id);
            break;
          case 2:
            stdout.write("Enter the age:");
            int age=int.parse(stdin.readLineSync()!);
            user.updateUser(age: age, id: id);
            break;
          case 3:
            stdout.write("Enter the Email:");
            String email=stdin.readLineSync()!;
            user.updateUser(email: email, id: id);
            break;
        }

        break;
      case 4:
        stdout.write("Enter the id:");
        int id=int.parse(stdin.readLineSync()!);

        user.deleteUser(id: id);
        break;
      case 5:
        exit(1);
      default:
        stdout.write("Invalid Number!");
        break;
    }
  }
}