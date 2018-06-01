module matrix_multiplication        
contains
#ifdef BASIC
    subroutine mm(first, second, multiply, status)
        implicit none
        real (kind = 8), intent(in)     :: first(:,:) 
        real (kind = 8), intent(in)     :: second(:,:)
        real (kind = 8), intent(out)    :: multiply(:,:)
        integer (kind = 4), intent(out) :: status
        real (kind = 8) :: start, finish
        integer :: i, j, k ! Iterators
        integer :: shape_first(2), shape_second(2) ! Matrix sizes

        shape_first = SHAPE(first)
        shape_second = SHAPE(second)
        multiply(:, :) = 0

        

        call CPU_TIME(start)

        if (shape_second(1) .EQ. shape_first(2)) then        
            do i=1, shape_first(1)
                do j=1, shape_second(2)
                    do k=1, shape_second(1)
                    multiply(i, j) = multiply(i, j) + first(i, k) * second(k, j)
                    end do
                end do
            end do
            status = 0
        else 
            status = 1
        end if

        call CPU_TIME(finish)
        write (*, *) shape_first(1)*shape_first(1), finish - start
    end subroutine
#elif DOTPRODUCT
    function dot_product(first, second, n) result(product)
        real (kind = 8), intent(in) :: first(:) 
        real (kind = 8), intent(in) :: second(:)
        real (kind = 8)             :: product
        integer                     :: i, n    
        product = 0.d0
        do i=1, n
            product = product + first(i) * second(i)
        end do

    end function    

    subroutine mm(first, second, multiply, status)
        implicit none
        real (kind = 8), intent(in)     :: first(:,:) 
        real (kind = 8), intent(in)     :: second(:,:)
        real (kind = 8), intent(out)    :: multiply(:,:)
        integer (kind = 4), intent(out) :: status
        real (kind = 8) :: start, finish
        integer :: i, j, k ! Iterators
        integer :: shape_first(2), shape_second(2) ! Matrix sizes

        shape_first = SHAPE(first)
        shape_second = SHAPE(second)
        multiply(:, :) = 0

        

        call CPU_TIME(start)

        if (shape_second(1) .EQ. shape_first(2)) then        
            do i=1, shape_first(1)
                do j=1, shape_second(2)
                    multiply(i, j) = dot_product(first(i,:), second(:,j), shape_second(1))
                end do
            end do
            status = 0
        else 
            status = 1
        end if

        call CPU_TIME(finish)
        write (*, *) shape_first(1)*shape_first(1), finish - start
    end subroutine
#elif CACHED
    subroutine mm(first, second, multiply, status)
        implicit none
        real (kind = 8), intent(in)     :: first(:,:) 
        real (kind = 8), intent(in)     :: second(:,:)
        real (kind = 8), intent(out)    :: multiply(:,:)
        integer (kind = 4), intent(out) :: status
        real (kind = 8) :: start, finish
        integer :: i, j, k, jj, kk ! Iterators
        integer :: ichunk
        integer :: shape_first(2), shape_second(2) ! Matrix sizes

        shape_first = SHAPE(first)
        shape_second = SHAPE(second)
        multiply(:, :) = 0

        ichunk = 512

        call CPU_TIME(start)

        if (shape_second(1) .EQ. shape_first(2)) then        
            do jj=1, shape_second(2), ichunk
                do kk=1, shape_first(2), ichunk
                    do j = jj, min(jj + ichunk - 1, shape_second(2))
                        do k = kk, min(kk + ichunk - 1, shape_first(2))
                            do i=1, shape_first(1)
                                multiply(i, j) = multiply(i, j) + first(i, k) * second(k, j)
                            end do
                        end do
                    end do 
                end do
            end do
            status = 0
        else 
            status = 1
        end if

        call CPU_TIME(finish)
        write (*, *) shape_first(1)*shape_first(1), finish - start
    end subroutine
#elif BOTH
    subroutine mm(first, second, multiply, status)
        implicit none
        real (kind = 8), intent(in)     :: first(:,:) 
        real (kind = 8), intent(in)     :: second(:,:)
        real (kind = 8), intent(out)    :: multiply(:,:)
        integer (kind = 4), intent(out) :: status
        real (kind = 8) :: start, finish
        integer :: i, j, k, jj, kk ! Iterators
        integer :: ichunk
        integer :: shape_first(2), shape_second(2) ! Matrix sizes

        shape_first = SHAPE(first)
        shape_second = SHAPE(second)
        multiply(:, :) = 0

        ichunk = 512        

        call CPU_TIME(start)

        if (shape_second(1) .EQ. shape_first(2)) then        
            do jj=1, shape_second(2), ichunk
                do kk=1, shape_first(1), ichunk
                    do j = jj, min(jj + ichunk - 1, shape_second(2))
                        do k = kk, min(kk + ichunk - 1, shape_first(1))
                            multiply(k, j) = dot_product(first(k, :), second(:, j))
                        end do
                    end do 
                end do
            end do
            status = 0
        else 
            status = 1
        end if

        call CPU_TIME(finish)
        write (*, *) shape_first(1)*shape_first(1), finish - start
    end subroutine
#endif
end module