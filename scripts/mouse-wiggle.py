#!/usr/bin/env python3

import os
import sys
import time
import pyautogui
import random
from datetime import datetime, timedelta

from argparse import ArgumentParser

# Keep my MacBook awake. Was faster to write this than to find a solution that keeps the network connection alive.
# In hindsight, caffeinate would have been a good solution. But this was fun.


def parse_args():
    parser = ArgumentParser(description="Wiggle the mouse")
    parser.add_argument(
        "_until",
        nargs="?",
        help="when no flag is provided, we're passing args as args to --until",
        default=None,
    )
    parser.add_argument(
        "--until",
        type=str,
        help="Stop after this time has passed. Format: 1s, 1m, 1h, 1d, 1w",
        default=None,
    )
    parser.add_argument(
        "--duration",
        type=float,
        default=0.1,
        help="Duration for the mouse wiggle in seconds",
    )
    parser.add_argument(
        "--delay", type=float, default=30, help="Delay in between mouse wiggles"
    )
    parser.add_argument("--debug", action="store_true", help="Print debug messages")
    parser.add_argument(
        "--offset", type=int, default=1, help="Max offset for mouse wiggle in pixels"
    )
    args = parser.parse_args()
    if args._until:
        args.until = args._until
    return args


def parse_until_time(until) -> datetime:
    time_map = {
        "s": "seconds",
        "m": "minutes",
        "h": "hours",
        "d": "days",
        "w": "weeks",
    }

    if until is None:
        return datetime(year=9999, month=12, day=31, hour=23, minute=59, second=59)
    time_unit = until[-1]
    if time_unit not in time_map:
        raise ValueError("Invalid time unit")
    time_unit = time_map[time_unit]
    time_value = int(until[:-1])
    delta = timedelta(**{time_unit: time_value})
    until_time = datetime.now() + delta
    return until_time


def wiggle(args) -> None:
    min = args.offset * -1
    max = args.offset
    offset_x = random.randint(min, max)
    offset_y = random.randint(min, max)
    while offset_x == 0:
        offset_x = random.randint(min, max)
    while offset_y == 0:
        offset_y = random.randint(min, max)
    offset_x = 1
    offset_y = 1
    if args.debug:
        print("offset_x: ", offset_x, end="")
        print(" offset_y: ", offset_y, end="")
        print(" duration: ", args.duration, end="")
        print(" delay: ", args.delay, end="")
        print(" until: ", args.until)
    pyautogui.moveRel(offset_x, offset_y, duration=args.duration)


def sleep_loop(sleep_time, until_time) -> None:
    while sleep_time > 0:
        time.sleep(1)
        sleep_time -= 1
        if datetime.now() > until_time:
            exit(0)


if __name__ == "__main__":
    pyautogui.FAILSAFE = False
    args = parse_args()
    until_time = parse_until_time(args.until)
    while datetime.now() < until_time:
        wiggle(args)
        sleep_loop(args.delay, until_time)
