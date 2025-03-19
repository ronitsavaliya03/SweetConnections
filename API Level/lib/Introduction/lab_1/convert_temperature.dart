import 'dart:io';

void main(){
  print("Enter fahrenhit = ");
  double fahrenhit = double.parse(stdin.readLineSync()!);

  double celcius = (fahrenhit + 32) * (5/9);

  stdout.write(celcius);
}