# Project Images

Place your project mockup images in this folder.

## File Naming Convention

Images should be named according to the project:
- `bitnasdaq_1.png`, `bitnasdaq_2.png`, etc.
- `cricket_1.png`, `cricket_2.png`, etc.
- `timeword_1.png`, `timeword_2.png`, etc.
- `quotes_1.png`, `quotes_2.png`, etc.
- `vertex_1.png`
- `imagin_1.png`, `imagin_2.png`, etc.
- `wallet_1.png`, `wallet_2.png`, `wallet_3.png`, etc.
- `nft_1.png`, `nft_2.png`, `nft_3.png`, etc.

## Image Specifications

- **Recommended size**: 1080x1920 (9:16 aspect ratio for mobile mockups)
- **Format**: PNG with transparency or JPG
- **File size**: Keep individual images under 2MB for optimal performance

## Adding New Project Images

To add images for a new project:

1. Add your mockup images to this folder
2. Update the image paths in `lib/models/portfolio_model.dart` in the `images` array
3. Run `flutter pub get` to ensure assets are registered
4. The images will automatically be displayed with a carousel feature when clicked

## Current Projects

The following projects already have placeholder paths configured:
- BitNasdaq (crypto exchange) - 3 images
- Cricket Management App - 2 images
- TimeWord Game - 3 images
- AI-Powered Quotes App - 2 images
- VertexStairs App - 1 image
- Imagin Card - 2 images
- OurWallet - 3 images
- NFT Marketplace App - 3 images

Simply replace the placeholder paths with your actual image files!
