import 'dart:io';

void main(){
  stdout.write("Enter the number of term:");
  int n= int.parse(stdin.readLineSync()!);

  fibbo(n: n);
}

fibbo({int? n}){
  if(n==1){
    print("0");
  }
  else if(n!>1){
    int n1 = 0;
    int n2 = 1;
    int n3 = n1+n2;

    print(0);
    print(1);
    for(int i = 3; i<=n; i++){
      print(n3);
      n1=n2;
      n2=n3;
      n3= n1+n2;
    }

  }
}