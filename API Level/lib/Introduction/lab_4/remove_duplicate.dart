void main() {
  List<int> nums = [0, 0, 1, 1, 1, 2, 2, 3, 3, 4];

  int uniqueCount = removeDuplicates(nums);

  // print(nums);
  print("Number of unique elements: $uniqueCount");
  print("Modified array: ${nums.sublist(0, uniqueCount)}");
}

int removeDuplicates(List<int> nums) {
  if (nums.isEmpty){
    return 0;
  }

  int index = 0;

  for (int i = 1; i < nums.length; i++) {
    if (nums[i] != nums[index]) {
      index++;
      nums[index] = nums[i];
    }
  }

  return index + 1;
}
