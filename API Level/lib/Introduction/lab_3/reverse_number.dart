import 'dart:io';

void main(){
  stdout.write("Enter the number:");
  int n= int.parse(stdin.readLineSync()!);
  int revnum=0;

  while(n != 0){
    int rem= n%10;
    revnum = (revnum*10) + rem;
    n = int.parse((n/10).toStringAsFixed(0));
  }

  print(revnum);
}