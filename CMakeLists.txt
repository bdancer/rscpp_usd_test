cmake_minimum_required(VERSION 3.14.5)

project(rscpp_usd_test)

set_property(GLOBAL PROPERTY USE_FOLDERS ON)
set(CMAKE_VS_INCLUDE_INSTALL_TO_DEFAULT_BUILD ON)

set(HOUDINI_INSTALL_ROOT "C:/Program Files/Side Effects Software/Houdini 18.0.391" CACHE PATH "Houdini install root")

set(CMAKE_CXX_FLAGS "/MD /EHsc /GT /bigobj")
set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} /W1")
set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} /MP")
set(CMAKE_CXX_FLAGS_RELEASE "/O2 /Ob2 /DNDEBUG")
set(CMAKE_CXX_FLAGS_DEBUG "/Od /Z7 /DNDEBUG")
set(CMAKE_SHARED_LINKER_FLAGS "${CMAKE_SHARED_LINKER_FLAGS} /INCREMENTAL:NO /ignore:4099 /ignore:4217")
set(CMAKE_SHARED_LINKER_FLAGS_DEBUG "${CMAKE_SHARED_LINKER_FLAGS_DEBUG} /debug /NODEFAULTLIB:MSVCRTD")

file(GLOB_RECURSE SOURCES "src/*.cpp")

add_definitions(
	-D_CRT_SECURE_NO_WARNINGS
	-D_SCL_SECURE_NO_WARNINGS
	-DNOMINMAX
	-DYY_NO_UNISTD_H
	-DOPENEXR_DLL
	-DPXR_PYTHON_ENABLED=0
	-DTBB_USE_DEBUG=0
	-DQT_NO_KEYWORDS=1
)

set(HDK_USD_INC_PATH
	${HOUDINI_INSTALL_ROOT}/toolkit/include
)

set(HDK_USD_LIB_PATH
	${HOUDINI_INSTALL_ROOT}/custom/houdini/dsolib
)

set(HDK_USD_LINK_LIBS
	hboost_chrono-mt
	hboost_filesystem-mt
	hboost_iostreams-mt
	hboost_program_options-mt
	hboost_regex-mt
	hboost_system-mt
	hboost_thread-mt
)

list(APPEND HDK_USD_LINK_LIBS
	libpxr_ar
	libpxr_arch
	libpxr_plug
	libpxr_tf
	libpxr_trace
	libpxr_vt
	libpxr_work
	libpxr_hf
	libpxr_hd
	libpxr_hdSt
	libpxr_hdx
	libpxr_sdf
	libpxr_gf
)

set(HDK_DEFS
	-DHBOOST_ALL_NO_LIB
)

function(usd_target _target _sources _defines _inc_path _lib_path _link_libs _install_path)
	add_library(${_target} SHARED "${_sources}")

	target_compile_definitions(${_target} PRIVATE ${_defines})
	target_include_directories(${_target} PRIVATE ${_inc_path})
	target_link_directories(${_target} PRIVATE ${_lib_path})
	target_link_libraries(${_target} PRIVATE ${_link_libs})

	if(WIN32)
		target_link_libraries(${_target}
			PRIVATE
				${_link_libs}

				# Windows
				advapi32
				comctl32
				comdlg32
				gdi32
				kernel32
				msvcprt
				msvcrt
				odbc32
				odbccp32
				oldnames
				ole32
				oleaut32
				shell32
				user32
				uuid
				winspool
				ws2_32
		)
	endif()
endfunction()

usd_target(${PROJECT_NAME}
	"${SOURCES}"
	"${HDK_DEFS}" "${HDK_USD_INC_PATH}" "${HDK_USD_LIB_PATH}" "${HDK_USD_LINK_LIBS}" "${HDK_USD_PLUGIN_PATH}"
)
