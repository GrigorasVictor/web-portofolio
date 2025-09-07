/// Configuration settings for the application.
/// Modify these values when deploying to different environments.
class AppConfig {
  static const List<String> apiBaseUrls = [
    "http://127.0.0.1:8080",
    "http://localhost:8080",

  ];

  // API Endpoints
  static const String educationEndpoint = "/education";
  static const String experienceEndpoint = "/experience";
  static const String projectEndpoint = "/project";

  // Social Links
  static const String githubUrl = "https://github.com/GrigorasVictor";
  static const String linkedinUrl = "https://www.linkedin.com/in/victor-grigoras-093633271/";
  static const String cvUrl = "https://steep-cyan-anaconda.myfilebase.com/ipfs/QmYZFHq7JaQmADKvdiAZj3doZcCXpYk4Vi8Warxc7BEa2n";
  
  // Contact Information
  static const String emailAddress = "victorandrei201112@gmail.com";
  
  // Assets
  static const String profileImagePath = "assets/images/personna.png";
  static const String backgroundSvgPath = "assets/images/topography.svg";
  
  // UI Configuration
  static const List<String> heroWords = ['everyone', 'people', 'world'];
}
