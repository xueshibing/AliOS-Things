NAME := qiming


$(NAME)_TYPE := kernel
MODULE               := 1062
HOST_ARCH            := Cortex-M4
HOST_MCU_FAMILY      := stm32f4xx_cube
SUPPORT_BINS         := no
HOST_MCU_NAME        := STM32F407ZET6
ENABLE_VFP           := 1

$(NAME)_SOURCES += aos/board_partition.c \
                   aos/soc_init.c
                   
$(NAME)_SOURCES += Src/stm32f4xx_hal_msp.c \
                   Src/can.c \
                   Src/crc.c \
                   Src/gpio.c \
									 Src/i2c.c \
									 Src/rtc.c \
									 Src/sdio.c \
									 Src/spi.c \
                   Src/usart.c \
                   Src/main.c


                   
ifeq ($(COMPILER), armcc)
$(NAME)_SOURCES += startup_stm32f407xx_keil.s    
else ifeq ($(COMPILER), iar)
$(NAME)_SOURCES += startup_stm32f407xx_iar.s  
else
$(NAME)_SOURCES += startup_stm32f407xx.s
endif

GLOBAL_INCLUDES += . \
                   hal/ \
                   aos/ \
                   Inc/
				   
GLOBAL_CFLAGS += -DSTM32F407xx -DCENTRALIZE_MAPPING

ifeq ($(COMPILER),armcc)
#GLOBAL_LDFLAGS += -L --scatter=board/starterkit/STM32L433.sct
else ifeq ($(COMPILER),iar)
GLOBAL_LDFLAGS += --config stm32f407xx_flash.icf
else
GLOBAL_LDFLAGS += -T STM32F407ZGTx_FLASH.ld
endif

CONFIG_SYSINFO_PRODUCT_MODEL := ALI_AOS_f407-qiming
CONFIG_SYSINFO_DEVICE_NAME := f407-qiming

GLOBAL_CFLAGS += -DSYSINFO_OS_VERSION=\"$(CONFIG_SYSINFO_OS_VERSION)\"
GLOBAL_CFLAGS += -DSYSINFO_PRODUCT_MODEL=\"$(CONFIG_SYSINFO_PRODUCT_MODEL)\"
GLOBAL_CFLAGS += -DSYSINFO_DEVICE_NAME=\"$(CONFIG_SYSINFO_DEVICE_NAME)\"
