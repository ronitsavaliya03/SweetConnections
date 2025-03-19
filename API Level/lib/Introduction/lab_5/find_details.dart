import 'dart:io';

class Friends{
  int stuId;
  String name;
  int age;
  int number;

  Friends(this.stuId, {required this.name, required this.age, required this.number});
}

void main(){
  Map<String,Friends> friends={};

  while(true){
    stdout.write("(Enter -1 for exit:): ");
    int n= int.parse(stdin.readLineSync()!);

    if(n==-1){
      break;
    }

    stdout.write("Enter the student Id:");
    int id= int.parse(stdin.readLineSync()!);

    stdout.write("Enter the student Name:");
    String name= (stdin.readLineSync()!);

    stdout.write("Enter the student Age:");
    int age= int.parse(stdin.readLineSync()!);

    stdout.write("Enter the student number:");
    int number= int.parse(stdin.readLineSync()!);

    friends[name]=Friends(id, name: name, age: age, number: number);

  }

  stdout.write("Enter the student number:");
  String searchName=stdin.readLineSync()!;

  friends.forEach((key, value){
    if(key==searchName){
      print(value.age);
    }
  });

}