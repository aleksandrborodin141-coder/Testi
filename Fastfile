default_platform(:android)

platform :android do
  desc "Build debug APK"
  lane :debug do
    gradle(task: "assembleDebug")
  end

  desc "Build release APK"
  lane :release do
    gradle(task: "assembleRelease")
  end

  desc "Build and deploy to Firebase App Distribution"
  lane :beta do
    gradle(task: "assembleRelease")
    firebase_app_distribution(
      app: "YOUR_FIREBASE_APP_ID",
      apk_path: "../build/app/outputs/flutter-apk/app-release.apk",
      groups: "testers"
    )
  end
end
