import 'dart:io';

void main(){
  stdout.write("Enter the Number1:");
  double a=double.parse(stdin.readLineSync()!);

  stdout.write("Enter the Number2:");
  double b=double.parse(stdin.readLineSync()!);

  double ans=max(a, b);
  print("Maximum Number is ${ans}");
}

max(double a, double b){
  if(a>b){
    return a;
  }else{
    return b;
  }
}