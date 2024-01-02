include conanbuildinfo.mak

export CXXFLAGS=-DSPDLOG_FMT_EXTERNAL -g -I $(CURDIR)/include \
	-I$(CONAN_ROOT_SPDLOG)/include \
	-I$(CONAN_ROOT_FMT)/include \
	-I$(CONAN_ROOT_JSONCPP)/include \
	-I$(CONAN_ROOT_YAML-CPP)/include \
	-I$(CONAN_ROOT_POCO)/include \
	-std=c++17 -Wall
export LDFLAGS=-g -L$(CONAN_ROOT_JSONCPP)/lib -L$(CONAN_ROOT_FMT)/lib -L$(CONAN_ROOT_SPDLOG)/lib -L$(CONAN_ROOT_YAML-CPP)/lib -L$(CONAN_ROOT_POCO)/lib $(SDL_LIBS) 
#export LDFLAGS=-g -L$(CONAN_ROOT_JSONCPP)/lib -L$(CONAN_ROOT_FMT)/lib -L$(CONAN_ROOT_SPDLOG)/lib -lfmt -lspdlog $(SDL_LIBS) -ljsoncpp
export BINARY=pixiki
export LIB_DIRECTORY=$(CURDIR)/lib
# Top directory for example projects
export APP_DIRECTORY=examples
export BIN_DIRECTORY=$(CURDIR)/bin
export BUILD_DIRECTORY=$(CURDIR)/build
export DIST_DIRECTORY=$(CURDIR)/dist
export ASSETS_DIRECTORY=$(CURDIR)/assets
export TEMPLATES_DIRECTORY=$(CURDIR)/templates
SOURCE_DIR=src
INCLUDE_DIR=include
CONFIGFILE=make.config
OBJECT_FILES =  $(BUILD_DIRECTORY)/Core.o \
		$(BUILD_DIRECTORY)/Log.o \
		$(BUILD_DIRECTORY)/ConfigurationBase.o \
		$(BUILD_DIRECTORY)/ConfigurationYAML.o

include $(CONFIGFILE)

all: lib examples tests

lib: static shared

shared: directories
shared: $(LIB_DIRECTORY)/$(BINARY).$(EXT)

static: directories
static: $(LIB_DIRECTORY)/$(BINARY).a

assets: assets-build

doc:
	doxygen docs/Doxyfile

tests: lib
	$(MAKE) -C ./testsuite suite

assets-build: 
	$(MAKE) -C ./templates generate

test: tests
	@LD_LIBRARY_PATH=./lib bin/testsuite

directories:
	@mkdir -p $(LIB_DIRECTORY)
	@mkdir -p $(BUILD_DIRECTORY)
	@mkdir -p $(DIST_DIRECTORY)

