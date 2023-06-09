#----------------------------------------------------------------
# Generated CMake target import file for configuration "Debug".
#----------------------------------------------------------------

# Commands may need to know the format version.
set(CMAKE_IMPORT_FILE_VERSION 1)

# Import target "SDL2::SDL2" for configuration "Debug"
set_property(TARGET SDL2::SDL2 APPEND PROPERTY IMPORTED_CONFIGURATIONS DEBUG)
set_target_properties(SDL2::SDL2 PROPERTIES
  IMPORTED_IMPLIB_DEBUG "${_IMPORT_PREFIX}/lib/libSDL2d.dll.a"
  IMPORTED_LOCATION_DEBUG "${_IMPORT_PREFIX}/bin/SDL2d.dll"
  )

list(APPEND _IMPORT_CHECK_TARGETS SDL2::SDL2 )
list(APPEND _IMPORT_CHECK_FILES_FOR_SDL2::SDL2 "${_IMPORT_PREFIX}/lib/libSDL2d.dll.a" "${_IMPORT_PREFIX}/bin/SDL2d.dll" )

# Commands beyond this point should not need to know the version.
set(CMAKE_IMPORT_FILE_VERSION)
