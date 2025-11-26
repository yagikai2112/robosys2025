import random

keys = [
    "dog",
    "apple",
    "moon",
    "secret",
    "penguin",
    "soccer",
    "music",
    "river",
    "storm",
    "candle"
]

def get_random_key():
    index = random.randint(0, len(keys) - 1)
    return index, keys[index]
