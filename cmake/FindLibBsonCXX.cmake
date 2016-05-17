# Copyright 2016 BsonDB Inc.
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

# Find libbsoncxx, either via pkg-config, find-package in config mode,
# or other less admirable jiggery-pokery

SET(LIBBSONCXX_DIR "" CACHE STRING "Manual search path for libbsoncxx")

include(FindPackageHandleStandardArgs)

# Load up PkgConfig if we have it
find_package(PkgConfig QUIET)

if (PKG_CONFIG_FOUND)
  pkg_check_modules(LIBBSONCXX REQUIRED libbsoncxx>=${LibBsonCXX_FIND_VERSION} )
  # We don't reiterate the version information here because we assume that
  # pkg_check_modules has honored our request.
  find_package_handle_standard_args(LIBBSONCXX DEFAULT_MSG LIBBSONCXX_FOUND)
elseif(LIBBSONCXX_DIR)
  # The best we can do until libBSONCXX starts installing a libbsoncxx-config.cmake file
  set(LIBBSONCXX_LIBRARIES bsoncxx CACHE INTERNAL "")
  set(LIBBSONCXX_LIBRARY_DIRS ${LIBBSONCXX_DIR}/lib CACHE INTERNAL "")
  set(LIBBSONCXX_INCLUDE_DIRS ${LIBBSONCXX_DIR}/include/libbsoncxx CACHE INTERNAL "")
  find_package_handle_standard_args(LIBBSONCXX DEFAULT_MSG LIBBSONCXX_LIBRARIES LIBBSONCXX_LIBRARY_DIRS LIBBSONCXX_INCLUDE_DIRS)
else()
    message(FATAL_ERROR "Don't know how to find libbsoncxx; please set LIBBSONCXX_DIR to the prefix directory with which libbsonxx was configured.")
endif()
