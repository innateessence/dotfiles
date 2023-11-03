#!/usr/bin/env python3

import sys


def strip_eol(lines):
    for i in range(len(lines) - 1, -1, -1):
        if lines[i] == '\n':
            del lines[i]
        else:
            break
    return "".join(lines)


def Main():
    lines = sys.stdin.readlines()
    lines = strip_eol(lines)
    print(lines, end="")


if __name__ == "__main__":
    Main()
