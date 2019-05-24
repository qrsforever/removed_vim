#!/usr/bin/python3
# -*- coding: utf-8 -*-

# 在终端上输入
import jedi

# print(jedi.Script('import numpy as np; np.array([1,2,3]).a').completions())

# print(jedi.Script('from multiprocessing import Queue; Queue.').completions())

print(jedi.Script('import tensorflow as tf; tf.').completions())
