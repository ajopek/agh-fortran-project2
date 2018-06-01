! matrix multiplication tests
!@test
subroutine test_hello_world()
    use pfunit_mod
    implicit none
#line 6 "matrix_multiplication_test.pf"
  call assertEqual("Hello world!", "Hello world", &
 & location=SourceLocation( &
 & 'matrix_multiplication_test.pf', &
 & 6) )
  if (anyExceptions()) return
#line 7 "matrix_multiplication_test.pf"
end subroutine
module Wrapmatrix_multiplication_test
   use pFUnit_mod
   implicit none
   private

contains


end module Wrapmatrix_multiplication_test

function matrix_multiplication_test_suite() result(suite)
   use pFUnit_mod
   use Wrapmatrix_multiplication_test
   type (TestSuite) :: suite

   external test_hello_world


   suite = newTestSuite('matrix_multiplication_test_suite')

   call suite%addTest(newTestMethod('test_hello_world', test_hello_world))


end function matrix_multiplication_test_suite

