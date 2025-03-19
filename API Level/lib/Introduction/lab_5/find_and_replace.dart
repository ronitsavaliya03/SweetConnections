import 'dart:io';

void main(){
  List<String> list=[];

  while(true){
    stdout.write("Enter the element (Enter -1 for exit:): ");
    String n= (stdin.readLineSync()!);

    if(n=='-1'){
      break;
    }else{
      list.add(n);
    }
  }

  print("Enter the name to be replaced:");
  String oldName=stdin.readLineSync()!;

  print("Enter the newName:");
  String newName=stdin.readLineSync()!;

  for(var element in list){
    if(element==oldName){
      list[list.indexOf(element)]=newName;
    }
  }

  print(list);
}