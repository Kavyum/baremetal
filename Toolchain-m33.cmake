cmake_minimum_required (VERSION 3.2)

set(CMAKE_SYSTEM_NAME Generic)
set(CMAKE_SYSTEM_PROCESSOR arm)

# define the cross compiler
set(CROSS /usr/local/gcc-arm-none-eabi/gcc-arm-none-eabi-6-2017-q2-update/bin/arm-none-eabi-)
set(CMAKE_C_COMPILER ${CROSS}gcc)
set(CMAKE_C++_COMPILER ${CROSS}c++)
set(CMAKE_OBJCOPY ${CROSS}objcopy CACHE STRING "The objcopy utility of the cross toolchain" FORCE)
set(CMAKE_NM ${CROSS}gcc-nm CACHE STRING "The nm utility of the cross toolchain" FORCE)
set(CMAKE_AR ${CROSS}gcc-ar CACHE STRING "The ar utility of the cross toolchain" FORCE)
set(CMAKE_C_ARCHIVE_FINISH true)
# teste de asm full path set)
set(CMAKE_ASM_COMPILER /usr/local/gcc-arm-none-eabi/gcc-arm-none-eabi-6-2017-q2-update/bin/arm-none-eabi-gcc CACHE PATH "")

#
# Compilation flags
#

# Flags for Link-Time-Optimization
set(OPT_LTO_FLAGS -flto -ffat-lto-objects)

# Flags to use when LTO is not used; LTO produces smaller images without them,
# but they are much better than nothing if LTO cannot be used
set(OPT_NON_LTO_FLAGS -ffunction-sections -fdata-sections)

set(OTHER_CFLAGS "-std=gnu11 -Wall -Wextra")
set(CMAKE_C_FLAGS "${OTHER_CFLAGS}" CACHE STRING "" FORCE)

# Extra compilation flags for M33 (SYSCPU); LTO is not used by the SDK
# so we don't use it in the host library either
set(M33_FLAGS ${OPT_NON_LTO_FLAGS} -mcpu=cortex-m33 -mfloat-abi=hard -mfpu=fpv5-sp-d16 -mthumb -DARMCM33_DSP_FP)


# set link flags
set(CMAKE_EXE_LINKER_FLAGS "--specs=nano.specs --specs=nosys.specs -Wl,--gc-sections -g" CACHE STRING "Linker flags for DA14690-syscpu" FORCE)
