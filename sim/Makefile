BSUB = bsub -I 
TEST = test
SEED = 123456
VERB = UVM_LOW
WAVE = 1
DIR = 

VCS_OPTS = \
	-full64 -sverilog \
	-debug_access+pp -kdb \
	-ntb_opts uvm-1.2 \
	-timescale=1ps/1ps \
	+warn=noLINX_KRNL \
	+define+UVM_NO_DEPRECATED \
	-f $(WORKSPACE)/src/filelist
	
SIM_OPTS = \
	+vcs+lic+wait \
	+UVM_MAX_QUIT_COUNT=10 \
	+UVM_VERBOSITY=$(VERB) \
	+UVM_TESTNAME=$(TEST) \
	+ntb_random_seed=$(SEED) \
	-ucli -i $(WORKSPACE)/tcl/run.tcl
	
ifeq (, $(DIR))
TB_DIR = $(CURDIR)/build
TB_LOG = $(CURDIR)/build/comp.log
TC_DIR = $(CURDIR)/$(TEST)_$(SEED)
TC_LOG = $(CURDIR)/$(TEST)_$(SEED)/job.log
else
TB_DIR = $(CURDIR)/$(DIR)/build
TB_LOG = $(CURDIR)/$(DIR)/build/comp.log
TC_DIR = $(CURDIR)/$(DIR)/$(TEST)_$(SEED)
TC_LOG = $(CURDIR)/$(DIR)/$(TEST)_$(SEED)/job.log
endif

.PHONY: build

all: check build test

check:
ifndef VCS_HOME
	$(error ERROR : VCS_HOME is not set)
endif
ifndef VERDI_HOME
	$(error ERROR : VERDI_HOME is not set)
endif
ifndef WORKSPACE
	$(error ERROR : WORKSPACE is not set)
endif
export DUMP=$(WAVE)

build: check
	rm -f $(TB_DIR)/PASS
	mkdir -p $(TB_DIR) && \
		cd $(TB_DIR) && \
		$(BSUB) vcs $(VCS_OPTS) -l comp.log \
		&& touch $(TB_DIR)/PASS
	echo "sbsbsbsbsbsbsbsbsbsbsbsbsbsbsbsbsbsbsbsbsbsbsbsbsbsbsbsbsbsbsbsbsbsbsbsbsbsbsbsb"
	echo "refer to log file: $(TB_LOG)"
	test -f $(TB_DIR)/PASS || { echo "fail to build testbench" ; exit 1; }
	
test: check
	rm -f $(TC_DIR)/PASS
	mkdir -p $(TC_DIR) && \
		cd $(TC_DIR) && \
		$(BSUB) $(TB_DIR)/simv $(SIM_OPTS) -l job.log \
		&& touch $(TC_DIR)/PASS
	echo "fkfkfkfkfkfkfkfkfkfkfkfkfkfkfkfkfkfkfkfkfkfkfkfkfkfkfkfkfkfkfkfkfkfkfkfkfkfkfkfkfk"
	echo "refer to log file: $(TC_LOG)"
	test -f $(TC_DIR)/PASS || { echo "fail to build sinulate $(TEST)" ; exit 1; }
	
wave: check
	cd $(TC_DIR) && verdi -ssf novas.fsdb
	
clean:
	rm -rf $(TB_DIR)