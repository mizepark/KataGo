#!/bin/bash
set -e
echo "=> Building iOS framework"

OUTPUT_DIR=./packages/build/Release-universal
ARCHIVE_PATH=${OUTPUT_DIR}/KataGo.xcarchive

rm -rf ${OUTPUT_DIR}
mkdir -p ${OUTPUT_DIR}

# 루트에 .xcodeproj 또는 .xcworkspace 파일 이름을 확인해서 아래를 고칠 것
xcodebuild \
  -workspace Runner.xcworkspace \
  -scheme Runner               \
  -configuration Release \
  -archivePath ${ARCHIVE_PATH} \
  archive

xcodebuild \
  -create-xcframework \
  -framework ${ARCHIVE_PATH}/Products/Library/Frameworks/KataGo.framework \
  -output ${OUTPUT_DIR}/KataGo-iOS-OS64COMBINED.zip

echo "=> Done, zip is at ${OUTPUT_DIR}/KataGo-iOS-OS64COMBINED.zip"
