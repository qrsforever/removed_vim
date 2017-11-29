#!/usr/bin/python3
# -*- coding: utf-8 -*-

# 在终端上输入
import jedi
jedi.Script('import numpy as np; np.array([1,2,3]).a').completions()
