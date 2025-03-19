import 'dart:io';

void main(){
  stdout.write("Enter the String:");
  String s= (stdin.readLineSync()!);

  List<String> list=s.split(" ");
  Map<String, int> map={};

  for(int i=0; i<list.length; i++){
    String temp= list[i];

    if(map.containsKey(temp)){
      map.update(temp, (v)=>v+1);
    }else{
      map[temp]=1;
    }

  }
  print(map);


}