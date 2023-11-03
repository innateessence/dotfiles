#!/usr/bin/env python

"""
MacOS Sonoma fails to kill Apples "LegacyScreenSaver (wallpaper)" program
which can idle at as high as 40% usage while it's running and doing literally nothing.

The program should be killed on my system whenever the lock screen is unlocked.

For now, I'll poll the process time, and it's been alive for too long I'll simply kill the process.
"""

# NOTE: Prefer the shell script version instead.

import sys
import psutil
from psutil import Process
from datetime import datetime, timedelta


class LegacyScreenSaverKiller:
    @property
    def proc(self) -> Process | None:
        for proc in psutil.process_iter():
            if "legacyscreensaver" in proc.name().lower():
                return proc
        return None

    @property
    def is_dead(self) -> bool:
        if proc := self.proc:
            return not proc.is_running()
        return False

    def kill(self) -> bool:
        proc = self.proc
        if proc:
            proc.kill()
            return not self.is_dead
        return False

    def should_die(self, minutes: int) -> bool:
        """checks if the process has been alive for more than {minutes} minutes"""
        proc = self.proc
        if proc:
            proc.cpu_times()
            start_time = datetime.fromtimestamp(proc.create_time())
            now = datetime.now()
            target_time = now - timedelta(minutes=minutes)
            if start_time < target_time:
                return True
        return False

    def die_if_needed(self, minutes: int) -> bool:
        if self.should_die(minutes):
            return self.kill()
        return False


if __name__ == "__main__":
    if len(sys.argv) > 1:
        minutes = int(sys.argv[1])
    else:
        minutes = 20
    killer = LegacyScreenSaverKiller()
    killer.die_if_needed(minutes)
