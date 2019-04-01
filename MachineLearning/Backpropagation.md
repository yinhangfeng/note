# 反向传播数学证明

反向传播是在神经网络上执行梯度下降法的主要算法。该算法会先按前向传播方式计算（并缓存）每个节点的输出值，然后再按反向传播遍历图的方式计算损失函数值相对于每个参数的偏导数。

**定义第 $l$ 层的第 $j$ 个神经元的误差 $\delta_j^l$ 为**
$$
\delta_j^l = \frac {\partial C}{\partial z_j^l} \tag{1}
$$

应用链式法则可得
$$
\delta_j^l = \sum_k \frac {\partial C}{\partial a_k^l} \frac {\partial a_k^l}{\partial z_j^l} \tag{2}
$$

当 $k \ne j​$ 时，$\partial a_k^l / \partial z_j^l​$ 将会消失
$$
\delta_j^l = \frac {\partial C}{\partial a_j^l} \frac {\partial a_j^l}{\partial z_j^l} \tag{3}
$$

由于 $a_j^l = \sigma (z_j^l)$
$$
\delta_j^l = \frac {\partial C}{\partial a_j^l} \sigma' (z_j^l) \tag{4}
$$

所以最后一层(输出层)的误差 $\delta_j^L$ 为
$$
\delta_j^L = \frac {\partial C}{\partial a_j^L} \sigma' (z_j^L) \tag{5}
$$

写成矩阵运算形式
$$
\delta^L = \nabla_a C \odot \sigma' (z^L) \tag{A}
$$

对于二次代价函数
$$
C = \frac {1}{2} ||y - a^L||^2 \tag{6}
$$

可得
$$
\delta^L = (a^L - y) \odot \sigma' (z^L) \tag{7}
$$


**$\delta_k^l$ 与 $\delta_k^{l+1}$ 的关系推导**
$$
\begin{aligned}
\delta_j^l &= \frac {\partial C}{\partial z_j^l}  \\
&= \sum_k \frac {\partial C}{\partial z_k^{l+1}} \frac {\partial z_k^{l+1}}{\partial z_j^l} \\
&= \sum_k \delta_k^{l+1} \frac {\partial z_k^{l+1}}{\partial z_j^l}
 \tag{8}
\end{aligned}
$$

为了计算 $\frac {\partial z_k^{l+1}}{\partial z_j^l}$，我们有
$$
z_k^{l+1} = \sum_j w_{kj}^{l+1} a_j^l + b_k^{l+1} = \sum_j w_{kj}^{l+1} \sigma (z_j^l) + b_k^{l+1} \tag{9}
$$

可得
$$
\frac {\partial z_k^{l+1}}{\partial z_j^l} = w_{kj}^{l+1} \sigma' (z_j^l) \tag{10}
$$

带入公式，得到
$$
\delta_j^l = \sum_k \delta_k^{l+1} w_{kj}^{l+1} \sigma' (z_j^l) \tag{11}
$$

写成矩阵运算形式
$$
\delta^l = ((w^{l+1})^T \delta^{l+1}) \odot \sigma' (z^l) \tag{B}
$$


**$\frac {\partial C}{\partial w_{jk}^l}$ 推导 ($z_p^l$ 表示 $l$ 层第 $p$ 个神经元的输入值)**
$$
\begin{aligned}
\frac {\partial C}{\partial w_{jk}^l} &= \sum_p \frac {\partial C}{\partial z_p^l} \frac {\partial z_p^l}{\partial w_{jk}^l} \\
&= \frac {\partial C}{\partial z_j^l} \frac {\partial z_j^l}{\partial w_{jk}^l} \\
&= \delta_j^l \frac {\partial z_j^l}{\partial w_{jk}^l}
 \tag{12}
\end{aligned}
$$

由于
$$
z_j^l = \sum_k w_{jk}^l a_k^{l-1} + b_j^l \tag{13}
$$

可得
$$
\frac {\partial z_j^l}{\partial w_{jk}^l} = a_k^{l-1} \tag{14}
$$

所以
$$
\frac {\partial C}{\partial w_{jk}^l} = \delta_j^l a_k^{l-1} \tag{15}
$$

写成矩阵运算形式
$$
\frac {\partial C}{\partial w^l} = \delta^l (a^{l-1})^T \tag{C}
$$


**$\frac {\partial C}{\partial b_j^l}$ 推导**
$$
\begin{aligned}
\frac {\partial C}{\partial b_j^l} &= \sum_k \frac {\partial C}{\partial z_k^l} \frac {\partial z_k^l}{\partial b_j^l} \\
&= \frac {\partial C}{\partial z_j^l} \frac {\partial z_j^l}{\partial b_j^l} \\
&= \delta_j^l \frac {\partial z_j^l}{\partial b_j^l}
 \tag{16}
\end{aligned}
$$

通过公式(13)可得
$$
\frac {\partial z_j^l}{\partial b_j^l} = 1 \tag{17}
$$

所以
$$
\frac {\partial C}{\partial b_j^l} = \delta_j^l \tag{18}
$$

写成矩阵运算形式
$$
\frac {\partial C}{\partial b^l} = \delta^l \tag{D}
$$


## 反向传播算法流程

应用上面证明的 (A) (B) (C) (D) 4个公式可以得到反向传播的程序实现流程

1. 对输入层设置相应的激活 $a^1$
2. 对于每一层 $l = 2, 3, \dots, L$，计算 $z^l = w^l a^{l-1} + b^l$ 以及 $a^l = \sigma (z^l)$
3. 利用公式 (A) 计算向量 $\delta^L$
4. 对于每一层 $l = L-1, L-2, \dots, 2$，利用公式 (B) 计算 $\delta^l$
5. 利用公式 (C) (D) 计算 $\frac {\partial C}{\partial w^l}$ 和 $\frac {\partial C}{\partial b^l}$，最后得到梯度


然后就可以利用梯度下降训练神经网络了

## 参考

- http://neuralnetworksanddeeplearning.com/chap2.html
- https://google-developers.gonglchuangl.net/machine-learning/crash-course/backprop-scroll/?hl=zh-cn
- https://zh.wikipedia.org/zh-cn/%E9%93%BE%E5%BC%8F%E6%B3%95%E5%88%99
- https://zh.wikipedia.org/zh-cn/%E5%81%8F%E5%AF%BC%E6%95%B0