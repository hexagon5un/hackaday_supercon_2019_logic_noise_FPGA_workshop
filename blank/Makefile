PROJ=top
CONSTR=../includes/had19_proto2.lpf
TRELLIS=/usr/share/trellis
#Image read mode: qspi, dual-spi, fast-read
FLASH_MODE=qspi
#Image read freq, in MHz: 2.4, 4.8, 9.7, 19.4, 38.8, 62.0
FLASH_FREQ=38.8 #MHz


all: $(PROJ).svf old_flash

%.json: %.v
	yosys -l yosys.log -p "synth_ecp5 -json $@" $<

%_out.config: %.json
	nextpnr-ecp5 --json $< --lpf $(CONSTR) --textcfg $@ --45k --package CABGA381 --speed 8 -l nextpnr.log

%.bit: %_out.config
	ecppack --svf-rowsize 100000  --spimode $(FLASH_MODE) --freq $(FLASH_FREQ) \
		--svf $(PROJ).svf --input $< --bit $@

$(PROJ).svf: $(PROJ).bit

prog: $(PROJ).svf
	openocd -f ../openocd.cfg -c "init; svf  $<; exit"

clean:
	rm -f $(PROJ).json $(PROJ).svf $(PROJ).bit $(PROJ)_out.config yosys.log nextpnr.log

dfu_flash: $(PROJ).bit
	dfu-util$(EXE) -d 1d50:614a,1d50:614b -a 2 -R -D $(PROJ).bit
old_flash: $(PROJ).bit
	tinyprog -p $(PROJ).bit -a 0x180000

.PHONY: prog clean
.PRECIOUS: ${PROJ}.json ${PROJ}_out.config

