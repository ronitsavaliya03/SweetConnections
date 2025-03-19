import 'dart:io';

void main() {
  print("Enter the marks of subject 1 = ");
  double sub1 = double.parse(stdin.readLineSync()!);

  print("Enter the marks of subject 2 = ");
  double sub2 = double.parse(stdin.readLineSync()!);

  print("Enter the marks of subject 3 = ");
  double sub3 = double.parse(stdin.readLineSync()!);

  print("Enter the marks of subject 4 = ");
  double sub4 = double.parse(stdin.readLineSync()!);

  print("Enter the marks of subject 5 = ");
  double sub5 = double.parse(stdin.readLineSync()!);

  double result = ((sub1 + sub2 + sub3 + sub4 + sub5) / 5);

  print('The result is = ${result}% ');
}