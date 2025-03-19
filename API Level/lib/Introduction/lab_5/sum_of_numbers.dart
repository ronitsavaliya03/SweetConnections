import 'dart:io';

void main(){
  List<int> list=[];

  while(true){
    stdout.write("Enter the element (Enter 0 for exit:): ");
    int n= int.parse(stdin.readLineSync()!);

    if(n==-1){
      break;
    }else{
      list.add(n);
    }
  }

  int sum=0;
  for(int i=0; i<list.length; i++){
     if(list[i]%2==0 || list[i]%3==0){
       sum+=list[i];
     }
  }

  print(sum);
}