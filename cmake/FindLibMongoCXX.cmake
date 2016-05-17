# Copyright 2016 MongoDB Inc.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

# Find libmongocxx, either via pkg-config, find-package in config mode,
# or other less admirable jiggery-pokery

SET(LIBMONGOCXX_DIR "" CACHE STRING "Manual search path for libmongocxx")

include(FindPackageHandleStandardArgs)

# Load up PkgConfig if we have it
find_package(PkgConfig QUIET)

if (PKG_CONFIG_FOUND)
  pkg_check_modules(LIBMONGOCXX REQUIRED libmongocxx>=${LibMongoCXX_FIND_VERSION} )
  # We don't reiterate the version information here because we assume that
  # pkg_check_modules has honored our request.
  find_package_handle_standard_args(LIBMONGOCXX DEFAULT_MSG LIBMONGOCXX_FOUND)
elseif(LIBMONGOCXX_DIR)
  # The best we can do until libMONGOCXX starts installing a libmongocxx-config.cmake file
  set(LIBMONGOCXX_LIBRARIES mongocxx CACHE INTERNAL "")
  set(LIBMONGOCXX_LIBRARY_DIRS ${LIBMONGOCXX_DIR}/lib CACHE INTERNAL "")
  set(LIBMONGOCXX_INCLUDE_DIRS ${LIBMONGOCXX_DIR}/include/libmongocxx CACHE INTERNAL "")
  find_package_handle_standard_args(LIBMONGOCXX DEFAULT_MSG LIBMONGOCXX_LIBRARIES LIBMONGOCXX_LIBRARY_DIRS LIBMONGOCXX_INCLUDE_DIRS)
else()
    message(FATAL_ERROR "Don't know how to find libmongocxx; please set LIBMONGOCXX_DIR to the prefix directory with which libmongoxx was configured.")
endif()
