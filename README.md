Self-use Makefile only for C++ projects.

## Usage

Keep you source code under `$(SOURCE_DIR)`(default is `src/`), you header files
under `$(INCLUDE_DIR)`(default is `src/`).

Fill you `$(TARGET)` and `$(SOURCES)` in this `Makefile`. Note a `$(TARGET)` is
a executable file and each `$(SOURCES)` is a path from `$(SOURCE_DIR)` to you
source.

## Effect

After you run `make` command, this `Makefile` will generate a `$(TARGET)` under
you current directory. Also it will generate a `.o` file under `$(OBJECT_DIR)`
and a `.P` file under `$(DEPENDENCY_DIR)` for each `$(SOURCES)`. The former is
the object file for the source, and the latter is the dependence of the source.
