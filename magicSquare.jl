# 0. IS MAGIC SQUARE
function isMagic(mat::AbstractMatrix)
    nRows, nCols = size(mat)
    if nRows != nCols
        return error("Error input: The input matrix must be a square matrix")
    else
        sumRow = (nRows^2 + 1) * nRows ÷ 2
        for i = 1:nCols
            if sum(mat[i, :]) != sumRow || sum(mat[:, i]) != sumRow
                return false
            end
        end
        return true
    end
end

# 1. ODD ORDER MAGIC SQUARE (n = 2k + 1)
# 1.1. Dr.Phuong's way
function oddMagic(order::Int)
    n = order
    if n % 2 == 0 || n < 3
        return error("Matrix's size must be odd and >=3!")
    end
    mat = zeros(Int, n, n)
    matSize = n^2
    matEntry = 1
    row = 1
    col = div(n, 2) + 1
    while matEntry ≤ matSize
        mat[row, col] = matEntry
        nextRow = (row == 1 ? n : row - 1)
        nextCol = (col == n ? 1 : col + 1)
        if mat[nextRow, nextCol] != 0
            nextRow = (row == n ? 1 : row + 1)
            nextCol = col
        end
        row, col = nextRow, nextCol
        matEntry += 1
    end
    return mat
end

# 1.2. My way
# function oddMagic(order::Int)
#     n = order
#     if n < 3 || isodd(n) == false
#         return print(n, " is not a odd number!\nEnter an odd number to perform this function.")
#     end
#     mat = zeros(Int, 2*n-1, 2*n-1) # magicSquarebound
#     matEntry = 1
#     # fill 1-->n^2 to diagonal 
#     for j = 1:n
#         for i = j:n-1+j
#             mat[i, n-(2*j-1)+i] = matEntry
#             matEntry += 1
#         end
#     end
#     # fill another entries of magic_square
#     k = n ÷ 2
#     for i = k+1:k+n
#         for j = k+1:k+n
#             if j < n && mat[i, j] == 0
#                 mat[i, j] = mat[i, j+n]
#             end
#             if j > n && mat[i, j] == 0
#                 mat[i, j] = mat[i, j-n]
#             end
#             if i < n && mat[i, j] == 0
#                 mat[i, j] = mat[i+n, j]
#             end
#             if i > n && mat[i, j] == 0
#                 mat[i, j] = mat[i-n, j]
#             end
#         end
#     end
#     magicSquare = mat[k+1:k+n, k+1:k+n]
#     return magicSquare
# end

#------------------------------------------------------------------------------

# 2. DOUBLY EVEN ORDER MAGIC SQUARE
function doublyEvenMagic(order::Int)
    n = order
    if n < 4 || mod(n, 4) != 0
        return error("Matrix's size is not divisible by 4")
    end
    mat = zeros(Int, n, n)
    s = n^2 + 1
    for i = 1:n
        for j = 1:n
            matEntry = j + n * (i - 1)
            if (abs(i - j) % 4 == 0 || (i + j) % 4 == 1)
                mat[i, j] = matEntry
            else
                mat[i, j] = s - matEntry
            end
        end
    end
    return mat
end

#------------------------------------------------------------------------------
# 3. SINGLY EVEN ORDER MAGIC SQUARE
function singlyEvenMagic(order::Int)
    n = order
    if n < 6 || mod(n, 4) != 2
        return error("Matrix's size must be a singly even number")
    end
    # divide the magicSquare by 4 sub-oddMagic
    # n = 4k + 2 --> p = 2k+1
    p = n ÷ 2
    A1 = oddMagic(p)
    A2 = A1 .+ p^2
    A3 = A1 .+ 2 * p^2
    A4 = A1 .+ 3 * p^2
    A = [A1 A3
        A4 A2]

    k = n ÷ 4
    # swap(a, b)

    A[1:2k+1, 1:k], A[2k+2:4k+2, 1:k] = A[2k+2:4k+2, 1:k], A[1:2k+1, 1:k]

    A[1:2k+1, 3k+4:4k+2], A[2k+2:4k+2, 3k+4:4k+2] = A[2k+2:4k+2, 3k+4:4k+2], A[1:2k+1, 3k+4:4k+2]

    A[k+1, 1], A[3k+2, 1] = A[3k+2, 1], A[k+1, 1]

    A[k+1, k+1], A[3k+2, k+1] = A[3k+2, k+1], A[k+1, k+1]

    return A
end

#------------------------------------------------------------------------------
# 4. MAGIC SQUARE
function magic(order::Int)
    n = order
    if n < 3
        return error(" Matrix's size must be >= 3 to perform this function.")
    end
    r = mod(n, 4)
    if r == 0
        mat = doublyEvenMagic(n)
    elseif r == 2
        mat = singlyEvenMagic(n)
    else
        mat = oddMagic(n)
    end
    return mat
end
# ----------------------------------------------------------------
# n = odd_number_ = 5
# A = A_bound_mat = zeros(Int, 2*n-1, 2*n-1)
# mat_entry = 1

# k = (n-1)÷2

# mat_entry = 1
# # j = 1
# # 1 = 2j - 1
# for i = 1:n
#     A[i, n-1+i] = mat_entry
#     mat_entry += 1
# end

# # j = 2
# # 3 = 2j - 1
# for i = 2:n+1
#     A[i, n-3+i] = mat_entry
#     mat_entry += 1
# end

# # j = 3
# # 5 = 2j - 1
# for i = 3:n+2
#     A[i, n-5+i] = mat_entry
#     mat_entry += 1
# end

# # j = 4
# # 7 = 2j-1
# for i = 4:n+3
#     A[i, n-7+i] = mat_entry
#     mat_entry += 1
# end

# # j = 5
# # 9 = 2j - 1
# for i = 5:n+4
#     A[i, n-9+i] = mat_entry
#     mat_entry += 1
# end

# for j = 1:n
#     for i = j : n-1+j
#         A[i, n-(2*j-1)+i] = mat_entry
#         mat_entry += 1
#     end
# end
# A
# k = n ÷ 2

# for i = k+1 : k+n
#     for j = k+1 : k+n
#         if j < n && A[i, j] == 0
#             A[i, j] = A[i, j+n]
#         end
#         if j > n && A[i, j] == 0
#             A[i, j] = A[i, j-n]
#         end
#         if i < n && A[i, j] == 0
#             A[i, j] = A[i+n, j]
#         end
#         if i > n && A[i, j] == 0
#             A[i, j] = A[i-n, j]
#         end
#     end
# end
# A
# B = A[k+1:k+n, k+1:k+n]
