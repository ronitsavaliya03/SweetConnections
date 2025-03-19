import 'dart:io';

void main(){
  print("Enter number 1 = ");
  int a = int.parse(stdin.readLineSync()!);

  print("Enter number 2 = ");
  int b = int.parse(stdin.readLineSync()!);

  print("The answer is = ");
  stdout.write(a + b);
}