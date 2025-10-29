import 'package:flutter/material.dart';

class Experience {
  final String title;
  final String company;
  final String period;
  final List<String> responsibilities;

  Experience({
    required this.title,
    required this.company,
    required this.period,
    required this.responsibilities,
  });
}

class Project {
  final String name;
  final String description;
  final String? playStoreUrl;
  final List<String> technologies;
  final List<String> images; // Paths to images in assets

  Project({
    required this.name,
    required this.description,
    this.playStoreUrl,
    required this.technologies,
    required this.images,
  });
}

class Skill {
  final String category;
  final List<String> items;

  Skill({required this.category, required this.items});
}

class Service {
  final String title;
  final String description;
  final IconData icon;

  Service({required this.title, required this.description, required this.icon});
}

class Education {
  final String period;
  final String degree;
  final String institution;

  Education({
    required this.period,
    required this.degree,
    required this.institution,
  });
}

class UIContent {
  final String greeting;
  final String professionalTitle;
  final String aboutDescription;
  final String contactSubtitle;
  final String contactCTA;
  final String footerText;
  final Map<String, String> sectionTitles;
  final Map<String, String> buttonLabels;
  final Map<String, String> navigationLabels;

  UIContent({
    required this.greeting,
    required this.professionalTitle,
    required this.aboutDescription,
    required this.contactSubtitle,
    required this.contactCTA,
    required this.footerText,
    required this.sectionTitles,
    required this.buttonLabels,
    required this.navigationLabels,
  });
}

class PortfolioData {
  final String name;
  final String location;
  final String phone;
  final String email;
  final String linkedIn;
  final String bio;
  final String cvUrl;
  final String profileImagePath;
  final List<Experience> experiences;
  final List<Skill> skills;
  final List<Project> projects;
  final List<Service> services;
  final List<Education> education;
  final UIContent uiContent;

  PortfolioData({
    required this.name,
    required this.location,
    required this.phone,
    required this.email,
    required this.linkedIn,
    required this.bio,
    required this.cvUrl,
    required this.profileImagePath,
    required this.experiences,
    required this.skills,
    required this.projects,
    required this.services,
    required this.education,
    required this.uiContent,
  });

