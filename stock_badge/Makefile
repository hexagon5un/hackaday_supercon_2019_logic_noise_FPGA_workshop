all: dfu_flash_all

ifeq ($(OS),Windows_NT)
EXE:=.exe
endif

dfu_flash_all: 
	dfu-util$(EXE) -d 1d50:614a,1d50:614b -a 0 -D soc.bit
	dfu-util$(EXE) -d 1d50:614a,1d50:614b -a 1 -D ipl.bin -R
