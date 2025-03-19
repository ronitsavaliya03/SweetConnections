import 'dart:io';

void main(){
  print("Enter the 1st number:");
  double a= double.parse(stdin.readLineSync()!);

  print("Enter the 2st number:");
  double b= double.parse(stdin.readLineSync()!);

  print("Enter the 3st number:");
  double c= double.parse(stdin.readLineSync()!);

  if(a>b){
    if(a>c){
      print(a);
    }else{
      print(c);
    }
  }else if(b>c){
    print(b);
  }else{
    print(c);
  }

}