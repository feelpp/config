#!/usr/bin/env python

import curses
from curses import panel, ascii
import os
import socket
import shutil

Settings=dict()

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

        # Set the default value to the previous HPCNAME
        buf = self.dct[self.key]
        while True:
            window.clear()
            #window.refresh()
            curses.doupdate()

            lpos = 1
            window.addstr(lpos, 1, "Please enter a new value for " + self.key, curses.A_NORMAL)
            lpos = lpos + 1
            window.addstr(lpos, 1, buf, curses.A_NORMAL)

            key = window.getch()

            if key in [curses.ascii.BS,curses.KEY_DC,curses.KEY_BACKSPACE]:
                buf = buf[:len(buf)-1]
            elif key in [curses.KEY_ENTER, ord('\n')]:
                break;
            elif curses.ascii.isalnum(key) or curses.ascii.ascii('/'):
                buf = buf + chr(key)

        window.clear()
        pnl.hide()
        panel.update_panels()
        curses.doupdate()

        if(buf != ""):
            self.dct[self.key] = buf

class Module(object):
    def __init__(self, rootPath, relativePath, state):
        self.rootPath = rootPath
        self.relativePath = relativePath
        self.state = state

        self.installPath = ""

        self.envName = self.buildEnvName()

    # build the name of the associated environment variable
    def buildEnvName(self):
        root, ext = os.path.splitext(os.path.basename(os.path.join(self.rootPath, self.relativePath)))
        self.envName = "FEELPP_" + root.upper().translate(None, ".-") + "_PATH"

    def getEnvName(self):
        self.buildEnvName()
        return self.envName

    def getState(self):
        return self.state

    def setState(self, state):
        self.state = state

    def setInstallPath(self, path):
        self.installPath = path

    def getRootPath(self):
        return self.rootPath

    def getRelativePath(self):
        return self.relativePath

    def getInstallPath(self):
        return self.installPath

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

        path = os.path.join(self.dct[self.key], "files", "src")
        self.buildModuleList(path, "", 0)

        path = os.path.join(self.dct[self.key], "files", Settings["FEELPP_HPCNAME"])
        # Check if we already activated some modules for this computer
        # before trying to build a module list
        if(os.path.exists(path)):
            self.updateModuleState(path, "")

    def getDescription(self):
        return self.desc + ": " + self.dct[self.key]

    def getFunction(self):
        return self.update

    def buildModuleList(self, root, currentDir, level):
        if(level == 0):
            self.moduleList = []

        subdirlist = []
        for item in os.listdir(os.path.join(root, currentDir)):
            if os.path.isfile(os.path.join(root, currentDir, item)):
                relpath = os.path.join(currentDir, item)
                i = 0
                while i < len(self.moduleList):
                    if(self.moduleList[i].getRelativePath() > relpath):
                        self.moduleList.insert(i, Module(root, relpath, False))
                        break
                    i = i + 1
                if(i == len(self.moduleList)):
                    self.moduleList.insert(i, Module(root, relpath, False))
            else:
                subdirlist.append(os.path.join(currentDir, item))

        for subdir in subdirlist:
            self.buildModuleList(root, subdir, 1)

    def updateModuleState(self, root, currentDir):

        subdirlist = []
        for item in os.listdir(os.path.join(root, currentDir)):
            if os.path.isfile(os.path.join(root, currentDir, item)):
                for m in self.moduleList:
                    if m.getRelativePath() == os.path.join(currentDir, item):
                        m.state = True
            else:
                subdirlist.append(os.path.join(currentDir, item))

        for subdir in subdirlist:
            self.updateModuleState(root, subdir)

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
        self.moduleList = []
        path = os.path.join(self.dct[self.key], "files", "src")
        self.buildModuleList(path, "", 0)

        path = os.path.join(self.dct[self.key], "files", Settings["FEELPP_HPCNAME"])
        # Check if we already activated some modules for this computer
        # before trying to build a module list
        if(os.path.exists(path)):
            self.updateModuleState(path, "")

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

                if(self.moduleList[index + self.windowStart].getState()):
                    msg = '\t%d. [*] %s %s' % (index + self.windowStart, self.moduleList[index + self.windowStart].getRelativePath(), self.moduleList[index + self.windowStart].getRootPath())
                else:
                    msg = '\t%d. [ ] %s %s' % (index + self.windowStart, self.moduleList[index + self.windowStart].getRelativePath(), self.moduleList[index + self.windowStart].getRootPath())
                self.window.addstr(lpos, 1, msg, mode)
                lpos = lpos + 1

            key = self.window.getch()

            if key in [curses.ascii.SP, ord('\n')]:
                if(self.moduleList[self.position + self.windowStart].getState()):
                    os.remove(os.path.join(self.dct[self.key], "files", Settings["FEELPP_HPCNAME"], self.moduleList[self.position + self.windowStart].getRelativePath()))
                    self.moduleList[self.position + self.windowStart].setState(False)
                else:
                    modpath=os.path.dirname(os.path.join(self.dct[self.key], "files", Settings["FEELPP_HPCNAME"], self.moduleList[self.position + self.windowStart].getRelativePath()))
                    if(not os.path.exists(modpath)):
                        os.makedirs(modpath)
                    modpath=os.path.join(self.dct[self.key], "files", Settings["FEELPP_HPCNAME"], self.moduleList[self.position + self.windowStart].getRelativePath())
                    if(not os.path.exists(modpath)):
                        os.symlink(
                        os.path.join(self.dct[self.key], "files", "src", self.moduleList[self.position + self.windowStart].getRelativePath()),
                        os.path.join(modpath)
                        )
                    self.moduleList[self.position + self.windowStart].setState(True)

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

        writeActiveModuleList(self.moduleList)

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


