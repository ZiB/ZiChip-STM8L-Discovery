#----------------------------------------------------------
#	Makefile for STM8L-Discovery
#	Date: 01.10.2013
#	Denis Zheleznyakov aka ZiB @ http://ziblog.ru
#----------------------------------------------------------

SRC_C  = main.c
SRC_C += stm8_interrupt_vector.c
SRC_C += stm8l15x_it.c

#----------------------------------------------------------

CROSS_PATH = D:/Tools/Cosmic/4.3.7/
CROSS = $(CROSS_PATH)/

INCLUDES += -imcu
INCLUDES += -imcu/peripherals
INCLUDES += -imcu/std_lib/inc
INCLUDES += -imcu/std_lib/src
INCLUDES += -iutility

VPATH += mcu
VPATH += mcu/peripherals
VPATH += mcu/std_lib/inc
VPATH += mcu/std_lib/src
VPATH += utility

#----------------------------------------------------------

FLAGS_C  = +debug +warn +modsl0 -pxp -pp +compact +split -l -gge -pge

#----------------------------------------------------------

all: clean
	@make -s -j job_target
	@echo '-----------------------------------------------------------'
	@$(CROSS)cobj -n target/target.sm8 | $(CROSS)cosmic_format 'mcu/stm8l152c6.lsf'

job_target: target.elf

git:
	@C:/Tools/git/extensions/gitex browse .

git_commit:
	@C:/Tools/git/extensions/gitex commit .

%.elf: $(SRC_C:%.c=target/%.o)
	@echo '-----------------------------------------------------------'
	@echo linking: $@
	@$(CROSS)clnk -l'$(CROSS)/Lib' -o'target/target.sm8' -m'target/target.map' -sa 'mcu/stm8l152c6.lsf'
	@$(CROSS)cvdwarf target/target.sm8
	@$(CROSS)chex -o target/target.s19 target/target.sm8
	@rm -f target/*.o
	
$(SRC_C:%.c=target/%.o): target/%.o: %.c
	@$(CROSS)cxstm8 $(FLAGS_C) $(INCLUDES) -i. -i$(CROSS)/Hstm8 -cl'target' -co'target' $<

size:
	@echo '-----------------------------------------------------------'
	@$(CROSS)cobj -n target/target.sm8 | $(CROSS_PATH)cosmic_format 'mcu/stm8l152c6.lsf'
	
clean:
	@echo '-----------------------------------------------------------'
	@mkdir -p target
	@rm -f target/*.*

mcu_program:
	@D:/Tools/STMicroelectronics/toolset/stvp/STVP_CmdLine.exe -BoardName=ST-LINK -Device=STM8L15xC6 -Port=USB -ProgMode=SWIM -no_loop -no_log -FileProg=target/target.s19

mcu_restart:
	@D:/Tools/STMicroelectronics/toolset/stvd/gdb7.exe --quiet --command=mcu/stm8l152c6.ini
	
.PHONY : all clean program