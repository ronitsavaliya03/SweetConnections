import 'dart:io';

void main(){
  stdout.write("Enter a number:");
  double n= double.parse(stdin.readLineSync()!);

  if(n>0){
    print("Positive");
  }
  else if(n==0){
    print("Zero");
  }
  else{
    print("Negative");
  }
}