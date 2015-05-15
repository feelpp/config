#!/usr/bin/env python

import curses
from curses import panel
import os
import socket

Settings=dict(
FEELPP_HPCNAME="",
FEELPP_CONFIG_PATH="",
FEELPP_MODULE_PATH="",
FEELPP_SHARE_PATH=""
)

class MenuItem(object):
    def __init__(self, description, function):
        self.description = description
        self.function = function

    def getDescription(self):
        return self.description

    def getFunction(self):
        return self.function

class DialogYesNo(object):
    def ask(self, question, screen):
        window = screen.subwin(0,0)
        window.keypad(1)
        pnl = panel.new_panel(window)
        pnl.hide()
        panel.update_panels()

        position = 0
        pnl.top()
        pnl.show()
        window.clear()

        bVal = False
        while True:
            window.clear()
            #window.refresh()
            curses.doupdate()

            lpos = 1
            window.addstr(lpos, 1, question, curses.A_NORMAL)
            lpos = lpos + 1
            if(bVal):
                window.addstr(lpos, 1, "YES", curses.A_REVERSE)
                window.addstr(lpos, 10, "NO", curses.A_NORMAL)
            else:
                window.addstr(lpos, 1, "YES", curses.A_NORMAL)
                window.addstr(lpos, 10, "NO", curses.A_REVERSE)

            key = window.getch()

            if key in [curses.KEY_LEFT, curses.KEY_UP]:
                bVal = True
            elif key in [curses.KEY_RIGHT, curses.KEY_DOWN]:
                bVal = False
            elif key in [curses.KEY_ENTER, ord('\n')]:
                window.clear()
                pnl.hide()
                panel.update_panels()
                curses.doupdate()
                return bVal;


class MenuItemUpdateDictEntry(object):
    def __init__(self, desc, dct, key, stdscreen):
        self.desc = desc
        self.dct = dct
        self.key = key
        self.stdscreen = stdscreen

    def getDescription(self):
        return self.desc + ": " + self.dct[self.key]

    def getFunction(self):
        return self.update

    def update(self):
        window = self.stdscreen.subwin(0,0)
        window.keypad(1)
        pnl = panel.new_panel(window)
        pnl.hide()
        panel.update_panels()

        position = 0
        pnl.top()
        pnl.show()
        window.clear()

        buf = ""
        while True:
            window.clear()
            #window.refresh()
            curses.doupdate()

            lpos = 1
            window.addstr(lpos, 1, "Please enter a new value for " + self.key, curses.A_NORMAL)
            lpos = lpos + 1
            window.addstr(lpos, 1, buf, curses.A_NORMAL)

            key = window.getch()

            if key in [curses.KEY_BACKSPACE]:
                buf = buf[:len(buf)-1]
            elif key in [curses.KEY_ENTER, ord('\n')]:
                break;
            else:
                buf = buf + chr(key)

        window.clear()
        pnl.hide()
        panel.update_panels()
        curses.doupdate()

        if(buf != ""):
            self.dct[self.key] = buf

