import 'dart:io';

void main(){
  List<int> list1=[];

  print("Enter the List1");
  while(true){
    stdout.write("Enter the element (Enter -1 for exit:): ");
    int n= int.parse(stdin.readLineSync()!);

    if(n==-1){
      break;
    }else{
      list1.add(n);
    }
  }

  List<int> list2=[];

  print("Enter the List2");
  while(true){
    stdout.write("Enter the element (Enter -1 for exit:): ");
    int n= int.parse(stdin.readLineSync()!);

    if(n==-1){
      break;
    }else{
      list2.add(n);
    }
  }

  List<int> common=[];

  list1.forEach((e){
    if(list2.contains(e)){
      common.add(e);
    }
  });

  print(list1);
  print(list2);
  print(common);
}