PFUNIT = /home/artur/pfunit
F90_VENDOR = Intel

include $(PFUNIT)/include/base.mk

FFLAGS += -std08 -warn all -pedantic -I$(PFUNIT)/mod -fpp
LIBS = $(PFUNIT)/lib/libpfunit$(LIB_EXT)

PFS = $(wildcard *.pf)
OBJS = $(PFS:.pf=.o)

matrix_multiplication_test.F90: matrix_multiplication_test.pf
	$(PFUNIT)/bin/pFUnitParser.py $< $@

matrix_multiplication_basic.o:
	ifort $(FFLAGS) -c ../src/matrix_multiplication.f90 -D "BASIC=1" -o matrix_multiplication.o

matrix_multiplication_dotproduct.o:
	ifort $(FFLAGS) -c ../src/matrix_multiplication.f90 -D "DOTPRODUCT=1" -o matrix_multiplication.o

matrix_multiplication_cached.o:
	ifort $(FFLAGS) -c ../src/matrix_multiplication.f90 -D "CACHED=1" -o matrix_multiplication.o

matrix_multiplication_both.o:
	ifort $(FFLAGS) -c ../src/matrix_multiplication.f90 -D "BOTH=1" -o matrix_multiplication.o			

test_basic: testSuites.inc matrix_multiplication_basic.o $(OBJS)
	ifort -o $@ -D "BASIC=1" -I$(PFUNIT)/mod -I$(PFUNIT)/include $(PFUNIT)/include/driver.F90 ./*$(OBJ_EXT) $(LIBS) $(FFLAGS)

test_dotproduct: testSuites.inc matrix_multiplication_dotproduct.o $(OBJS)
	ifort -o $@ -D "DOTPRODUCT=1" -I$(PFUNIT)/mod -I$(PFUNIT)/include $(PFUNIT)/include/driver.F90 ./*$(OBJ_EXT) $(LIBS) $(FFLAGS)

test_cached: testSuites.inc matrix_multiplication_cached.o $(OBJS)
	ifort -o $@ -D "CACHED=1" -I$(PFUNIT)/mod -I$(PFUNIT)/include $(PFUNIT)/include/driver.F90 ./*$(OBJ_EXT) $(LIBS) $(FFLAGS)

test_both: testSuites.inc matrix_multiplication_both.o $(OBJS)
	ifort -o $@ -D "BOTH=1" -I$(PFUNIT)/mod -I$(PFUNIT)/include $(PFUNIT)/include/driver.F90 ./*$(OBJ_EXT) $(LIBS) $(FFLAGS)
