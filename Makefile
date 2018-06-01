.PHONY: all


IFORTFLAGS=-funroll-all-loops -WB -std08 -module . -implicitnone -fpp -warn all -pedantic -fpp -Iout/ -g
GFORTFLAGS=-O3 -ffree-form -std=f2008 -fimplicit-none -Wall -pedantic -fbounds-check -cpp

all: out/main

out/main:
	mkdir -p out 
	ifort $(IFORTFLAGS)  src/matrix_multiplication.f90 src/main.f90 -o $@_basic -D "BASIC=1"
	ifort $(IFORTFLAGS)  src/matrix_multiplication.f90 src/main.f90 -o $@_dotproduct -D "DOTPRODUCT=1"
	ifort $(IFORTFLAGS)  src/matrix_multiplication.f90 src/main.f90 -o $@_cached -D "CACHED=1"
	ifort $(IFORTFLAGS)  src/matrix_multiplication.f90 src/main.f90 -o $@_both -D "BOTH=1"
	ifort $(IFORTFLAGS)  src/matrix_multiplication.f90 src/main.f90 -o $@_builtin -D "BUILTIN=1"
	ifort $(IFORTFLAGS) -O2 src/matrix_multiplication.f90 src/main.f90 -o $@_basic_o2 -D "BASIC=1"
	ifort $(IFORTFLAGS) -O2 src/matrix_multiplication.f90 src/main.f90 -o $@_dotproduct_o2 -D "DOTPRODUCT=1"
	ifort $(IFORTFLAGS) -O2 src/matrix_multiplication.f90 src/main.f90 -o $@_cached_o2 -D "CACHED=1"
	ifort $(IFORTFLAGS) -O2 src/matrix_multiplication.f90 src/main.f90 -o $@_both_o2 -D "BOTH=1"
	ifort $(IFORTFLAGS) -O2 src/matrix_multiplication.f90 src/main.f90 -o $@_builtin_o2 -D "BUILTIN=1"
clean:
	rm -rf out
	mkdir out
