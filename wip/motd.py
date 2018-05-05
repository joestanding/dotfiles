#!/usr/bin/env python3

import subprocess
import psutil
import os
from colorama import Fore, Back, Style

# =================================================================================== #

class Maths:
    def percentile(a, b):
        return int(a * b / 100)

# =================================================================================== #

class Memory:
    def __init__(self):
        self.data = psutil.virtual_memory()

    def get_free(self):
        return self.data.free

    def get_used_percentage(self):
        return int(self.data.percent)

# =================================================================================== #

class Updates:
    def get_updates():
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
            ctl_output = subprocess.check_output(['systemctl', 'status', service]).decode('utf-8')
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

class Storage:
    def __init__(self):
        self.data = {}
        self.df_output = subprocess.check_output(['df', '-h']).decode('utf-8')
        for index, line in enumerate(self.df_output.strip().split('\n')):
            if index is not 0:
                tokens = line.strip().split()
                self.data[tokens[0]] = {}
                self.data[tokens[0]]['size'] = tokens[1]
                self.data[tokens[0]]['used'] = tokens[2]
                self.data[tokens[0]]['available'] = tokens[3]
                self.data[tokens[0]]['use_percentage'] = tokens[4].replace('%', '')
                self.data[tokens[0]]['mounted'] = tokens[5]

    def get_filesystem(self, filesystem):
        return self.data[filesystem]

# =================================================================================== #

class Users:
    def __init__(self):
        self.data = []
        self.w_output = subprocess.check_output(['w', '-i']).decode('utf-8')
        for index, line in enumerate(self.w_output.strip().split('\n')):
            if index > 1:
                tokens = line.strip().split()
                user = {}
                user['name'] = tokens[0]
                user['tty'] = tokens[1]
                user['from'] = tokens[2]
                self.data.append(user)

    def get_users(self):
        return self.data

# =================================================================================== #

class UI:
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

    def progress_bar(width, percent):
        bar = '['
        coloured_bars = Maths.percentile(percent, width)
        for i in range(width):
            if i <= coloured_bars:
                if i == coloured_bars:
                    bar += Fore.GREEN + '|' + Style.RESET_ALL
                else:
                    bar += Fore.GREEN + '=' + Style.RESET_ALL
            else:
                bar += '='
        bar += '] ' + str(percent) + '%'
        return bar

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
    storage = Storage()
    users = Users()
    memory = Memory()

    # ============================================================= #
    # Configuration                                                 #
    # ============================================================= #
    bar_width = 50
    services = {
        'Apache' : 'apache2',
        'MySQL' : 'mysql',
        'SSH' : 'ssh',
        'Postgres': 'postgresql'
    }
    filesystems = [ '/dev/sda1' ]
   
    UI.banner()
    
    # ============================================================= #
    # Logged-in Users                                               #
    # ============================================================= #
    p(Fore.YELLOW, "Users:")
    for user in users.get_users():
        print("  " + Fore.MAGENTA + user['name'] + Style.RESET_ALL + \
              Style.DIM + " on " + Style.NORMAL + user['tty'] + \
              Style.DIM + ' via ' + Style.NORMAL + user['from'] + \
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
    print("    " + UI.progress_bar(bar_width, memory.get_used_percentage()))
    print("     {label_total:<10}   {value_total:>6}   " \
          "{label_used:<10}   {value_used:>6}   " \
          "{label_free:<10}   {value_free:>7}".format(label_total=UI.ct(Fore.BLUE, 'Total:'), 
              value_total='16GB',
              label_used=UI.ct(Fore.BLUE, 'Used:'),
              value_used='6.4GB',
              label_free=UI.ct(Fore.BLUE, 'Free:'),
              value_free='2.3GB'))
    print("")
    # ============================================================= #
    # Storage Volumes                                               #
    # ============================================================= #
    p(Fore.YELLOW, "Storage:")
    sda1 = storage.get_filesystem('/dev/sda1')
    print("  " + Fore.MAGENTA + "/dev/sda1 " + Style.RESET_ALL + \
          Style.DIM + sda1['available'] + ' left of ' + sda1['size'] + \
          Style.RESET_ALL)
    print("    " + UI.progress_bar(bar_width, int(sda1['use_percentage'])))
    print("     {label_total:<10}   {value_total:>6}   " \
          "{label_used:<10}   {value_used:>6}   " \
          "{label_free:<10}   {value_free:>7}".format(label_total=UI.ct(Fore.BLUE, 'Total:'), 
              value_total=sda1['size'],
              label_used=UI.ct(Fore.BLUE, 'Used:'),
              value_used=sda1['used'],
              label_free=UI.ct(Fore.BLUE, 'Free:'),
              value_free=sda1['available']))

    print("")

    # ============================================================= #
    # System Services                                               #
    # ============================================================= #
    p(Fore.YELLOW, "Services:")
    right = False

    longest_service = 0
    for k, v in services.items():
        if len(k) > longest_service:
            longest_service = len(k)

    for friendly_name, name in services.items():
        line = "  {friendly_name:<{rename_me}}  {status:>12} ".format(rename_me=longest_service, friendly_name=friendly_name, status=UI.status(Services.check_status(name)))
        if not right:
            print(line, end="")
        else:
            print(line)
        right = not right
    print("")
    # ============================================================= #
    # System Updates                                                #
    # ============================================================= #
    p(Fore.YELLOW, "Updates:")
    print("  " + Fore.MAGENTA + Updates.get_updates() + " packages" + Style.RESET_ALL + " have updates available")
    print("")
    print("")
    print("")


if __name__ == '__main__':
    main()


