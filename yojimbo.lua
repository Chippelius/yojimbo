
project "yojimbo"
    kind "StaticLib"
    language "C++"
    rtti "Off"
    warnings "Extra"
    floatingpoint "Fast"
    vectorextensions "SSE2"
	targetdir (basetargetdir .. "/%{prj.name}")
	objdir (baseobjdir .. "/%{prj.name}")
	
    defines { "NETCODE_ENABLE_TESTS=1", "RELIABLE_ENABLE_TESTS=1" }
	
    files { "yojimbo.h", "yojimbo.cpp", "certs.h", "certs.c", "tlsf/tlsf.h", "tlsf/tlsf.c", "netcode.io/netcode.c", "netcode.io/netcode.h", "reliable.io/reliable.c", "reliable.io/reliable.h" }
    if os.istarget "windows" then
        includedirs { ".", "./windows", "netcode.io", "reliable.io" }
        libdirs { "./windows" }
    else
        includedirs { ".", "/usr/local/include", "netcode.io", "reliable.io" }
        targetdir "bin/"  
    end
    links { "sodium", "mbedtls", "mbedx509", "mbedcrypto" }
	
    filter "configurations:Debug"
        defines { "YOJIMBO_DEBUG", "NETCODE_DEBUG", "RELIABLE_DEBUG" }
        symbols "On"
    filter "configurations:Release"
        defines { "YOJIMBO_RELEASE", "NETCODE_RELEASE", "RELIABLE_RELEASE" }
        optimize "Speed"
	filter ""
