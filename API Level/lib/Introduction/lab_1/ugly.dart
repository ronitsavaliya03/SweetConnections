import 'dart:io';

void main(){

  print("Enter the number = ");
  int a = int.parse(stdin.readLineSync()!);
  int flag = 0;

  for(int i = 2 ; i <= a/2 ; i++){
    if(!(a % 2 == 0 || a% 3 == 0 || a % 5 == 0)){
      flag = 0;
    }
    else{
      print("The number is not ugly");
    }
  }
}