class MenuItemModuleList(object):
    def __init__(self, desc, dct, key, stdscreen):
        self.desc = desc
        self.dct = dct
        self.key = key
        self.stdscreen = stdscreen

        self.window = stdscreen.subwin(0,0)
        self.window.keypad(1)
        self.panel = panel.new_panel(self.window)
        self.panel.hide()
        panel.update_panels()

        self.windowStart = 0
        self.windowSize = 0
        self.position = 0

        self.moduleList = []
        self.activeModuleList = []

        self.buildModuleList(os.path.join(self.dct[self.key], "files", "src"), 0)
        self.buildActiveModuleList(os.path.join(self.dct[self.key], "files", Settings["FEELPP_HPCNAME"]), 0)

        # Remove base working directory form module name
        for i in range(len(self.moduleList)):
            self.moduleList[i] = self.moduleList[i].replace(os.path.join(self.dct[self.key], "files", "src") + "/", "")
        for i in range(len(self.activeModuleList)):
            self.activeModuleList[i] = self.activeModuleList[i].replace(os.path.join(self.dct[self.key], "files", Settings["FEELPP_HPCNAME"]) + "/", "")

    def getDescription(self):
        return self.desc + ": " + self.dct[self.key]

    def getFunction(self):
        return self.update

    """
    def buildModuleList(self):
        print self.dct[self.key]
        for root, dirs, files in os.walk(self.dct[self.key]):
            print root, dirs, files
    """

    def buildModuleList(self, root, level):
        if(level == 0):
            self.moduleList = []

        basedir = root
        #print("Files in ", os.path.abspath(root), ": ")
        subdirlist = []
        for item in os.listdir(root):
            if os.path.isfile(os.path.join(basedir, item)):
                self.moduleList.append(os.path.join(basedir, item))
            else:
                subdirlist.append(os.path.join(basedir, item))

        for subdir in subdirlist:
            self.buildModuleList(subdir, 1)

    def buildActiveModuleList(self, root, level):
        if(level == 0):
            self.activeModuleList = []

        basedir = root
        #print("Files in ", os.path.abspath(root), ": ")
        subdirlist = []
        for item in os.listdir(root):
            if os.path.isfile(os.path.join(basedir, item)):
                self.activeModuleList.append(os.path.join(basedir, item))
            else:
                subdirlist.append(os.path.join(basedir, item))

        for subdir in subdirlist:
            self.buildActiveModuleList(subdir, 1)

    def navigate(self, n):
        self.position += n
        if self.position < 0:
            self.position = 0
            self.windowStart = max(self.windowStart - 1, 0)
        if self.position >= min((len(self.moduleList) - 1), curses.LINES - 5):
            self.position = min(len(self.moduleList)-1, curses.LINES-5)
            self.windowStart = self.windowStart + 1
        if self.windowStart >= (len(self.moduleList) - 1 - (curses.LINES - 5)):
            self.windowStart = min(self.windowStart + 1, len(self.moduleList)-(curses.LINES - 5) - 1)
        #if self.position < 0:
        #    self.position = 0
        #elif self.position >= len(self.moduleList):
        #    self.position = len(self.moduleList)-1

    def update(self):
        self.buildModuleList(os.path.join(self.dct[self.key], "files", "src"), 0)
        self.buildActiveModuleList(os.path.join(self.dct[self.key], "files", Settings["FEELPP_HPCNAME"]), 0)

        # Remove base working directory form module name
        for i in range(len(self.moduleList)):
            self.moduleList[i] = self.moduleList[i].replace(os.path.join(self.dct[self.key], "files", "src") + "/", "")
        for i in range(len(self.activeModuleList)):
            self.activeModuleList[i] = self.activeModuleList[i].replace(os.path.join(self.dct[self.key], "files", Settings["FEELPP_HPCNAME"]) + "/", "")

        self.panel.top()
        self.panel.show()
        self.window.clear()

        while True:
            self.window.clear()
            #self.window.refresh()
            curses.doupdate()

            lpos = 1
            self.window.addstr(lpos, 1, "Module list (Enter to select, Esc to validate changes and quit this menu)", curses.A_NORMAL)
            lpos = lpos + 1

            for index in range(min(len(self.moduleList), (curses.LINES - 5) + 1)):#len(self.moduleList)):
                if index == self.position:
                    mode = curses.A_REVERSE
                else:
                    mode = curses.A_NORMAL

                if(self.moduleList[index + self.windowStart] in self.activeModuleList):
                    msg = '\t%d. [*] %s' % (index + self.windowStart, self.moduleList[index + self.windowStart])
                else:
                    msg = '\t%d. [ ] %s' % (index + self.windowStart, self.moduleList[index + self.windowStart])
                self.window.addstr(lpos, 1, msg, mode)
                lpos = lpos + 1

            key = self.window.getch()

            if key in [curses.KEY_ENTER, ord('\n')]:
                #print(os.path.join(self.dct[self.key], "files", Settings["FEELPP_HPCNAME"], self.moduleList[self.position + self.windowStart]))
                if(self.moduleList[self.position + self.windowStart] in self.activeModuleList):
                    os.remove(os.path.join(self.dct[self.key], "files", Settings["FEELPP_HPCNAME"], self.moduleList[self.position + self.windowStart]))
                    self.activeModuleList.remove(self.moduleList[self.position + self.windowStart])
                else:
                    modpath=os.path.dirname(os.path.join(self.dct[self.key], "files", Settings["FEELPP_HPCNAME"], self.moduleList[self.position + self.windowStart]))
                    if(not os.path.exists(modpath)):
                        os.makedirs(modpath)
                    os.symlink(
                    os.path.join(self.dct[self.key], "files", "src", self.moduleList[self.position + self.windowStart]),
                    os.path.join(self.dct[self.key], "files", Settings["FEELPP_HPCNAME"], self.moduleList[self.position + self.windowStart])
                    )
                    self.activeModuleList.append(self.moduleList[self.position + self.windowStart])

            # When the user press escape, leave the loop
            elif key == 27:
                break
            elif key == curses.KEY_UP:
                self.navigate(-1)

            elif key == curses.KEY_DOWN:
                self.navigate(1)

        self.window.clear()
        self.panel.hide()
        panel.update_panels()
        curses.doupdate()

