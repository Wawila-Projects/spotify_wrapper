class SporifyError {
  ///The HTTP status code (also returned in the response header; 
  ///see [Response Status Codes](https://developer.spotify.com/documentation/web-api/#response-status-codes) 
  ///for more information).
  int status;
  
  ///	A short description of the cause of the error.
  String message;
}