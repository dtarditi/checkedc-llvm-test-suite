# MultiSource/Benchmarks/MiBench Makefile

LEVEL = ../../..

## NOTE: This must remain in this order, so that the labels in the nightly 
## tester gnuplot scripts are correct.
PARALLEL_DIRS  := \
   automotive-basicmath \
   automotive-bitcount \
   automotive-susan \
   consumer-jpeg \
   consumer-lame \
   consumer-typeset \
   network-dijkstra \
   network-patricia \
   office-ispell \
   office-stringsearch \
   security-blowfish \
   security-rijndael \
   security-sha \
   telecomm-CRC32 \
   telecomm-FFT \
   telecomm-adpcm \
   telecomm-gsm

# FIXME: This is a hack, office-ispell requires termio which is less likely to
# be available on an embedded target. We should have configure support for this.
ifeq ($(ARCH),ARM)
  PARALLEL_DIRS := $(filter-out office-ispell, $(PARALLEL_DIRS))
endif

ifeq ($(ARCH),XCore)
  # xcore does not support sockets or sgtty
  PARALLEL_DIRS := $(filter-out consumer-lame, $(PARALLEL_DIRS))
  PARALLEL_DIRS := $(filter-out office-ispell, $(PARALLEL_DIRS))
endif

ifdef BENCHMARKING_ONLY
PARALLEL_DIRS := $(filter-out office-stringsearch, $(PARALLEL_DIRS))
PARALLEL_DIRS := $(filter-out office-ispell, $(PARALLEL_DIRS))
PARALLEL_DIRS := $(filter-out security-blowfish, $(PARALLEL_DIRS))
PARALLEL_DIRS := $(filter-out telecom-adpcm, $(PARALLEL_DIRS))
endif

include $(LEVEL)/Makefile.programs
