pushd android
# # flutter build generates files in android/ for building the app
flutter build apk
./gradlew app:assembleAndroidTest
./gradlew app:assembleDebug -Ptarget=integration_test/app_test.dart
popd

 gcloud auth activate-service-account --key-file=./sampletestprojectflutter-4bdca829032a.json
 gcloud --quiet config set project sampletestprojectflutter

gcloud firebase test android run --type instrumentation \
  --app build/app/outputs/apk/debug/app-debug.apk \
  --test build/app/outputs/apk/androidTest/debug/app-debug-androidTest.apk \
  --use-orchestrator \
  --timeout 3m \
#   --results-bucket=gs://flutter-test \
#   --results-dir=tests/firebase