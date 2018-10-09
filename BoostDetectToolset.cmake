# Copyright 2017, 2018 Peter Dimov
# Distributed under the Boost Software License, Version 1.0.
# (See accompanying file LICENSE_1_0.txt or copy at http://boost.org/LICENSE_1_0.txt)

string(REGEX MATCHALL "[0-9]+" _BOOST_COMPILER_VERSION ${CMAKE_CXX_COMPILER_VERSION})

list(GET _BOOST_COMPILER_VERSION 0 _BOOST_COMPILER_VERSION_MAJOR)
list(GET _BOOST_COMPILER_VERSION 1 _BOOST_COMPILER_VERSION_MINOR)

if(BORLAND)

  # Borland is unversioned

  set(BOOST_DETECTED_TOOLSET "bcb")

  set(_BOOST_COMPILER_VERSION_MAJOR)
  set(_BOOST_COMPILER_VERSION_MINOR)

elseif(CMAKE_CXX_COMPILER_ID STREQUAL "AppleClang")

  set(BOOST_DETECTED_TOOLSET "clang-darwin")

  if(_BOOST_COMPILER_VERSION_MAJOR GREATER 3)
    set(_BOOST_COMPILER_VERSION_MINOR)
  endif()

elseif(CMAKE_CXX_COMPILER_ID STREQUAL "Clang")

  set(BOOST_DETECTED_TOOLSET "clang")

  if(_BOOST_COMPILER_VERSION_MAJOR GREATER 3)
    set(_BOOST_COMPILER_VERSION_MINOR)
  endif()

elseif(CMAKE_CXX_COMPILER_ID STREQUAL "Intel")

  if(WIN32)

    # Intel-Win is unversioned

    set(BOOST_DETECTED_TOOLSET "iw")

    set(_BOOST_COMPILER_VERSION_MAJOR)
    set(_BOOST_COMPILER_VERSION_MINOR)

  else()

    set(BOOST_DETECTED_TOOLSET "il")

  endif()

elseif(CMAKE_CXX_COMPILER_ID STREQUAL "MIPSpro")

    set(BOOST_DETECTED_TOOLSET "mp")

elseif(CMAKE_CXX_COMPILER_ID STREQUAL "SunPro")

    set(BOOST_DETECTED_TOOLSET "sun")

elseif(CMAKE_CXX_COMPILER_ID STREQUAL "IBM XL")

    set(BOOST_DETECTED_TOOLSET "xlc")

elseif(MINGW)

  set(BOOST_DETECTED_TOOLSET "mgw")

  if(_BOOST_COMPILER_VERSION_MAJOR GREATER 4)
    set(_BOOST_COMPILER_VERSION_MINOR)
  endif()

elseif(CMAKE_COMPILER_IS_GNUCXX)

  if(APPLE)
    set(BOOST_DETECTED_TOOLSET "xgcc")
  else()
    set(BOOST_DETECTED_TOOLSET "gcc")
  endif()

  if(_BOOST_COMPILER_VERSION_MAJOR GREATER 4)
    set(_BOOST_COMPILER_VERSION_MINOR)
  endif()

elseif(MSVC)

  if(MSVC_VERSION EQUAL 1910)

    set(BOOST_DETECTED_TOOLSET "vc141")

  elseif(MSVC_VERSION EQUAL 1900)

    set(BOOST_DETECTED_TOOLSET "vc140")

  elseif(MSVC_VERSION EQUAL 1800)

    set(BOOST_DETECTED_TOOLSET "vc120")

  elseif(MSVC_VERSION EQUAL 1700)

    set(BOOST_DETECTED_TOOLSET "vc110")

  elseif(MSVC_VERSION EQUAL 1600)

    set(BOOST_DETECTED_TOOLSET "vc100")

  elseif(MSVC_VERSION EQUAL 1500)

    set(BOOST_DETECTED_TOOLSET "vc90")

  elseif(MSVC_VERSION EQUAL 1400)

    set(BOOST_DETECTED_TOOLSET "vc80")

  elseif(MSVC_VERSION EQUAL 1310)

    set(BOOST_DETECTED_TOOLSET "vc71")

  elseif(MSVC_VERSION EQUAL 1300)

    set(BOOST_DETECTED_TOOLSET "vc7")

  elseif(MSVC_VERSION EQUAL 1200)

    set(BOOST_DETECTED_TOOLSET "vc6")

  endif()

  set(_BOOST_COMPILER_VERSION_MAJOR)
  set(_BOOST_COMPILER_VERSION_MINOR)

else()

  # Unknown toolset

  if(Boost_DEBUG)
    message(STATUS "BoostDetectToolset: unknown compiler ${CMAKE_CXX_COMPILER_ID} ${CMAKE_CXX_COMPILER_VERSION}")
  endif()

  return()

endif()

# Add version

set(BOOST_DETECTED_TOOLSET ${BOOST_DETECTED_TOOLSET}${_BOOST_COMPILER_VERSION_MAJOR}${_BOOST_COMPILER_VERSION_MINOR})

unset(_BOOST_COMPILER_VERSION)
unset(_BOOST_COMPILER_VERSION_MAJOR)
unset(_BOOST_COMPILER_VERSION_MINOR)

if(Boost_DEBUG)
  message(STATUS "Boost toolset is ${BOOST_DETECTED_TOOLSET} (${CMAKE_CXX_COMPILER_ID} ${CMAKE_CXX_COMPILER_VERSION})")
endif()
