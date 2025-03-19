import 'dart:io';

void main(){
  stdout.write("Enter the Number:");
  int a=int.parse(stdin.readLineSync()!);

  if(isPrime(a)){
    print("Number is Prime");
  }else{
    print("Number is not Prime");
  }
}

bool isPrime(int n){
  for(int i=2; i<n/2; i++){
    if(n%i==0){
      return false;
      break;
    }else{
      return true;
    }
  }
  return true;
}