# Farman Ullah - Portfolio

A modern, responsive portfolio website built with Flutter, featuring your professional information, projects, and skills.

## Features

- 🎨 **Modern Design**: Clean, minimalist design with professional aesthetics
- 🌓 **Light/Dark Theme**: Toggle between light and dark modes with a single click
- 📱 **Responsive**: Works seamlessly on desktop, tablet, and mobile devices
- ⚡ **GetX State Management**: Fast and efficient state management
- 🚀 **Smooth Performance**: Optimized for excellent performance across all platforms

## Technologies Used

- Flutter
- GetX
- Material Design 3

## Sections

1. **Home**: Introduction and quick overview
2. **About**: Personal information, education, and work experience
3. **Services**: What I can do for you
4. **Skills**: Technical expertise and tools
5. **Portfolio**: Featured projects and applications
6. **Contact**: Get in touch

## Getting Started

### Prerequisites

- Flutter SDK (3.9.2 or higher)
- Dart SDK

### Installation

1. Clone the repository or ensure you're in the project directory
2. Install dependencies:
   ```bash
   flutter pub get
   ```

### Running the App

#### Web (Recommended for Portfolio)
```bash
flutter run -d chrome
```

#### Desktop
```bash
flutter run -d linux
# or
flutter run -d windows
```

#### Mobile
```bash
flutter run
```

## Project Structure

```
lib/
├── controllers/
│   └── theme_controller.dart    # Theme switching logic
├── models/
│   └── portfolio_model.dart      # Data models
├── views/
│   └── home_page.dart            # Main page
├── widgets/
│   ├── nav_bar.dart              # Navigation bar
│   ├── home_section.dart         # Home section
│   ├── about_section.dart        # About section
│   ├── services_section.dart     # Services section
│   ├── skills_section.dart       # Skills section
│   ├── portfolio_section.dart    # Portfolio section
│   └── contact_section.dart      # Contact section
├── utils/
│   └── constants.dart            # App constants
└── main.dart                     # Entry point
```

## Customization

### Update Your Information

Edit `lib/models/portfolio_model.dart` to update:
- Personal information (name, location, contact details)
- Bio and introduction
- Education details
- Work experience
- Skills and technologies
- Projects portfolio with images

### Adding Project Images

The portfolio now supports multiple images per project with a carousel feature:

1. **Add your mockup images** to the `assets/images/projects/` folder
2. **Update the image paths** in `lib/models/portfolio_model.dart` in each project's `images` array
3. **Run the app** - click on any project image to view the full carousel

**Image Specifications:**
- Recommended: 1080x1920 (9:16 for mobile mockups)
- Format: PNG or JPG
- File size: Keep under 2MB per image

**Example:**
```dart
Project(
  name: 'My Project',
  description: 'Description...',
  technologies: ['Flutter', 'Firebase'],
  images: [
    'assets/images/projects/myproject_1.png',
    'assets/images/projects/myproject_2.png',
    'assets/images/projects/myproject_3.png',
  ],
),
```

### Project Image Carousel Features

- **Display**: Shows the first image as a preview (400px height)
- **Indicator**: Shows number of images if more than 1
- **Click to view**: Opens full-screen carousel modal
- **Navigation**: Swipe or use arrow buttons to browse images
- **Zoom**: Pinch to zoom for detailed viewing
- **Performance**: Optimized with lazy loading and smooth animations

### Theme Customization

Edit `lib/utils/constants.dart` to customize:
- Primary colors
- Background colors
- Card colors

## Features in Detail

### Light/Dark Theme Toggle
Click the theme toggle icon in the navigation bar to switch between light and dark modes. The preference is managed by GetX and persists across sessions.

### Responsive Design
- **Desktop** (1200px+): Multi-column layouts with full navigation
- **Tablet** (768px - 1199px): Adapted layouts with maintained readability
- **Mobile** (< 768px): Single-column stacked layouts optimized for touch

### Smooth Animations
The app uses Flutter's animation capabilities for smooth transitions and interactions.

## Dependencies

- `get`: ^4.6.6 - State management and routing
- `flutter_svg`: ^2.0.9 - SVG support
- `url_launcher`: ^6.2.5 - External links
- `animate_do`: ^3.1.1 - Animations

## License

This project is created for Farman Ullah's personal portfolio.

## Contact

**Farman Ullah**
- Email: farmanullahk437@gmail.com
- Phone: +92 304 9575366
- Location: Islamabad, Pakistan
- LinkedIn: farman4

---

Built with ❤️ using Flutter