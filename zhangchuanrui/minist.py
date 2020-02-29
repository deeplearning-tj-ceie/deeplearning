
# coding: utf-8

# In[38]:

get_ipython().magic('matplotlib inline')
import keras


# In[39]:

import numpy as np
import matplotlib.pyplot as plt
plt.rcParams['figure.figsize']=(7,7)

from keras.datasets import mnist
from keras.models import Sequential
from keras.layers.core import Dense,Dropout,Activation
from keras.utils import np_utils


# In[40]:

nb_classes= 10
(x_train,y_train),(x_test,y_test)=mnist.load_data(path=r"mnist.npz")
print("x_train original shape",x_train.shape)
print("y_train original shape",y_train.shape)


# In[41]:

for i in range(9):
    plt.subplot(3,3,i+1)
    plt.imshow(x_train[i],cmap='gray',interpolation='none')
    plt.title("Class{}".format(y_train[i]))


# In[42]:

x_train=x_train.reshape(60000,784)
x_test=x_test.reshape(10000,784)
x_train=x_train.astype('float32')
x_test=x_test.astype('float32')
x_train/=255
x_test/=255
print("training shape",x_train.shape)
print("testing shape",x_test.shape)


# In[43]:

y_train=np_utils.to_categorical(y_train,nb_classes)
y_test=np_utils.to_categorical(y_test,nb_classes)


# In[44]:

model=Sequential()
model.add(Dense(512,input_shape=(784,)))
model.add(Activation('relu'))
model.add(Dropout(0.2))
model.add(Dense(512))
model.add(Activation('relu'))
model.add(Dropout(0.2))
model.add(Dense(10))
model.add(Activation('softmax'))


# In[55]:

model.compile(loss='categorical_crossentropy',optimizer='adam',metrics=['accuracy'])


# # 

# In[56]:

model.fit(x_train,y_train,
        batch_size=128,epochs=4,
        validation_data=(x_test,y_test))


# In[57]:

score = model.evaluate(x_test, y_test,
                        verbose=0)
print('Test score:', score[0])
print('Test accuracy:', score[1])


# In[58]:

predicted_classes = model.predict_classes(x_test)
correct_indices=np.nonzero(predicted_classes == y_test)[0]
incorrect_indices=np.nonzero(predicted_classes != y_test)[0]


# In[49]:

plt.figure()
for i, correct in enumerate(correct_indices[:9]):
    plt.subplot(3,3,i+1)
    plt.imshow(x_test[correct].reshape(28,28), cmap='gray', interpolation='none')
    plt.title("Predicted {}, Class {}".format(predicted_classes[correct], y_test[correct]))
    
plt.figure()
for i, incorrect in enumerate(incorrect_indices[:9]):
    plt.subplot(3,3,i+1)
    plt.imshow(x_test[incorrect].reshape(28,28), cmap='gray', interpolation='none')
    plt.title("Predicted {}, Class {}".format(predicted_classes[incorrect], y_test[incorrect]))


# In[ ]:



