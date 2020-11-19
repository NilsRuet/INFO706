abstract class Config{
  static final String host = "http://192.168.0.16:8080/";
  static String get studentsURL{
    return host+"students";
  }


  static final int timeoutDelay = 5;
}