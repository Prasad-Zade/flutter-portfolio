class PortfolioData {
  static const String name = "Prasad Zade";
  static const String email = "zadeprasad246@gmail.com";
  static const String phone = "+91-7972455933";
  static const String github = "https://github.com/Prasad-Zade";
  static const String linkedin = "https://linkedin.com/in/prasad-zade";

  static const List<String> roles = [
    "Flutter Developer",
    "AI & ML Enthusiast",
    "Full Stack Developer",
    "Open Source Contributor",
  ];

  static const String heroAbout =
      "Final-year B.Tech student in AI & Data Science at Zeal College of Engineering, Pune (CGPA 9.18). "
      "I build cross-platform Flutter apps, AI-powered tools, and IoT systems — with a focus on real-world impact. "
      "From award-winning civic tech to privacy-preserving AI middleware, I enjoy solving problems that actually matter.";

  static const String about =
      "I'm Prasad Zade, a passionate developer and AI enthusiast from Pune, India. "
      "My journey started with curiosity about how technology can solve everyday problems — "
      "and that curiosity has driven me to build everything from IoT healthcare systems to AI-powered ERP platforms. "
      "I thrive in environments where design meets engineering, and I believe great software is built at the intersection of empathy and logic. "
      "When I'm not coding, I'm competing on CodeChef, contributing to hackathons, or exploring the latest in AI research.";

  static const List<Map<String, String>> stats = [
    {"value": "9.18", "label": "CGPA"},
    {"value": "20+", "label": "Projects"},
    {"value": "2★", "label": "CodeChef"},
    {"value": "220+", "label": "SuperX Competitors"},
  ];

  static const List<Map<String, String>> education = [
    {
      "institution": "Zeal College of Engineering, Pune",
      "degree": "B.Tech – AI & Data Science",
      "year": "2022 – 2026",
      "detail": "CGPA: 9.18",
    },
    {
      "institution": "St Paul Junior & Senior College, Nagpur",
      "degree": "Class XII – State Board",
      "year": "2021 – 2022",
      "detail": "86.33%",
    },
    {
      "institution": "Agragami High School, Wardha",
      "degree": "Class X – State Board",
      "year": "2019 – 2020",
      "detail": "88.00%",
    },
  ];

  static const List<Map<String, dynamic>> skillCategories = [
    {
      "icon": "💻",
      "title": "Languages",
      "skills": ["Dart", "Java", "Python", "C++", "HTML", "CSS", "SQL"],
    },
    {
      "icon": "🚀",
      "title": "Frameworks",
      "skills": ["Flutter", "JavaFX", "Streamlit"],
    },
    {
      "icon": "🗄️",
      "title": "Databases",
      "skills": ["MySQL", "MongoDB", "Firebase", "SQLite"],
    },
    {
      "icon": "🛠️",
      "title": "Tools & DevOps",
      "skills": ["Git", "GitHub", "GitLab", "Render", "Android Studio"],
    },
    {
      "icon": "🤖",
      "title": "AI / ML",
      "skills": ["Gemini API", "spaCy", "NLP", "Transformers", "MediaPipe", "OpenCV"],
    },
  ];

  static const List<Map<String, dynamic>> projects = [
    {
      "title": "Smart Samadhan",
      "subtitle": "AI-Powered Civic Complaint System",
      "description":
          "Citizens report infrastructure issues like potholes via AI-generated descriptions powered by Gemini API. "
          "Supports image/video uploads via Firebase Storage, real-time complaint tracking, admin analytics dashboard, "
          "and multi-language input (Marathi, Hindi, Gujarati) with community interaction features.",
      "tags": ["Java", "JavaFX", "Firebase", "Gemini API"],
      "color": 0xFF6C63FF,
      "icon": "🏙️",
      "featured": true,
      "achievement": "🥉 3rd Place – Core2Web (220+ teams)",
      "github": "https://github.com/Prasad-Zade/Smart-Samadhan/tree/main/Smart-Samadhan-main",
    },
    {
      "title": "Bhavishya",
      "subtitle": "IoT-Based Healthcare Monitoring System",
      "description":
          "Captures EEG, EMG, and EOG neurological signals alongside Heart Rate, SpO₂, and Body Temperature "
          "to monitor health in real time. ML models detect mental states (Focused, Relaxed, Drowsy) and stream "
          "live data to a mobile app for body capacity analysis.",
      "tags": ["IoT", "Machine Learning", "Mobile App", "EEG/EMG"],
      "color": 0xFF00BFA5,
      "icon": "🌟",
      "featured": true,
      "achievement": "🥉 3rd Place – Core2Web",
      "github": "",
    },
    {
      "title": "Prarabdha",
      "subtitle": "AI-Powered ERP System",
      "description":
          "Full-scale cross-platform ERP with multi-role dashboards (Employee, Manager, Team Lead, Admin). "
          "Features AI task automation via Gemini, video conferencing via ZEGO SDK, Pomodoro timer, employee "
          "wellbeing tools, leave management workflow, offline-first SQLite, and 10+ language support.",
      "tags": ["Flutter", "Firebase", "Gemini AI", "ZEGO SDK", "Razorpay", "SQLite"],
      "color": 0xFFFF9800,
      "icon": "🎭",
      "featured": true,
      "achievement": "🏆 Top Rank – 12+ teams",
      "github": "",
    },
    {
      "title": "Eric",
      "subtitle": "Virtual AI Assistant",
      "description":
          "Voice and text-driven AI assistant with NLP-based intent recognition. Automates system and "
          "API-based tasks, fetches real-time data, and processes commands through a modular "
          "Input → NLP → Execution pipeline with speech recognition and text-to-speech.",
      "tags": ["Python", "NLP", "Speech Recognition", "APIs"],
      "color": 0xFF7E57C2,
      "icon": "🤖",
      "featured": false,
      "achievement": "",
      "github": "https://github.com/Prasad-Zade/Eric-Personal-Assistant",
    },
    {
      "title": "AI Resume Analyzer",
      "subtitle": "Intelligent Recruitment Tool",
      "description":
          "Parses PDF resumes, extracts structured data, and scores candidates against job descriptions. "
          "Detects skill gaps and provides personalized improvement recommendations via an interactive "
          "Plotly dashboard. MySQL backend with real-time Streamlit analysis.",
      "tags": ["Python", "Streamlit", "MySQL", "NLP", "Plotly"],
      "color": 0xFF26C6DA,
      "icon": "📄",
      "featured": false,
      "achievement": "",
      "github": "https://github.com/Prasad-Zade/AI-Resume-Analyzer-ATS-Score-Checker-",
    },
    {
      "title": "PII Detection & Privacy System",
      "subtitle": "Privacy Protection for AI Models",
      "description":
          "Detects and anonymizes sensitive personal data before it reaches any AI model using a custom "
          "NER pipeline (spaCy + Transformers). Supports reversible anonymization with a data mapping "
          "engine, synthetic replacements via Faker, and fully offline processing.",
      "tags": ["Python", "spaCy", "Transformers", "Faker"],
      "color": 0xFFFF6584,
      "icon": "🕵️",
      "featured": false,
      "achievement": "",
      "github": "https://github.com/Prasad-Zade/Pii-Security-App",
    },
    {
      "title": "AI Virtual Mouse",
      "subtitle": "Touchless Computer Control via Vision",
      "description":
          "Controls a computer cursor using eye movements and facial gestures — no hardware required. "
          "Uses MediaPipe's 468-point face mesh for real-time landmark detection, blink detection for "
          "clicks, and custom cursor smoothing algorithms via OpenCV.",
      "tags": ["Python", "OpenCV", "MediaPipe", "Autopy"],
      "color": 0xFF66BB6A,
      "icon": "🖱️",
      "featured": false,
      "achievement": "",
      "github": "",
    },
  ];

  static const List<Map<String, String>> experience = [
    {
      "role": "Flutter Intern",
      "company": "Incubators Systems Pvt. Ltd.",
      "location": "Pune",
      "period": "July – October 2024",
      "type": "Internship",
      "description":
          "Developed and shipped cross-platform mobile features for iOS & Android using Flutter. "
          "Integrated third-party REST APIs, wrote unit tests, and reduced crash rate by 20% through "
          "systematic debugging. Worked in an agile team with bi-weekly sprints.",
    },
    {
      "role": "Technical Head",
      "company": "IBM Technical Team – Zeal College",
      "location": "Pune",
      "period": "2024",
      "type": "Leadership",
      "description":
          "Led the tech team under IBM's campus initiative. Organized workshops on Flutter, AI/ML, "
          "and cloud tools, reaching 200+ students. Mentored juniors on project ideation and guided "
          "teams to hackathon finals.",
    },
    {
      "role": "Student Coordinator",
      "company": "Earn and Learn Scheme – SPPU",
      "location": "Pune",
      "period": "2023 – Present",
      "type": "Academic",
      "description":
          "Coordinated academic support tasks under the university assistantship program. Managed "
          "scheduling, task delegation, and progress tracking while maintaining a 9+ CGPA.",
    },
  ];

  static const List<Map<String, String>> achievements = [
    {
      "icon": "🥉",
      "title": "3rd Place – Core2Web Competition",
      "desc":
          "Ranked 3rd among 220+ project teams with Smart Samadhan & Bhavishya. Recognized for innovation, technical depth, and real-world impact.",
    },
    {
      "icon": "🏆",
      "title": "Top Rank – ERP Project Showcase",
      "desc":
          "Prarabdha ranked 1st among 12+ competing teams for its full-scale AI-powered ERP with multi-role architecture and cross-platform support.",
    },
    {
      "icon": "⭐",
      "title": "2-Star Coder – CodeChef",
      "desc":
          "Achieved 2-star rating through consistent performance in weekly competitive programming contests.",
    },
    {
      "icon": "🏆",
      "title": "Google Solution Challenge 2025",
      "desc":
          "Participated in Google's global developer challenge, building solutions aligned with UN Sustainable Development Goals.",
    },
    {
      "icon": "🇮🇳",
      "title": "Smart India Hackathon 2024",
      "desc":
          "Represented Zeal College at the national level, delivering a working prototype for a government problem statement.",
    },
  ];
}
