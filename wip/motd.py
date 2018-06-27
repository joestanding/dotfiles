#!/usr/bin/env python3

# I'm not gonna fall into the trap of trying to make this
# perfect, super-modular or totally adherent to the rules
# of proper Python. It's hacky and will stay hacky :)

import subprocess
import sys
try:
    import psutil
except Exception as err:
    print("You need to install psutil!")
    sys.exit(1)
import os
from colorama import Fore, Back, Style

# =================================================================================== #
# Configuration                                                                       #
# =================================================================================== #

class Configuration:
    progress_bar_width = 50
    filesystems = [ '/dev/sda1' ]
    services = {
        'Apache' : 'apache2',
        'MySQL' : 'mysql',
        'SSH' : 'ssh',
        'Postgres': 'postgresql',
        'Nginx': 'nginx',
    }

# =================================================================================== #

class Maths:
    def percentile(a, b):
        return int(a * b / 100)

# =================================================================================== #

class Updates:
    def get_debian_updates():
        try:
            updates_available = subprocess.check_output('expr `apt list --upgradable 2>/dev/null | wc -l` - 1', shell=True).decode('utf-8')
        except Exception as err:
            updates_available = err.output.decode('utf-8')
        return updates_available.strip()

# =================================================================================== #

class Services:
    def __init__(self):
        pass

    def check_status(service):
        try:
            with open(os.devnull, 'w') as devnull:
                ctl_output = subprocess.check_output(['systemctl', 'status', service], stderr=devnull).decode('utf-8')
        except Exception as err:
            ctl_output = err.output.decode('utf-8')
        for line in ctl_output.strip().split('\n'):
            if 'Active: ' in line:
                if 'active (running)' in line or 'active (exited)' in line:
                    return 'active'
                if 'failed' in line:
                    return 'failed'
                if 'inactive' in line:
                    return 'inactive'
        return 'missing'

# =================================================================================== #

class UI:
    def friendly_bytes(size, precision=2):
        suffixes=['B','KB','MB','GB','TB']
        suffixIndex = 0
        while size > 1024 and suffixIndex < 4:
            suffixIndex += 1 #increment the index of the suffix
            size = size/1024.0 #apply the division
        return "%.*f%s"%(precision,size,suffixes[suffixIndex])

    def banner():
        print("")
        print("")
        print("")
        p(Fore.RED, " \
██████╗ ██╗   ██╗ ██████╗ ███████╗██████╗\n \
██╔══██╗██║   ██║██╔════╝ ██╔════╝██╔══██╗\n \
██████╔╝██║   ██║██║  ███╗█████╗  ██████╔╝\n \
██╔══██╗██║   ██║██║   ██║██╔══╝  ██╔══██╗\n \
██║  ██║╚██████╔╝╚██████╔╝███████╗██║  ██║\n \
╚═╝  ╚═╝ ╚═════╝  ╚═════╝ ╚══════╝╚═╝  ╚═╝\n \
                                          ")

    def progress_bar(width, percent, total, used, free):
        bar = '['
        coloured_bars = Maths.percentile(percent, width)
        for i in range(width):
            if i <= coloured_bars:
                # Determine colour
                x1 = i / width * 100
                if x1 <= 70:
                    block_colour = Fore.GREEN
                if x1 > 65 and x1 <= 85:
                    block_colour = Fore.YELLOW
                if x1 > 85:
                    block_colour = Fore.RED
                if i == coloured_bars:
                    bar += block_colour + '|' + Style.RESET_ALL
                else:
                    bar += block_colour + '=' + Style.RESET_ALL
            else:
                bar += Style.DIM + '=' + Style.RESET_ALL
        bar += '] ' + str(percent) + '%'

        print("    " + bar)
        print("     {label_total:<6}{value_total:>9}   " \
              "{label_used:<5}{value_used:>9}   " \
              "{label_free:<5}{value_free:>10}".format(label_total=UI.ct(Fore.BLUE, 'Total:'), 
                  value_total=total,
                  label_used=UI.ct(Fore.BLUE, 'Used:'),
                  value_used=used,
                  label_free=UI.ct(Fore.BLUE, 'Free:'),
                  value_free=free))


    def status(status):
        if status == "active":
            return Back.GREEN + Fore.BLACK + "  active  " + Style.RESET_ALL
        if status == "failed":
            return Back.RED + Fore.BLACK + "  failed  " + Style.RESET_ALL
        if status == "inactive":
            return Back.YELLOW + Style.DIM + Fore.BLACK + " inactive " + Style.RESET_ALL
        if status == "missing":
            return Back.WHITE + Style.DIM + Fore.BLACK + " missing? " + Style.RESET_ALL

    def load_average(load):
        avg = float(load)
        if avg <= 0.5:
            bg = Back.GREEN
        if avg > 0.5 and avg <= 0.75:
            bg = Back.YELLOW
        if avg > 0.75:
            bg = Back.RED
        return bg + Fore.BLACK + ("   {0:.2f}   ".format(avg)) + Style.RESET_ALL

    

    def ct(colour, text):
        return colour + text + Style.RESET_ALL


