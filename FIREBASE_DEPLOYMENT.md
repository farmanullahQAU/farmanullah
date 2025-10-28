# Firebase Deployment Guide

## Prerequisites
- Firebase CLI installed (✅ already installed)
- Flutter SDK
- Access to your Firebase project

## Deployment Steps

### 1. Login to Firebase
```bash
firebase login
```

### 2. List Your Firebase Projects
```bash
firebase projects:list
```

### 3. Select Your Firebase Project
Update the `.firebaserc` file with your actual project ID:
```bash
firebase use your-actual-project-id
```

Or manually edit `.firebaserc` and replace `your-firebase-project-id` with your actual Firebase project ID.

### 4. Build Flutter Web App
```bash
flutter build web --release
```

This will create optimized web files in `build/web/` directory.

### 5. Deploy to Firebase Hosting
```bash
firebase deploy --only hosting
```

### 6. Access Your Deployed Site
Your portfolio will be live at:
- `https://your-project-id.web.app`
- `https://your-project-id.firebaseapp.com`

## Quick Deploy Script

Run this single command to build and deploy:
```bash
flutter build web --release && firebase deploy --only hosting
```

## Alternative: If Firebase CLI has issues

1. **Reinstall Firebase CLI:**
   ```bash
   npm install -g firebase-tools
   ```

2. **Then follow steps 1-5 above**

## Troubleshooting

### If you get "Project not found":
- Make sure you're logged in: `firebase login`
- List projects: `firebase projects:list`
- Set the correct project: `firebase use YOUR_PROJECT_ID`

### If build fails:
- Ensure all dependencies are installed: `flutter pub get`
- Clean build: `flutter clean && flutter pub get`
- Try building again: `flutter build web --release`

## Custom Domain (Optional)

After deployment, you can add a custom domain in Firebase Console:
1. Go to Firebase Console
2. Select your project
3. Go to Hosting
4. Click "Add custom domain"
5. Follow the verification steps

## Environment Variables (if needed)

If you need environment variables for production, you can:
1. Create a `.env.production` file
2. Use packages like `flutter_dotenv`
3. Replace the values during build

## Important Files Created

- `firebase.json` - Firebase configuration
- `.firebaserc` - Firebase project reference  
- `.gitignore` - Updated to exclude Firebase files

## Security Note

Replace `your-firebase-project-id` in `.firebaserc` with your actual Firebase project ID before deploying!

