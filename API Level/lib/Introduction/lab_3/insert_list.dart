void main() {
  List<int> array = [1, 2, 4, 5];
  int element = 3;
  int position = 2;

  array.add(0);
  for (int i = array.length - 1; i > position; i--) {
    array[i] = array[i - 1];
  }

  array[position] = element;

  print("Modified array: $array");
}
