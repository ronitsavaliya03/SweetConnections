import 'dart:io';

void main(){
  List<int> marks=[];
  int sum = 0;

  for(int i=0; i<5; i++){
    stdout.write("Enter a Mark of Subject ${i+1} is:");
    marks.add(int.parse(stdin.readLineSync()!));

    sum+=marks[i];
  }

  double per=(sum) / 5;

  print('Percentage: ${(sum) / 5}');

  if(per > 70){
    print("Distinct Class");
  }
  else if(per >= 60){
    print("First Class");
  }
  else if(per >= 45){
    print("Second Class");
  }
  else if(per >= 35){
    print("Pass");
  }
  else{
    print("Fail");
  }
}