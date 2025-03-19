import 'dart:io';

void main(){
  List<int> list=[];

  while(true){
    stdout.write("Enter the element (Enter 0 for exit:): ");
    int n= int.parse(stdin.readLineSync()!);

    if(n==0){
      break;
    }else{
      list.add(n);
    }
  }

  stdout.write("Even Numbers:");
  print(countEven(list));
  stdout.write("Odd Numbers:");
  print(countOdd(list));
}

countEven(List<int> list){
  int count=0;

  for(int i=0; i<list.length; i++){
    if(list[i]%2==0){
      count++;
    }
  }

  return count;
}

countOdd(List<int> list){
  int count=0;

  for(int i=0; i<list.length; i++){
    if(list[i]%2!=0){
      count++;
    }
  }

  return count;
}