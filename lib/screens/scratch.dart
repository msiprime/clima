void main() async {
  task1();
  var result = await task2();
  task3(result);
}

void task1() {
  print('task 1 is finished');
}

Future<String?> task2() async {
  Duration duration = const Duration(seconds: 5);

  String? result;
  print('Task 2 is being processed, waiting for result');
  await Future.delayed(duration, () {
    result = 'data of task 2';
    print('task 2 is finished');
  });
  return result;
}

void task3(var result) {
  print('task 3 has $result');
}
