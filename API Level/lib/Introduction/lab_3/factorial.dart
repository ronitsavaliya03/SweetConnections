import 'dart:io';

void main(){
  stdout.write("Enter the number:");
  int n= int.parse(stdin.readLineSync()!);

  int ans=fact(n);
  print(ans);
}

int fact(int n){
  if(n==1){
    return 1;
  }else{
    return n*fact(n-1);
  }
}