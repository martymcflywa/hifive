include properties.mk

appName = `grep entry src/manifest.xml | sed 's/.*entry="\([^"]*\).*/\1/'`
devices = `grep 'iq:product id' src/manifest.xml | sed 's/.*iq:product id="\([^"]*\).*/\1/'`
JAVA_OPTIONS = JDK_JAVA_OPTIONS="--add-modules=java.xml.bind"

buildtest:
	$(SDK_HOME)/bin/monkeyc \
	--jungles test/monkey.jungle \
	--device $(DEVICE) \
	--output test/bin/$(appName).prg \
	--private-key $(PRIVATE_KEY) \
	--unit-test \
	--warn

test: buildtest
	@$(SDK_HOME)/bin/connectiq &&\
	sleep 3 &&\
	$(JAVA_OPTIONS) \
	$(SDK_HOME)/bin/monkeydo test/bin/$(appName).prg vivoactive4 -t

build:
	$(SDK_HOME)/bin/monkeyc \
	--jungles src/monkey.jungle \
	--device $(DEVICE) \
	--output src/bin/$(appName).prg \
	--private-key $(PRIVATE_KEY) \
	--warn

buildall:
	@for device in $(devices); do \
		echo "-----"; \
		echo "Building for" $$device; \
		$(SDK_HOME)/bin/monkeyc \
		--jungles src/monkey.jungle \
		--device $$device \
		--output src/bin/$(appName)-$$device.prg \
		--private-key $(PRIVATE_KEY) \
		--warn; \
	done

run: build
	@$(SDK_HOME)/bin/connectiq &&\
	sleep 3 &&\
	$(JAVA_OPTIONS) \
	$(SDK_HOME)/bin/monkeydo src/bin/$(appName).prg $(DEVICE)

deploy: build
	@cp src/bin/$(appName).prg $(DEPLOY)

package:
	@$(SDK_HOME)/bin/monkeyc \
	--jungles src/monkey.jungle \
	--package-app \
	--release \
	--output src/bin/$(appName).iq \
	--private-key $(PRIVATE_KEY) \
	--warn