#!/usr/bin/python3
# SPDX-FileCopyrightText: 2025 Kaito Yagiuchi
# SPDX-License-Identifier: BSD-3-Clause


import sys
sys.dont_write_bytecode = True
import random


keys = [
    "robot",
    "soccer",
    "iron",
    "computer",
    "electricity",
    "power",
    "music",
    "camera",
    "sensor",
    "paper"
]

def get_key(index=None):
    if index is None:
        index = random.randint(0, len(keys) - 1)
    return index, keys[index]
