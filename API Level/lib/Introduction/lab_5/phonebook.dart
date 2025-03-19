import 'dart:io';

void main(){
  Map<String, int> phonebook={};

  while(true){
    stdout.write("(Enter -1 for exit:): ");
    int n= int.parse(stdin.readLineSync()!);

    if(n==-1){
      break;
    }

    stdout.write("Enter the name : ");
    String name= (stdin.readLineSync()!);

    stdout.write("Enter the number: ");
    int number= int.parse(stdin.readLineSync()!);

    phonebook[name]=number;
  }

  print(phonebook);
}