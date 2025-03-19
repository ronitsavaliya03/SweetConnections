import 'dart:io';

void main(){
  stdout.write("Enter the word:");
  String word= (stdin.readLineSync()!);

  for(int i=word.length-1; i>=0; i--){
    stdout.write('${word[i]}');
  }
}