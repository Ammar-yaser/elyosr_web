class ApiResponse<T> {
  T? data;
  bool error;
  String? errorMessage;

  ApiResponse({this.data, this.error = false, this.errorMessage});
}
// class ApiResponse<T> {
//   Status status;
//   T? data;
//   String? message;

//   ApiResponse.initial(this.message) : status = Status.INITIAL;

//   ApiResponse.loading(this.message) : status = Status.LOADING;

//   ApiResponse.completed(this.data) : status = Status.COMPLETED;

//   ApiResponse.error(this.message) : status = Status.ERROR;

//   @override
//   String toString() {
//     return "Status : $status \n Message : $message \n Data : $data";
//   }
// }

// enum Status { INITIAL, LOADING, COMPLETED, ERROR }