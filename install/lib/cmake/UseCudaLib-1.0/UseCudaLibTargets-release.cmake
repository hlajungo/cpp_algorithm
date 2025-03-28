#----------------------------------------------------------------
# Generated CMake target import file for configuration "Release".
#----------------------------------------------------------------

# Commands may need to know the format version.
set(CMAKE_IMPORT_FILE_VERSION 1)

# Import target "UseCudaLib::UseCudaLib" for configuration "Release"
set_property(TARGET UseCudaLib::UseCudaLib APPEND PROPERTY IMPORTED_CONFIGURATIONS RELEASE)
set_target_properties(UseCudaLib::UseCudaLib PROPERTIES
  IMPORTED_LINK_INTERFACE_LANGUAGES_RELEASE "CUDA"
  IMPORTED_LOCATION_RELEASE "${_IMPORT_PREFIX}/lib/UseCudaLib-1.0/libUseCudaLib.a"
  )

list(APPEND _cmake_import_check_targets UseCudaLib::UseCudaLib )
list(APPEND _cmake_import_check_files_for_UseCudaLib::UseCudaLib "${_IMPORT_PREFIX}/lib/UseCudaLib-1.0/libUseCudaLib.a" )

# Commands beyond this point should not need to know the version.
set(CMAKE_IMPORT_FILE_VERSION)
