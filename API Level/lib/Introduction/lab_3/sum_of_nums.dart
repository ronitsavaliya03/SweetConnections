import 'dart:io';

void main(){
  int sum1=0;
  int sum2=0;

  print("Enter 0 for break loop..");
  while(true){
    stdout.write("Enter the number:");
    int temp= int.parse(stdin.readLineSync()!);

    if(temp==0){
      break;
    }else if(temp%2==0 && temp>0){
      sum1+=temp;
    }else if(temp%2!=0 && temp<0){
      sum2+=temp;
    }
  }

  print('Sum of Even Positive Number is: ${sum1}');
  print('Sum of Odd Negative Number is: ${sum2}');
}