class Menu(object):

    def __init__(self, title, items, stdscreen):
        self.window = stdscreen.subwin(0,0)
        self.window.keypad(1)
        self.panel = panel.new_panel(self.window)
        self.panel.hide()
        panel.update_panels()

        self.position = 0
        self.title = title
        self.items = items
        self.items.append(MenuItem('Exit','Exit'))

    def navigate(self, n):
        self.position += n
        if self.position < 0:
            self.position = 0
        elif self.position >= len(self.items):
            self.position = len(self.items)-1

    def display(self):
        self.panel.top()
        self.panel.show()
        self.window.clear()

        while True:
            self.window.refresh()
            curses.doupdate()

            lpos = 1
            self.window.addstr(lpos, 1, self.title, curses.A_NORMAL)
            lpos = lpos + 1

            for index in range(len(self.items)):
                if index == self.position:
                    mode = curses.A_REVERSE
                else:
                    mode = curses.A_NORMAL

                msg = '\t%d. %s' % (index, self.items[index].getDescription())
                self.window.addstr(lpos, 1, msg, mode)
                lpos = lpos + 1

            key = self.window.getch()

            if key in [curses.KEY_ENTER, ord('\n')]:
                if self.position == len(self.items)-1:
                    break
                else:
                    self.items[self.position].getFunction()()

            elif key == curses.KEY_UP:
                self.navigate(-1)

            elif key == curses.KEY_DOWN:
                self.navigate(1)

        self.window.clear()
        self.panel.hide()
        panel.update_panels()
        curses.doupdate()

def writeActiveModuleList(activeModuleList):

    log = open("log", "w")

    modfile=os.path.join(Settings["FEELPP_CONFIG_PATH"], "etc", "feelpprc.d", Settings["FEELPP_HPCNAME"] + ".sh")

    # open and close the file
    # in case it doesn't exist
    f = open(modfile, "a")
    f.close()

    f = open(modfile, "r")
    lines = f.readlines()
    log.write(str(lines))
    log.write("\n\n")

    content = []
    for l in lines:
        if(not l.lstrip().startswith("#") and l.lstrip().translate(None, "\n") != ""):
            content.append(l.lstrip().translate(None, "\n"))
    log.write(str(content))
    log.write("\n\n")

    log.write(str(activeModuleList))
    log.write("\n\n")

    for m in activeModuleList:
        root, ext = os.path.splitext(os.path.basename(m))
        log.write("FEELPP_" + root.upper().translate(None, ".-") + "_PATH=" + Settings["FEELPP_SHARE_PATH"] + "\n")

class MyApp(object):

    def __init__(self, stdscreen):
        self.screen = stdscreen
        curses.curs_set(0)

        #d = DialogYesNo()
        #d.ask("Test", stdscreen)

        hpcMenuItems = [
        MenuItemUpdateDictEntry("Cluster name", Settings, "FEELPP_HPCNAME", self.screen),
        MenuItemUpdateDictEntry("Path to installed software", Settings, "FEELPP_SHARE_PATH", self.screen),
        ]
        hpcMenu = Menu("HPC Name", hpcMenuItems, self.screen)

        mainMenuItems = [
        MenuItem('HPC Name', hpcMenu.display),
        MenuItemModuleList("List of Modules", Settings, "FEELPP_MODULE_PATH", self.screen),
        ]
        mainMenu = Menu("Module configuration", mainMenuItems, self.screen)
        mainMenu.display()

        writeActiveModuleList(mainMenuItems[1].activeModuleList)

if __name__ == '__main__':
    Settings["FEELPP_HPCNAME"] = socket.gethostname()
    Settings["FEELPP_CONFIG_PATH"] = os.path.dirname(os.path.realpath(__file__))
    Settings["FEELPP_MODULE_PATH"] = Settings["FEELPP_CONFIG_PATH"] + "/modules"
    Settings["FEELPP_SHARE_PATH"] = "/usr/local/feelpp"

    curses.wrapper(MyApp)

    f = open(os.path.join(Settings["FEELPP_CONFIG_PATH"], "etc", "environment"), "w")

    for k, v in iter(Settings.items()):
        f.write(k + "=" + v + "\n")
    f.close()