# Parse a file with the following format:
# entry=value
# ...
# and put its content in a dictionary
def parseConfigFile(filename, outDict):

    # Open the filename
    f = open(filename, "r")
    lines = f.readlines()
    for line in lines:
        # if line start with a #, it is a comment
        if(not line.lstrip().startswith("#")):
            # clean up the line
            tl = line.lstrip().translate(None, "\n")
            # if the line is not empty, split it
            if(tl != ""):
                spl = tl.split("=")
                outDict[spl[0]] = spl[1]
    f.close()

def writeActiveModuleList(moduleList):

    log = open("log", "w")

    modfile=os.path.join(Settings["FEELPP_CONFIG_PATH"], "etc", "feelpprc.d", Settings["FEELPP_HPCNAME"] + ".sh")
    log.write(modfile)

    prevModules = dict()
    if(os.path.exists(modfile)):
        parseConfigFile(modfile, prevModules)
    log.write("PREVMODULES=" + str(prevModules) + "\n\n")

    modfile=os.path.join(Settings["FEELPP_CONFIG_PATH"], "etc", "feelpprc.d", Settings["FEELPP_HPCNAME"] + ".sh")
    f = open(modfile, "w")

    for m in moduleList:
        # if the current module was previously in the file
        if(m.getEnvName() in prevModules):
            # and if it is still active
            # we keep the previous configuration
            if(m.getState()):
                f.write(m.getEnvName() + "=" + prevModules[m.getEnvName()] + "\n")
                log.write("Keeping old configuration for " + m.getEnvName() + "\n")
            # otherwise the module is silently deleted from the file
            else:
                log.write("Deleting previous entry for " + m.getEnvName() + "\n")
        # if the module was not previously active
        else:
            # and it is now active, then we set it up in the file
            if(m.getState()):
                f.write(m.getEnvName() + "=" + Settings["FEELPP_SHARE_PATH"] + "\n")
                log.write("using new configuration for " + m.getEnvName() + "\n")

class MyApp(object):

    def __init__(self, stdscreen):
        self.screen = stdscreen
        curses.curs_set(0)

        # Menu for setting name of the cluster and path to installed applications
        hpcMenuItems = [
        MenuItemUpdateDictEntry("Cluster name", Settings, "FEELPP_HPCNAME", self.screen),
        MenuItemUpdateDictEntry("Path to installed software", Settings, "FEELPP_SHARE_PATH", self.screen),
        ]
        hpcMenu = Menu("HPC Name", hpcMenuItems, self.screen)

        # Main menu
        mainMenuItems = [
        # Cluster info submenu
        MenuItem('HPC Name', hpcMenu.display),
        # Configure list of module used
        MenuItemModuleList("List of Modules", Settings, "FEELPP_MODULE_PATH", self.screen),
        ]
        mainMenu = Menu("Module configuration", mainMenuItems, self.screen)
        mainMenu.display()

if __name__ == '__main__':
    # read back previous module configuration
    # if the file exists
    prevConfFile = os.path.join(os.path.dirname(os.path.realpath(__file__)), "etc", "environment")
    if(os.path.exists(prevConfFile)):
        parseConfigFile(prevConfFile, Settings)

    # Check if we have at least several mandatory variables from the environment file
    # otherwise we add them
    if(not("FEELPP_HPCNAME" in Settings)):
        Settings["FEELPP_HPCNAME"] = socket.gethostname()
    if(not("FEELPP_CONFIG_PATH" in Settings)):
        Settings["FEELPP_CONFIG_PATH"] = os.path.dirname(os.path.realpath(__file__))
    if(not("FEELPP_MODULE_PATH" in Settings)):
        Settings["FEELPP_MODULE_PATH"] = Settings["FEELPP_CONFIG_PATH"] + "/modules"
    if(not("FEELPP_SHARE_PATH" in Settings)):
        Settings["FEELPP_SHARE_PATH"] = "/usr/local/feelpp"

    # Launch the curses interface
    curses.wrapper(MyApp)

    # Set the module path after having using the app
    # To ensure that we get the correct HPCNAME
    Settings["MODULEPATH"] = os.path.join(Settings["FEELPP_MODULE_PATH"], "files", Settings["FEELPP_HPCNAME"]) + ":$MODULEPATH"
    path = os.path.join(Settings["FEELPP_MODULE_PATH"], "profiles", Settings["FEELPP_HPCNAME"])
    if(os.path.exists(path)):
        Settings["MODULEPATH"] = path + ":" + Settings["MODULEPATH"]

    # output configuration into etc/environment
    f = open(os.path.join(Settings["FEELPP_CONFIG_PATH"], "etc", "environment"), "w")

    for k, v in iter(Settings.items()):
        f.write(k + "=" + v + "\n")
    f.close()

