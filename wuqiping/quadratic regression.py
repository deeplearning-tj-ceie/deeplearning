import tensorflow as tf
import numpy as np
import matplotlib.pyplot as plt


def add_layer(inputs, Weights, biases, activation_function=None):

    Wx_plus_b = tf.matmul(inputs, Weights) + biases
    if activation_function is None:
        outputs = Wx_plus_b
    else:
        outputs = activation_function(Wx_plus_b)
    return outputs, Weights, biases


def loss(predicted_y, target_y):
    return tf.math.reduce_mean(tf.math.square(predicted_y - target_y))


x_data = np.linspace(-1, 1, 300)[:, np.newaxis]
noise = np.random.normal(0, 0.05, x_data.shape)
y_data = np.square(x_data) - 0.5 + noise
x_data = x_data.astype(np.float32)
noise = noise.astype(np.float32)
y_data = y_data.astype(np.float32)

optimizer = tf.optimizers.SGD(learning_rate=0.1)

fig = plt.figure()
ax = fig.add_subplot(111)
ax.scatter(x_data, y_data)
plt.ion()
plt.show()

Wl = tf.Variable(tf.random.normal((1, 10)))
bl = tf.Variable(tf.zeros((1, 10)) + 0.1)
Wp = tf.Variable(tf.random.normal((10, 1)))
bp = tf.Variable(tf.zeros((1, 1)) + 0.1)

for i in range(1000):
    with tf.GradientTape() as tape:
        l1, Wl, bl = add_layer(x_data, Wl, bl, activation_function=tf.nn.relu)
        prediction, Wp, bp = add_layer(l1, Wp, bp, activation_function=None)
        loss_val = loss(prediction, y_data)

        print('loss: {}\n'.format(loss_val))

    grads = tape.gradient(loss_val, [Wl, bl, Wp, bp])  # 这里只使用Wl,bl也能得到结果
    optimizer.apply_gradients(zip(grads, [Wl, bl, Wp, bp]))
    print('Wl: {},\n bl{},\n Wp: {},\n bp: {}\n\n'.format(Wl.numpy(), bl.numpy(), Wp.numpy(), bp.numpy()))
    if i % 50 == 0:
        try:
            ax.lines.remove(lines[0])
        except Exception:
            pass
        lines = ax.plot(x_data, prediction.numpy(), 'r-', lw=5)
        plt.pause(0.1)
