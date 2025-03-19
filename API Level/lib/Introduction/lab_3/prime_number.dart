import 'dart:io';

void main(){
  stdout.write("Enter the number:");
  int n= int.parse(stdin.readLineSync()!);
  bool flag=true;

  for(int i=2; i<=n/2; i++){
    if(n%i==0){
      flag=false;
    }
  }

  if(flag){
    print("Number is prime.");
  }else{
    print("Number is not prime");
  }
}