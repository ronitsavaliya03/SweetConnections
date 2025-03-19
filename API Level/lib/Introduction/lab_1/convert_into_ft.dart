import 'dart:io';

void main(){

  print("Enter meter = ");
  double meter = double.parse(stdin.readLineSync()!);

  double feet = 3.28084 * meter;

  print('The feet is = ');
  stdout.write('${meter} m = ${feet} ft');
}