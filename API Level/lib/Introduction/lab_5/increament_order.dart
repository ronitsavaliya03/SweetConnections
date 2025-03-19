import 'dart:io';

void main(){
  List<int> list=[];

  for(int i=0; i<5; i++){
    stdout.write("Enter the element:");
    int a=int.parse(stdin.readLineSync()!);
    list.add(a);
  }

  list.sort();
  print(list);
}