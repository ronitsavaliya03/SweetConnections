import 'dart:io';

void main(){
  stdout.write("Enter the number 1:");
  double a= double.parse(stdin.readLineSync()!);

  stdout.write("Operation:");
  String o= stdin.readLineSync()!;

  stdout.write("Enter the number 2:");
  double b= double.parse(stdin.readLineSync()!);

  switch(o){
    case '+': print('$a + $b = ${a+b}');
    case '-': print('$a - $b = ${a-b}');
    case '/': print('$a / $b = ${a/b}');
    case '*': print('$a *5 $b = ${a*b}');
  }

}