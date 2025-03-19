import 'dart:io';

void main(){
  print("Enter the hour:");
  int hour= int.parse(stdin.readLineSync()!);

  print("Enter the min:");
  int min= int.parse(stdin.readLineSync()!);

  double angle=(30 * hour)-(5.5 * min);

  if(angle>180){
    angle=360-angle;
  }

  print(angle);
}