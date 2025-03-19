import 'dart:io';

void main(){
  List<int> list=[];

  while(true){
    stdout.write("Enter the number and Enter 0 for exit:");
    int n= int.parse(stdin.readLineSync()!);

    if(n==0){
      break;
    }else{
      list.add(n);
    }
  }
  Map<int, int> map={};

  for(int i=0; i<list.length; i++){
    int temp=list[i];
    if(map.containsKey(temp)){
      map.update(temp, (v)=> v+1);
    }else{
      map[temp]=1;
    }
  }

  map.forEach((key, value){
    if(value==1){
      stdout.write('$key ,');
    }
  });
}