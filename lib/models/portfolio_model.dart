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

class PortfolioData {
  final String name;
  final String location;
  final String phone;
  final String email;
  final String linkedIn;
  final String bio;
  final List<Experience> experiences;
  final List<Skill> skills;
  final List<Project> projects;

  PortfolioData({
    required this.name,
    required this.location,
    required this.phone,
    required this.email,
    required this.linkedIn,
    required this.bio,
    required this.experiences,
    required this.skills,
    required this.projects,
  });

  static PortfolioData getData() {
    return PortfolioData(
      name: 'FARMAN ULLAH',
      location: 'Islamabad, Pakistan',
      phone: '+92 304 9575366',
      email: 'farmanullahk437@gmail.com',
      linkedIn: 'farman4',
      bio:
          'Flutter Developer with 4 years of experience building high-performance mobile applications for Android and iOS. Expert in Flutter, Firebase, GetX, Riverpod, and AI/Blockchain integrations. Proven ability to develop scalable, monetizable, and user-centric apps, including AI-powered tools and dApps. Strong background in clean architecture, cross-platform optimization, and publishing apps to Google Play and App Store.',
      experiences: [
        Experience(
          title: 'Flutter Developer',
          company: 'DigitalCode Islamabad',
          period: '2023 - Aug 2024',
          responsibilities: [
            'Contributed to the development of Crypto exchange and wallet app.',
            'Designed responsive Flutter UIs with real-time data and smooth animations.',
            'Integrated REST APIs and WebSocket.',
            'Applied Material 3 design guidelines for modern, accessible UI/UX.',
            'Integrated chat using Aws Amplify Dynamo DB',
            'Contributed to Flutter app testing, debugging, and release readiness.',
          ],
        ),
        Experience(
          title: 'Senior Flutter Developer',
          company: 'Mohra Saudi Arabia (remote)',
          period: '1 year',
          responsibilities: [
            'Built and maintained a multi-purpose Flutter app',
            'Integrated REST APIs.',
            'Used Bloc for efficient state management.',
            'Integrated Firebase auth, real-time database, functions, and FCM notifications.',
            'Added Google Maps for location-based services.',
            'Implemented secure in-app purchases and payment gateways.',
            'Optimized app performance and responsiveness',
          ],
        ),
        Experience(
          title: 'Junior Flutter Developer',
          company: 'Esols Technologies, Islamabad',
          period: '2021-2022',
          responsibilities: [
            'Developed multiple Flutter apps',
            'Utilized GetX for state management, routing, and dependency injection.',
            'Published two apps on Google Play and App Store with robust features.',
            'Integrated Firebase Realtime Database, Firestore, GraphQL, and RESTful APIs',
            'Implemented Google AdMob and secure payment gateways with custom checkout flows.',
            'Enhanced performance through lazy loading, caching, and fluid UI optimizations.',
          ],
        ),
      ],
      skills: [
        Skill(
          category: 'Mobile App Development',
          items: [
            'Flutter & Dart',
            'GetX, Riverpod, Bloc',
            'Firebase',
            'Amplify',
            'RESTful APIs',
            'Git',
            'In-App Purchases',
            'Google AdMob',
          ],
        ),
        Skill(
          category: 'Blockchain & Web3',
          items: [
            'Ethereum & Smart Contracts',
            'dApp & Wallet Integrations',
            'OpenZeppelin',
            'Hardhat',
            'Truffle',
            'DeFi',
            'Solidity',
            'ERC 20 and 721 tokens',
          ],
        ),
        Skill(
          category: 'Other',
          items: [
            'AI-Powered Features',
            'Hugging Face',
            'CI/CD (GitHub Actions)',
            'Codemagic',
            'MSSQL Server',
            'Debugging & Testing',
            'MVC',
            'MVVM',
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
