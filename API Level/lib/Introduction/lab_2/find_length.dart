import 'dart:io';

void main(){
  stdout.write("Enter the string:");
  String str= stdin.readLineSync()!;
  int count=0;
  int lenght=str.length-1;

  while(lenght>=0 && str[lenght]!=" "){
    count++;
    lenght--;
  }

  print(count);
}