archive: lib
	tar zcvf $(DIST_DIRECTORY)/$(ARCHIVE) lib/*a lib/*.$(EXT)

clean: examples-clean
	$(MAKE) -C ./testsuite clean
	-rm -rf docs/out
	-rm -f $(LIB_DIRECTORY)/$(BINARY)*
	-rm -f $(OBJECT_FILES)

distclean: clean examples-distclean
	$(MAKE) -C ./testsuite distclean
	-rm -f $(CONFIGFILE)
	-rm -f make.examples
	-rm -rf $(LIB_DIRECTORY)
	-rm -rf $(BIN_DIRECTORY)
	-rm -rf $(BUILD_DIRECTORY)
	-rm -rf $(EXAMPLES_DIRECTORY)

install:
	cp $(LIB_DIRECTORY)/libevelengine* $(PREFIX)/lib/
	mkdir -p $(PREFIX)/include/evelengine
	cp $(CURDIR)/include/*.hpp $(PREFIX)/include/evelengine/

uninstall:
	rm -f $(PREFIX)/lib/libevelengine*
	rm -rf $(PREFIX)/include/evelengine

$(BUILD_DIRECTORY)/Engine.o: $(SOURCE_DIR)/Engine.cpp $(INCLUDE_DIR)/Engine.hpp
	$(CXX) $(CXXFLAGS) -c -fPIC $< -o $@

$(BUILD_DIRECTORY)/Assert.o: $(SOURCE_DIR)/Assert.cpp $(INCLUDE_DIR)/Assert.hpp
	$(CXX) $(CXXFLAGS) -c -fPIC $< -o $@

$(BUILD_DIRECTORY)/Log.o: $(SOURCE_DIR)/Log.cpp $(INCLUDE_DIR)/Log.hpp
	$(CXX) $(CXXFLAGS) -c -fPIC $< -o $@

$(BUILD_DIRECTORY)/ConfigurationBase.o: $(SOURCE_DIR)/ConfigurationBase.cpp $(INCLUDE_DIR)/ConfigurationBase.hpp
	$(CXX) $(CXXFLAGS) -c -fPIC $< -o $@

$(BUILD_DIRECTORY)/ConfigurationYAML.o: $(SOURCE_DIR)/ConfigurationYAML.cpp $(INCLUDE_DIR)/ConfigurationYAML.hpp
	$(CXX) $(CXXFLAGS) -c -fPIC $< -o $@

$(BUILD_DIRECTORY)/FileSystem.o: $(SOURCE_DIR)/FileSystem.cpp $(INCLUDE_DIR)/FileSystem.hpp
	$(CXX) $(CXXFLAGS) -c -fPIC $< -o $@

$(BUILD_DIRECTORY)/Timer.o: $(SOURCE_DIR)/Timer.cpp $(INCLUDE_DIR)/Timer.hpp
	$(CXX) $(CXXFLAGS) -c -fPIC $< -o $@

$(BUILD_DIRECTORY)/Exception.o: $(SOURCE_DIR)/Exception.cpp $(INCLUDE_DIR)/Exception.hpp
	$(CXX) $(CXXFLAGS) -c -fPIC $< -o $@

$(BUILD_DIRECTORY)/StringsUtil.o: $(SOURCE_DIR)/StringsUtil.cpp $(INCLUDE_DIR)/StringsUtil.hpp
	$(CXX) $(CXXFLAGS) -c -fPIC $< -o $@

$(BUILD_DIRECTORY)/Scene.o: $(SOURCE_DIR)/Scene.cpp $(INCLUDE_DIR)/Scene.hpp
	$(CXX) $(CXXFLAGS) -c -fPIC $< -o $@

$(BUILD_DIRECTORY)/Object.o: $(SOURCE_DIR)/Object.cpp $(INCLUDE_DIR)/Object.hpp
	$(CXX) $(CXXFLAGS) -c -fPIC $< -o $@

$(BUILD_DIRECTORY)/TilesetBase.o: $(SOURCE_DIR)/TilesetBase.cpp
	$(CXX) $(CXXFLAGS) -c -fPIC $< -o $@

$(BUILD_DIRECTORY)/TilesetTiled.o: $(SOURCE_DIR)/TilesetTiled.cpp
	$(CXX) $(CXXFLAGS) -c -fPIC $< -o $@

$(BUILD_DIRECTORY)/AnimationFileBase.o: $(SOURCE_DIR)/AnimationFileBase.cpp $(INCLUDE_DIR)/AnimationFileBase.hpp
	$(CXX) $(CXXFLAGS) -c -fPIC $< -o $@

$(BUILD_DIRECTORY)/AnimationFileAseprite.o: $(SOURCE_DIR)/AnimationFileAseprite.cpp $(INCLUDE_DIR)/AnimationFileAseprite.hpp
	$(CXX) $(CXXFLAGS) -c -fPIC $< -o $@

$(BUILD_DIRECTORY)/AnimationFileShoeBox.o: $(SOURCE_DIR)/AnimationFileShoeBox.cpp
	$(CXX) $(CXXFLAGS) -c -fPIC $< -o $@

$(BUILD_DIRECTORY)/AnimatedObject.o: $(SOURCE_DIR)/AnimatedObject.cpp $(INCLUDE_DIR)/AnimatedObject.hpp
	$(CXX) $(CXXFLAGS) -c -fPIC $< -o $@

$(BUILD_DIRECTORY)/Level.o: $(SOURCE_DIR)/Level.cpp $(INCLUDE_DIR)/Level.hpp
	$(CXX) $(CXXFLAGS) -c -fPIC $< -o $@

$(BUILD_DIRECTORY)/Texture.o: $(SOURCE_DIR)/Texture.cpp $(INCLUDE_DIR)/Texture.hpp
	$(CXX) $(CXXFLAGS) -c -fPIC $< -o $@

$(BUILD_DIRECTORY)/Font.o: $(SOURCE_DIR)/Font.cpp $(INCLUDE_DIR)/Font.hpp
	$(CXX) $(CXXFLAGS) -c -fPIC $< -o $@

$(BUILD_DIRECTORY)/CommandInterface.o: $(SOURCE_DIR)/CommandInterface.cpp $(INCLUDE_DIR)/CommandInterface.hpp
	$(CXX) $(CXXFLAGS) -c -fPIC $< -o $@

$(BUILD_DIRECTORY)/Command.o: $(SOURCE_DIR)/Command.cpp $(INCLUDE_DIR)/Command.hpp
	$(CXX) $(CXXFLAGS) -c -fPIC $< -o $@

$(BUILD_DIRECTORY)/Event.o: $(SOURCE_DIR)/Event.cpp $(INCLUDE_DIR)/Event.hpp
	$(CXX) $(CXXFLAGS) -c -fPIC $< -o $@

$(BUILD_DIRECTORY)/EventBase.o: $(SOURCE_DIR)/EventBase.cpp $(INCLUDE_DIR)/EventBase.hpp
	$(CXX) $(CXXFLAGS) -c -fPIC $< -o $@

$(BUILD_DIRECTORY)/Simulation.o: $(SOURCE_DIR)/Simulation.cpp $(INCLUDE_DIR)/Simulation.hpp
	$(CXX) $(CXXFLAGS) -c -fPIC $< -o $@

$(BUILD_DIRECTORY)/Stats.o: $(SOURCE_DIR)/Stats.cpp $(INCLUDE_DIR)/Stats.hpp
	$(CXX) $(CXXFLAGS) -c -fPIC $< -o $@

$(BUILD_DIRECTORY)/Seed.o: $(SOURCE_DIR)/Seed.cpp $(INCLUDE_DIR)/Seed.hpp
	$(CXX) $(CXXFLAGS) -c -fPIC $< -o $@

$(BUILD_DIRECTORY)/Camera.o: $(SOURCE_DIR)/Camera.cpp $(INCLUDE_DIR)/Camera.hpp
	$(CXX) $(CXXFLAGS) -c -fPIC $< -o $@

$(BUILD_DIRECTORY)/ResourceManager.o: $(SOURCE_DIR)/ResourceManager.cpp $(INCLUDE_DIR)/ResourceManager.hpp
	$(CXX) $(CXXFLAGS) -c -fPIC $< -o $@

$(BUILD_DIRECTORY)/Geometry.o: $(SOURCE_DIR)/Geometry.cpp $(INCLUDE_DIR)/Geometry.hpp
	$(CXX) $(CXXFLAGS) -c -fPIC $< -o $@

$(BUILD_DIRECTORY)/Primitives.o: $(SOURCE_DIR)/Primitives.cpp $(INCLUDE_DIR)/Primitives.hpp
	$(CXX) $(CXXFLAGS) -c -fPIC $< -o $@

$(BUILD_DIRECTORY)/Rectangle.o: $(SOURCE_DIR)/Rectangle.cpp $(INCLUDE_DIR)/Rectangle.hpp
	$(CXX) $(CXXFLAGS) -c -fPIC $< -o $@

$(BUILD_DIRECTORY)/Point.o: $(SOURCE_DIR)/Point.cpp $(INCLUDE_DIR)/Point.hpp
	$(CXX) $(CXXFLAGS) -c -fPIC $< -o $@

$(BUILD_DIRECTORY)/Text.o: $(SOURCE_DIR)/Text.cpp $(INCLUDE_DIR)/Text.hpp
	$(CXX) $(CXXFLAGS) -c -fPIC $< -o $@

$(BUILD_DIRECTORY)/RuntimeStats.o: $(SOURCE_DIR)/RuntimeStats.cpp $(INCLUDE_DIR)/RuntimeStats.hpp
	$(CXX) $(CXXFLAGS) -c -fPIC $< -o $@

$(LIB_DIRECTORY)/$(BINARY).$(EXT): $(OBJECT_FILES) 
	$(CXX) $(OBJECT_FILES) $(LDFLAGS) -shared -o $@

$(LIB_DIRECTORY)/$(BINARY).a: $(OBJECT_FILES)
	$(AR) $(ARFLAGS) $@ $^

make.examples:
	$(error Missing make.examples file. Run configure script first)

make.config:
	$(error Missing make.config file. Run configure script first)

# Examples
examples: render dot fractal animation landscape-generator noise towerdefense

render:
	$(MAKE) -C ./examples/render build

dot: 
	$(MAKE) -C ./examples/dot build

fractal:
	$(MAKE) -C ./examples/fractal build

animation:
	$(MAKE) -C ./examples/animation build

landscape-generator:
	$(MAKE) -C ./examples/landscape-generator build

noise:
	$(MAKE) -C ./examples/noise build

towerdefense:
	$(MAKE) -C ./examples/towerdefense build

examples-clean:
	$(MAKE) -C ./examples/render clean
	$(MAKE) -C ./examples/dot clean
	$(MAKE) -C ./examples/fractal clean
	$(MAKE) -C ./examples/animation clean
	$(MAKE) -C ./examples/landscape-generator clean
	$(MAKE) -C ./examples/noise clean
	$(MAKE) -C ./examples/towerdefense clean

examples-distclean:
	$(MAKE) -C ./examples/render distclean
	$(MAKE) -C ./examples/dot distclean
	$(MAKE) -C ./examples/fractal distclean
	$(MAKE) -C ./examples/animation distclean
	$(MAKE) -C ./examples/landscape-generator distclean
	$(MAKE) -C ./examples/noise distclean
	$(MAKE) -C ./examples/towerdefense distclean

test-distclean: tests-distclean
tests-distclean:
	$(MAKE) -C ./testsuite distclean

test-clean: tests-clean
tests-clean:
	$(MAKE) -C ./testsuite clean

