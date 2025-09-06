import 'dart:async';
import '../models/education.dart';
import '../models/experience.dart';
import '../models/project.dart';

class ApiService {
  int _timeCounter = 0;
  Future<List<Education>> fetchEducation() async {
    // Simulate network delay
    await Future.delayed(Duration(seconds: _timeCounter));

    // In a real app, you would make an HTTP request here.
    // To test the error case, you can return an empty list: return [];
    // To test a failure, you can throw an exception: throw Exception('Failed to load');
    final data = [
      {
        "degree": "Bachelor of Science in Computer Science",
        "institution": "Technical University of Cluj-Napoca",
        "location": "Cluj-Napoca, Romania",
        "startDate": "2022-09-01",
        "endDate": "2026-06-30",
        "photoUrl": "https://steep-cyan-anaconda.myfilebase.com/ipfs/QmYQqhxLrRE4BtyFFAqHyUfDZDceW6oDBDcDZV3w6jJjES"
      },
      {
        "degree": "Licensed in Mathematics-Informatics, intensive in informatics",
        "institution": "‘Dimitrie Cantemir’ National College",
        "location": "Bacău, Romania",
        "startDate": "2018-09-01",
        "endDate": "2022-06-30",
        "photoUrl": "https://steep-cyan-anaconda.myfilebase.com/ipfs/QmbbEDeuwMgLp1Hvq1Zry1SJbciMAoiZdAU5Q9YgD1as3M"
      }
    ];

    return data.map((json) => Education.fromJson(json)).toList();
  }

  Future<List<Experience>> fetchExperience() async {
    await Future.delayed(Duration(seconds: _timeCounter));
    final data = [
      {
        "title": "Data Automation & Cloud",
        "description": "Developed an AI-based content generation and retrieval system, featuring agent-driven orchestration with microservices and a chatbot interface.\nDesigned efficient file processing and scalable ingestion pipelines to ensure rapid and accurate information access.\nImplemented multimodal contextual analysis for improved relevance and seamless integration into automation workflows.",
        "company": "MHP – A Porsche Company",
        "location": "Cluj-Napoca, Romania",
        "startDate": "2024-07-14",
        "endDate": "2024-08-30",
        "photoUrl": "https://steep-cyan-anaconda.myfilebase.com/ipfs/QmTaKJS4KRLRyEmTWrBwLEnTC1xy1GNzkYueJViE3x5kXi",
        "tags": [
          {"name": "AI"},
          {"name": "RAG"},
          {"name": "agent"},
          {"name": "tools invoking"},
          {"name": "NLP"}
        ]
      }
    ];
    return data.map((json) => Experience.fromJson(json)).toList();
  }

  Future<List<Project>> fetchProjects() async {
    await Future.delayed(Duration(seconds: _timeCounter));
    final data = [
  {
    "title": "Mulit-Modal Agentic Rag System",
    "description": "Developed an AI-based content generation and retrieval system, featuring agent-driven orchestration with microservices and a chatbot interface.",
    "tags": [
      { "name": "Python" },
      { "name": "LangChain" },
      { "name": "MCP" },
      { "name": "Ollama" },
      { "name": "AI" }
    ],
    "videoUrl": "https://steep-cyan-anaconda.myfilebase.com/ipfs/QmTypcL1Rw7tuZVUJXiSczbpjzaEfT3U2GUJp1X2yXbfvL",
    "githubUrl": "https://github.com/Victor-Andrei-MHP/mcp-project"
  },
  {
    "title": "HealthCare-AI",
    "description": "HealthCare-AI is an intelligent application designed to help users remember to take their medication. By leveraging AI and Google Calendar integration, the app schedules reminders and provides helpful notifications to ensure you never miss a dose. Perfect for those with complex medication schedules or anyone who occasionally forgets to take their pills on time.",
    "tags": [
      { "name": "Flutter" },
      { "name": "Python" },
      { "name": "Google Calendar" },
      { "name": "Ollama" },
      { "name": "FastApi" }
    ],
    "videoUrl": "https://steep-cyan-anaconda.myfilebase.com/ipfs/Qmc4LyrM8GkavtzXtzWhZegFiFJRWM1J12drC6iwiebNTG",
    "githubUrl": "https://github.com/GrigorasVictor/HealthCare-AI"
  },
  {
    "title": "CV-Matcher",
    "description": "I was part of the AI team at a hackathon where I extracted all candidate documents and reformatted CVs and job descriptions into a normalized JSON schema for embedding, enabling accurate semantic search and improved matching results.",
    "tags": [
      { "name": "Jupyter Notebook" },
      { "name": "Python" },
      { "name": "Ollama" }
    ],
    "videoUrl": "",
    "githubUrl": "https://github.com/humeniucDan/CV-Matcher"
  },
  {
    "title": "RoSubMaster",
    "description": "Converted MP4 videos with English audio into Romanian-subtitled MP4s using a Python pipeline",
    "tags": [
      { "name": "Python" },
      { "name": "Ffmpeg" },
      { "name": "Whisper" },
      { "name": "MarianMT" },
      { "name": "Pytorch" },
      { "name": "Torchaudio" },
      { "name": "Transformers" }
    ],
    "videoUrl": "",
    "githubUrl": "https://github.com/GrigorasVictor/RoSubMaster"
  },
  {
    "title": "Spotify-Stats",
    "description": "SpotifyStats is a project designed to analyze and visualize Spotify data. It includes components for data processing, machine learning, and a client application built with Flutter.",
    "tags": [
      { "name": "Flutter" },
      { "name": "Python" },
      { "name": "Spotify-api" },
      { "name": "Django" },
      { "name": "JWT" },
      { "name": "Deep-learning" }
    ],
    "videoUrl": "https://steep-cyan-anaconda.myfilebase.com/ipfs/QmSsRTWQDySocZtzYCEafnEzBCq5aGkPCXNi37UPGN5s7d",
    "githubUrl": "https://github.com/GrigorasVictor/Spotify-Stats"
  },
  {
    "title": "Facebook-clone",
    "description": "This project is a full-stack social media platform engineered to emulate core functionalities of Facebook. It is developed with a Java-based backend and a JavaScript-driven frontend, structured around a microservices architecture for enhanced scalability and modularity.",
    "tags": [
      { "name": "Java" },
      { "name": "JWT" },
      { "name": "S3 Bucket" },
      { "name": "Trello" },
      { "name": "JavaScript" },
      { "name": "React" }
    ],
    "videoUrl": "",
    "githubUrl": "https://github.com/GrigorasVictor/Facebook-clone"
  }
];
    return data.map((json) => Project.fromJson(json)).toList();
  }
}
