#!/bin/bash

make clean
make

printf 'type   n   time \n' > result.data


for i in {3..1000};
do
	printf 'basic  ' >> result.data
	out/main_basic <<<"$i" >> result.data
	printf 'dotproduct  ' >> result.data
	out/main_dotproduct <<<"$i" >> result.data
	printf 'cached  ' >> result.data
	out/main_cached <<<"$i" >> result.data
	printf 'both  ' >> result.data
	out/main_both <<<"$i" >> result.data
	printf 'builtin  ' >> result.data
	out/main_builtin <<<"$i" >> result.data
	printf 'basic_o2  ' >> result.data
	out/main_basic_o2 <<<"$i" >> result.data
	printf 'dotproduct_o2  ' >> result.data
	out/main_dotproduct_o2 <<<"$i" >> result.data
	printf 'cached_o2  ' >> result.data
	out/main_cached_o2 <<<"$i" >> result.data
	printf 'both_o2  ' >> result.data
	out/main_both_o2 <<<"$i" >> result.data
	printf 'builtin_o2  ' >> result.data
	out/main_builtin_o2 <<<"$i" >> result.data
done