  static PortfolioData getData() {
    return PortfolioData(
      name: 'FARMAN ULLAH',
      location: 'Islamabad, Pakistan',
      phone: '+92 304 9575366',
      email: 'farmanullahk437@gmail.com',
      linkedIn: 'farman4',
      cvUrl: 'https://drive.google.com/file/d/YOUR_FILE_ID/view?usp=sharing',
      profileImagePath: 'assets/images/projects/me.jpeg',
      bio:
          'Senior Flutter Developer with 4+ years of experience delivering production-grade Android/iOS apps. Specialized in Flutter, Firebase, REST/WebSocket, and state management (GetX, Riverpod, Bloc). Built and shipped scalable features including authentication, real-time data, payments, and monetization (AdMob, IAP). Hands-on with AI/Web3 integrations (Web3 Dart, MetaMask, Solidity). Strong in clean architecture, performance optimization, CI/CD, and full release lifecycle to Play Store and App Store.',
      education: [
        Education(
          period: '2018 - 2020',
          degree: 'M.Sc. Computer Science',
          institution: 'Quaid-i-Azam University, Islamabad',
        ),
        Education(
          period: '2015 - 2017',
          degree: 'B.Sc. Computer Science',
          institution: 'Govt Degree College Wari Upper Dir',
        ),
      ],
      uiContent: UIContent(
        greeting: 'Hello, I\'m',
        professionalTitle: 'Flutter Developer',
        aboutDescription:
            'Passionate developer with expertise in building scalable applications. Dedicated to delivering high-quality solutions with clean code and user-centered design.',
        contactSubtitle:
            'Ready to bring your ideas to life?\nLet\'s create something amazing together.',
        contactCTA: 'Let\'s Start a Project',
        footerText:
            '© ${DateTime.now().year} Farman Ullah. All rights reserved.',
        sectionTitles: {
          'home': 'Home',
          'about': 'About Me',
          'experience': 'Professional Experience',
          'services': 'Services',
          'skills': 'Technical Skills',
          'portfolio': 'Portfolio',
          'contact': 'Get in touch',
          'education': 'Education',
        },
        buttonLabels: {
          'downloadCV': 'Download My CV',
          'downloadCVShort': 'Download CV',
          'viewPortfolio': 'View Portfolio',
          'startProject': 'Let\'s Start a Project',
        },
        navigationLabels: {
          'home': 'Home',
          'experience': 'Experience',
          'services': 'Services',
          'skills': 'Skills',
          'portfolio': 'Portfolio',
          'contact': 'Contact',
        },
      ),
      services: [
        Service(
          title: 'Mobile App Development',
          description:
              'Build high-performance cross-platform mobile applications with Flutter',
          icon: Icons.smartphone_rounded,
        ),
        Service(
          title: 'Firebase Integration',
          description:
              'Implement authentication, real-time databases, and cloud functions',
          icon: Icons.cloud_rounded,
        ),
        Service(
          title: 'Blockchain & Web3',
          description:
              'Develop dApps, smart contracts, and integrate wallet services',
          icon: Icons.account_balance_wallet_rounded,
        ),
        Service(
          title: 'UI/UX Design',
          description:
              'Create beautiful, modern interfaces following Material Design',
          icon: Icons.palette_rounded,
        ),
        Service(
          title: 'App Monetization',
          description: 'Implement ads, in-app purchases, and payment gateways',
          icon: Icons.monetization_on_rounded,
        ),
        Service(
          title: 'App Publishing',
          description: 'Publish apps to Google Play Store and Apple App Store',
          icon: Icons.store_rounded,
        ),
      ],
      experiences: [
        Experience(
          title: 'Flutter Developer',
          company: 'DigitalCode · Islamabad',
          period: '2023 – 2024',
          responsibilities: [
            'Delivered crypto exchange & wallet features (KYC, P2P, spot trading) using Flutter + WebSocket; improved data sync latency by ~35%.',
            'Built responsive Material 3 UI with custom animations; increased session duration by 22%.',
            'Integrated REST APIs with robust error handling, retry logic, and token auth.',
            'Implemented secure chat (AWS Amplify + DynamoDB) and push notifications.',
            'Led QA support and release readiness; reduced crash-free sessions issues to <0.5%.',
          ],
        ),
        Experience(
          title: 'Senior Flutter Developer',
          company: 'Mohra · Saudi Arabia (Remote)',
          period: '2022 – 2023',
          responsibilities: [
            'Owned end-to-end Flutter delivery for a multi-purpose app; introduced Bloc and improved architecture for maintainability.',
            'Integrated Firebase Auth, RTDB/Firestore, Cloud Functions, and FCM; reduced auth issues by 40%.',
            'Implemented Google Maps/Places and location services with background handling.',
            'Launched IAP and payment gateways with secure validation and receipt management.',
            'Improved rendering performance via memoization, lazy-loading, and image optimization.',
          ],
        ),
        Experience(
          title: 'Junior Flutter Developer',
          company: 'Esols Technologies · Islamabad',
          period: '2021 – 2022',
          responsibilities: [
            'Shipped 2 cross-platform apps to Play Store/App Store; adhered to release and store policies.',
            'Used GetX for routing, DI, and state; standardized module structure to speed feature dev by ~20%.',
            'Integrated Firebase (RTDB/Firestore), GraphQL, and REST; built offline-first flows.',
            'Monetized via AdMob & IAP; implemented consent, frequency capping, and A/B placements.',
            'Optimized jank to <2% on mid-range devices using caching and list virtualization.',
          ],
        ),
      ],
      skills: [
        Skill(
          category: 'Mobile App Development',
          items: [
            'Flutter (Material 3), Dart',
            'State: GetX, Riverpod, Bloc',
            'Firebase (Auth, RTDB/Firestore, FCM, Functions)',
            'AWS Amplify (DynamoDB, Storage)',
            'REST & WebSocket integrations',
            'Git, CI/CD (GitHub Actions, Codemagic)',
            'In‑App Purchases (Play/App Store), AdMob',
          ],
        ),
        Skill(
          category: 'Blockchain & Web3',
          items: [
            'Ethereum, Solidity, OpenZeppelin',
            'Web3 Dart, MetaMask integration',
            'Hardhat, Truffle toolchains',
            'ERC‑20 / ERC‑721 tokens',
          ],
        ),
        Skill(
          category: 'Other',
          items: [
            'AI integrations (Hugging Face APIs)',
            'Unit/Widget testing, Debugging',
            'Clean Architecture, MVC/MVVM',
            'MSSQL Server, REST backends',
          ],
        ),
      ],
      projects: [
        Project(
          name: 'Artnie – Creative Design App',
          description:
              'A cross-platform mobile app for creating and customizing digital artwork, including invitations, posters, cards, and social media visuals. Features Google Sign-In, offline design capabilities, Firebase-backed cloud storage for optional backups, and a privacy-focused approach with user-controlled data deletion. Built with a sleek Material 3 UI and smooth animations for an engaging user experience.',
          technologies: [
            'Flutter',
            'Firebase Authentication',
            'Firebase Cloud Storage',
            'GetX',
            'Material 3',
            'Custom Animations',
            'Google Sign-In',
            'Offline Storage',
            'REST API',
          ],
          images: [
            'assets/images/projects/artnie_1.png',
            'assets/images/projects/artnie_2.png',
            'assets/images/projects/artnie_3.png',
            'assets/images/projects/artnie_4.png',
            'assets/images/projects/artnie_5.png',
          ],
          playStoreUrl:
              'https://play.google.com/store/apps/details?id=com.Artnie.app&pcampaignid=web_share', // Update with actual URL if different
        ),
        Project(
          name: 'BitNasdaq (crypto currency exchange)',
          description:
              'A cryptocurrency exchange platform offering wallet management, P2P transfers, spot trading, VIP rewards, trading bots, KYC verification, and real-time market data with charting. Supports blockchain interaction and token operations.',
          technologies: [
            'Flutter',
            'Firebase',
            'REST API',
            'WebSocket',
            'AWS Amplify',
            'DynamoDB',
            'Web3 Dart',
            'MetaMask',
            'Solidity',
            'ERC-20',
            'GetX',
          ],
          images: [
            'assets/images/projects/bitnasdaq_1.png',
            // 'assets/images/projects/bitnasdaq_2.png',
            // 'assets/images/projects/bitnasdaq_3.png',
          ],
          playStoreUrl:
              "https://play.google.com/store/apps/details?id=com.bitnasdaq.exchange&pcampaignid=web_share",
        ),

        Project(
          name: 'Cricket Management App',
          description:
              'An app for cricket clubs and leagues featuring real-time and offline scoring, auto-sync, team and player management, and live streaming to YouTube and Facebook.',
          technologies: [
            'Flutter',
            'Firebase Realtime',
            'Firestore',
            'GetX',
            'FCM',
          ],
          images: [
            'assets/images/projects/cricket_1.png',
            'assets/images/projects/cricket_2.png',
          ],
          playStoreUrl:
              "https://play.google.com/store/apps/details?id=com.mitset.cricm&pcampaignid=web_share",
        ),
        Project(
          name: 'TimeWord Game – A Fast-Paced Word Puzzle Mobile App',
          description:
              'A vocabulary-based mobile game with timed challenges, multiplayer mode, quiz levels, offline support, and custom puzzle generation. Includes integrated dictionary, daily challenges, and monetization through ads and in-app purchases.',
          technologies: [
            'Flutter',
            'Firebase Realtime Database',
            'Riverpod',
            'AdMob',
            'In-App Purchases',
          ],
          images: [
            'assets/images/projects/timeword_1.png',

            'assets/images/projects/timeword_2.png',
            'assets/images/projects/timeword_3.png',
            'assets/images/projects/timeword_4.png',
            'assets/images/projects/timeword_5.png',
            'assets/images/projects/timeword_6.png',
            'assets/images/projects/timeword_7.png',
            'assets/images/projects/timeword_8.png',
            'assets/images/projects/timeword_9.png',
          ],
          playStoreUrl:
              'https://play.google.com/store/apps/details?id=com.timeword.game&pcampaignid=web_share',
        ),
        Project(
          name: 'AI-Powered Quotes App',
          description:
              'A mobile application designed to generate, customize, and share motivational quotes using AI-driven personalization. Features include dynamic text generation, image selection, multilingual support, voiceovers, and in-app monetization.',
          technologies: [
            'Flutter',
            'Firebase',
            'REST API',
            'Pexels API',
            'Riverpod',
            'Google AdMob',
            'In-App Purchases',
            'Localization',
          ],
          images: [
            'assets/images/projects/quotes_5.png', //feature image

            'assets/images/projects/quotes_1.png',
            'assets/images/projects/quotes_2.png',
            'assets/images/projects/quotes_3.png',
            'assets/images/projects/quotes_4.png',
          ],
        ),

        Project(
          name: 'Crypto Wallet',
          description:
              'A secure Ethereum-based mobile wallet app built with Flutter. Features wallet creation and import, real-time balance tracking, sending and receiving ERC-20 tokens, transaction history, QR code scanning, mnemonic seed backup, MetaMask integration, and market price updates.',
          technologies: [
            'Flutter',
            'Ethereum',
            'Web3 Dart',
            'MetaMask',
            'REST API',
            'Riverpod',
            'ERC-20',
            'Blockchain',
          ],
          images: ['assets/images/projects/cryptowallet_1.png'],
          playStoreUrl: null,
        ),
        Project(
          name: 'Single Collection NFT Marketplace App',
          description:
              'A mobile-based NFT marketplace built on the Ethereum, enabling users to mint, buy, sell, and gift NFTs from a single collection. Integrated MetaMask for wallet connectivity and smart contract interaction.',
          technologies: [
            'Flutter',
            'Solidity',
            'Web3 Dart',
            'MetaMask',
            'Ethereum Testnet',
            'ERC-721',
            'GetX',
            'Clean Architecture',
          ],
          images: ['assets/images/projects/nft_1.png'],
        ),

        Project(
          name: 'OurWallet – Wallet App',
          description:
              'A mobile wallet app for managing, sending, receiving, and tracking multiple cryptocurrencies with real-time balance updates and secure transactions. Includes features for token management, transaction history, and market tracking.',
          technologies: [
            'Flutter',
            'Blockchain',
            'Web3',
            'Ethereum',
            'ERC-20',
            'MetaMask',
            'REST API',
            'Riverpod',
          ],
          images: [
            'assets/images/projects/wallet_1.png',
            'assets/images/projects/wallet_2.png',
            'assets/images/projects/wallet_3.png',
          ],
          playStoreUrl: null,
        ),
        Project(
          name: 'VertexStairs – App',
          description:
              'A custom mobile solution built for a private business, supporting localized operations, data handling, and internal process automation.',
          technologies: [
            'Flutter',
            'MSSQL Server',
            'Azure Data Studio',
            'REST API',
            'Riverpod',
            'Clean Architecture',
          ],
          images: ['assets/images/projects/vertex_1.png'],
        ),
      ],
    );
  }
}
