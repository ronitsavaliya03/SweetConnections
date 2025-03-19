import 'dart:io';
void main(){
  stdout.write("Enter the Principle:");
  double p=double.parse(stdin.readLineSync()!);

  stdout.write("Enter the Rate:");
  double r=double.parse(stdin.readLineSync()!);

  stdout.write("Enter the Time(Year):");
  double t=double.parse(stdin.readLineSync()!);

  double ans= interest(p,r,t);

  print(ans);

}

interest(double p, [double r=1, double t=1]){
  print("Simple Interest:");
  return (p*r*t)/100;
}