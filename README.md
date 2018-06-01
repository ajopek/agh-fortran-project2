# Matrix multiplication

Task for university Fortran classes.

### Prerequisites

- intel ifort compiler
- pFUnit

### Running

To compile all versions:
```  bash
make clean
make
```
Output in 'out' directory is 4 executables, each with different optimization of multiplying:
- main_basic - no optimization
- main_dotproduct - usage of dotproduct instead of a loop
- main_cached - using cache
- main_both - using both doproduct and cache

### Test
In 'test' directory:
``` bash
make
make test_basic
make test_dotproduct
make test_cached
make test_both
```
Then execute generated file to execute tests.

### Scripts
- test.sh - executes all 4 versions for different matrix sizes, result in results_(version).data
- Plots - python notebook for ploting the error data 