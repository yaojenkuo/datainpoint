# 建立一個 3 x 4 的矩陣，其中的數字皆是 24
my_mat <- matrix(24, nrow = 3, ncol = 4)
my_mat

# 建立一個 2 x 3的矩陣，其中的文字皆是 Luke Skywalker
luke_mat <- matrix("Luke Skywalker", nrow = 2, ncol = 3)
luke_mat

# 建立一個 4 x 2 的矩陣，其中的邏輯值皆是 TRUE
true_mat <- matrix(TRUE, nrow = 4, ncol = 2)
true_mat

# 將 5, 3, 2, 17 這四個數字放入一個 2 x 2 的矩陣
conf_mat <- matrix(c(5, 3, 2, 17), nrow = 2, ncol = 2)
conf_mat

# 將 5, 3, 2, 17 這四個數字放入一個 2 x 2 的矩陣，指定 byrow 參數為 TRUE
conf_mat <- matrix(c(5, 3, 2, 17), nrow = 2, ncol = 2, byrow = TRUE)
conf_mat

# 分別選出矩陣中的數字
conf_mat <- matrix(c(5, 3, 2, 17), nrow = 2, ncol = 2)
conf_mat[1, 1]
conf_mat[2, 1]
conf_mat[1, 2]
conf_mat[2, 2]

# 選擇一整列或一整欄
conf_mat <- matrix(c(5, 3, 2, 17), nrow = 2, ncol = 2)
conf_mat[1,]
conf_mat[2,]
conf_mat[,1]
conf_mat[,2]

# 在列標籤標註 Predicted Positive、Predicted Negative，在欄標籤標註 Condition Positive、Condition Negative
conf_mat <- matrix(c(5, 3, 2, 17), nrow = 2, ncol = 2,
                   dimnames = list(c("Predicted Positive", "Predicted Negative"),
                                   c("Condition Positive", "Condition Negative"))
                   )
conf_mat

# 對已經創建好的矩陣應用 rownames() 與 colnames() 函數
conf_mat <- matrix(c(5, 3, 2, 17), nrow = 2, ncol = 2)
rownames(conf_mat) <- c("Predicted Positive", "Predicted Negative")
colnames(conf_mat) <- c("Condition Positive", "Condition Negative")
conf_mat

# 應用 [列標籤, 欄標籤] 拆解矩陣
conf_mat <- matrix(c(5, 3, 2, 17), nrow = 2, ncol = 2,
                   dimnames = list(c("Predicted Positive", "Predicted Negative"),
                                   c("Condition Positive", "Condition Negative"))
)
conf_mat["Predicted Positive", "Condition Positive"] # 5
conf_mat[1, 1] # 5
conf_mat["Predicted Negative", "Condition Negative"] # 5
conf_mat[2, 2] # 17

# 將 5 x 5 的矩陣中的偶數篩選出來
my_mat <- matrix(1:25, nrow = 5, ncol = 5)
is_even <- my_mat %% 2 == 0
my_mat[is_even]

# 透過 diag(nrow, ncol) 函數建立出單位矩陣
diag(nrow = 2, ncol = 2) # 2 x 2 的單位矩陣
diag(nrow = 3, ncol = 3) # 3 x 3 的單位矩陣
diag(nrow = 4, ncol = 4) # 4 x 4 的單位矩陣

# 透過 t() 函數建立轉置矩陣
A <- matrix(11:16, nrow = 2, ncol = 3)
B <- t(A)
A
B

# 透過 solve() 函數可以取得對稱矩陣的反矩陣
M <- matrix(c(4, 2, -7, -3), nrow = 2, ncol = 2)
M_inv <- solve(M)
M_inv

# 並不是每個矩陣都具有反矩陣
M <- matrix(c(8, 12, 2, 3), nrow = 2, ncol = 2)
tryCatch(solve(M), error = function(e){
  print("矩陣為不可逆矩陣")
})

# 計算內積我們需要使用 %*% 符號
A <- matrix(c(4, 0, 5, -3, 1, 4, 2, -1, 0), nrow = 3, ncol = 3)
B <- matrix(c(2, 3, -1, 2, 1, 1, -5, 0, 4), nrow = 3, ncol = 3)
A %*% B

# 矩陣 M 與其反矩陣 M_inv 相乘可以得到一個單位矩陣
M <- matrix(c(4, 2, -7, -3), nrow = 2, ncol = 2)
M_inv <- solve(M)
M %*% M_inv

# 解線性聯立方程組：透過矩陣運算
A <- matrix(c(2, 1, 3, 4, 3, -2, 5, 1, -4, 3, 1, -1, 1, -2, -1, 1), nrow = 4, ncol = 4)
B <- matrix(c(15, -3, 20, 5), nrow = 4, ncol = 1)
A_inv <- solve(A)
x <- A_inv %*% B
x

# 解線性聯立方程組：透過 solve() 函數
A <- matrix(c(2, 1, 3, 4, 3, -2, 5, 1, -4, 3, 1, -1, 1, -2, -1, 1), nrow = 4, ncol = 4)
B <- matrix(c(15, -3, 20, 5), nrow = 4, ncol = 1)
x <- solve(A, B)
x