# Image Setup Guide

## Current Status

✅ **TimeWord** - Images are correctly configured
- Files: `timeword_2.png` through `timeword_8.png` (7 images)
- Status: Ready to display

📋 **Other Projects** - Need image files
- BitNasdaq: Need to add `bitnasdaq_1.png`, `bitnasdaq_2.png`, `bitnasdaq_3.png`
- Cricket: Need to add `cricket_1.png`, `cricket_2.png`
- Quotes: Need to add `quotes_1.png`, `quotes_2.png`
- Vertex: Need to add `vertex_1.png`
- Imagin: Need to add `imagin_1.png`, `imagin_2.png`
- Wallet: Need to add `wallet_1.png`, `wallet_2.png`, `wallet_3.png`
- NFT: Need to add `nft_1.png`, `nft_2.png`, `nft_3.png`

## Quick Solution

### Option 1: Rename Your Images (Easiest)
If you have images for other projects with different names:
```bash
# Rename your images to match the expected names
cd assets/images/projects/
mv your_image.png bitnasdaq_1.png
```

### Option 2: Update the Code
Edit `lib/models/portfolio_model.dart` to match your actual filenames:
```dart
Project(
  name: 'BitNasdaq',
  images: ['assets/images/projects/your_actual_filename.png'],
)
```

## Test TimeWord Images

To test if TimeWord images work, run:
```bash
flutter run -d chrome
```

Then navigate to the Portfolio section and click on the TimeWord project image. You should see a carousel with all 7 images!

## Adding More Images

Just add images to `assets/images/projects/` folder and update the path in `lib/models/portfolio_model.dart`:

```dart
images: [
  'assets/images/projects/your_image.png',  // Add your actual filename
],
```

The carousel will automatically support multiple images when you provide them.
