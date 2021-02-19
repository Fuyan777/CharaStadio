PRODUCT_NAME := CharaStadio
PROJECT_NAME := ${PRODUCT_NAME}.xcworkspace/

.PHONY: setup
setup: # project setup
	$(MAKE) xcodegen
	$(MAKE) pod-install
	$(MAKE) open

.PHONY: xcodegen
xcodegen:
	swiftgen
	xcodegen

.PHONY: pod-install
pod-install: # Install CocoaPods dependencies and generate workspace
	bundle exec pod install

.PHONY: pod-update
pod-update: # Update CocoaPods dependencies and generate workspace
	bundle exec pod update

.PHONY: open
open: # Open Project
	open ./${PROJECT_NAME}

.PHONY: clean
clean: # Delete cache
	rm -rf ~/Library/Caches/com.apple.dt.Xcode/
	rm -rf ~/Library/Developer/Xcode/DerivedData
	xcodebuild -alltargets clean