# =================================================================================== #

def p(colour, message):
    print(colour + message + Style.RESET_ALL)

def main():
    subprocess.call('clear')

    UI.banner()
    
    # ============================================================= #
    # Logged-in Users                                               #
    # ============================================================= #

    p(Fore.YELLOW, "Users:")
    for user in psutil.users():
        for process in psutil.process_iter():
            if process.pid == user.pid:
                process_name = process.name()
        print("  " + Fore.MAGENTA + user.name + Style.RESET_ALL + \
              Style.DIM + ' on ' + Style.NORMAL + user.terminal + \
              Style.DIM + ' via ' + Style.NORMAL + user.host + \
              Style.DIM + ' running ' + Style.NORMAL + process_name + \
              Style.RESET_ALL)
    print("")

    # ============================================================= #
    # CPU Load                                                      #
    # ============================================================= #

    p(Fore.YELLOW, "CPU:")
    avgs = os.getloadavg()
    print("           " + UI.load_average(avgs[0]) + "  " + UI.load_average(avgs[1]) + "  " + UI.load_average(avgs[2]))
    print("")

    # ============================================================= #
    # Memory                                                        #
    # ============================================================= #

    p(Fore.YELLOW, "Memory:")
    memory_stats = psutil.virtual_memory()
    UI.progress_bar(Configuration.progress_bar_width, int(memory_stats.percent),
                    UI.friendly_bytes(memory_stats.total),
                    UI.friendly_bytes(memory_stats.used),
                    UI.friendly_bytes(memory_stats.free))
    print("")

    # ============================================================= #
    # Storage Volumes                                               #
    # ============================================================= #

    p(Fore.YELLOW, "Storage:")
    for partition in psutil.disk_partitions():
        if partition.device in Configuration.filesystems:
            partition_stats = psutil.disk_usage(partition.mountpoint)
            print("  " + Fore.MAGENTA + partition.device + Style.RESET_ALL + Style.RESET_ALL)
            UI.progress_bar(Configuration.progress_bar_width, int(partition_stats.percent),
                    UI.friendly_bytes(partition_stats.total),
                    UI.friendly_bytes(partition_stats.used),
                    UI.friendly_bytes(partition_stats.free))
            print("")

    # ============================================================= #
    # System Services                                               #
    # ============================================================= #

    p(Fore.YELLOW, "Services:")
    right = False
    longest_service = 0
    for k, v in Configuration.services.items():
        if len(k) > longest_service:
            longest_service = len(k)
    for friendly_name, name in Configuration.services.items():
        line = "  {friendly_name:<{rename_me}}  {status:>12} ".format(rename_me=longest_service, friendly_name=friendly_name, status=UI.status(Services.check_status(name)))
        if not right:
            print(line, end="")
        else:
            print(line)
        right = not right
    print("")
    if right:
        print("")

    # ============================================================= #
    # System Updates                                                #
    # ============================================================= #

    p(Fore.YELLOW, "Updates:")
    print("  " + Fore.MAGENTA + Updates.get_debian_updates() + " packages" + Style.RESET_ALL + " have updates available")
    print("")
    print("")
    print("")


if __name__ == '__main__':
    main()


