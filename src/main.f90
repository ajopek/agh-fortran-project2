program project2
    use matrix_multiplication, only: mm
    implicit none
    real(kind= 8), allocatable :: first(:, :), second(:, :), result(:, :)
    integer(kind=4) :: i, j, status, n, m, k

    read(*, *) n
    m = n
    k = n

    allocate(first(n, k))
    allocate(second(k, m))
    allocate(result(n, m))

    do i=1,n
        do j=1,k
            first(i, j) = i*j + 1
        enddo
    enddo

    do i=1,k
        do j=1,m
            second(i, j) = i**j + 1
        enddo
    enddo

    call mm(first, second, result, status)
end program