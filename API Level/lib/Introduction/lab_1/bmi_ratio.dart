import 'dart:io';

void main(){
  print("Enter the weigh in pounds = ");
  double weightInPounds = double.parse(stdin.readLineSync()!);

  print("Enter the height in inches = ");
  double heightInInches = double.parse(stdin.readLineSync()!);

  double kg = weightInPounds * (0.45359237);
  double height = heightInInches * (0.254);

  double bmi = kg / (height * height);

  print('The bmi is = ');
  stdout.write(bmi);
}