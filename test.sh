#!/bin/bash

make clean
make

printf 'n   time \n' > result_basic.data
printf 'n   time \n' > result_dotproduct.data
printf 'n   time \n' > result_cached.data
printf 'n   time \n' > result_both.data

for i in {3..1000};
do
	out/main_basic <<<"$i" >> result_basic.data
	out/main_dotproduct <<<"$i" >> result_dotproduct.data
	out/main_cached <<<"$i" >> result_cached.data
	out/main_both <<<"$i" >> result_both.data
done
