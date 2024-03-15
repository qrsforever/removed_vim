#!/usr/bin/env python2

import os
import datetime
import subprocess
from gi.repository import Gtk
import terminatorlib.plugin as plugin
from terminatorlib.translation import _

AVAILABLE = ['LogVim']

# /usr/share/terminator/terminatorlib/plugins


class LogVim(plugin.MenuItem):
    """ Add custom command to the terminal menu"""
    capabilities = ['terminal_menu']
    loggers = None

    def __init__(self):
        plugin.MenuItem.__init__(self)
        if not self.loggers:
            self.loggers = {}

    def callback(self, menuitems, menu, terminal):
        """ Add save menu item to the menu"""
        vte_terminal = terminal.get_vte()
        if vte_terminal not in self.loggers:
            item = Gtk.MenuItem.new_with_mnemonic(_('Start LogVim'))
            item.connect("activate", self.start_logger, terminal)
        else:
            item = Gtk.MenuItem.new_with_mnemonic(_('Stop LogVim'))
            item.connect("activate", self.stop_logger, terminal)
            item.set_has_tooltip(True)
            item.set_tooltip_text("Saving at '" + self.loggers[vte_terminal]["log_file"] + "'")
        menuitems.append(item)

    def write_content(self, terminal, row_start, col_start, row_end, col_end):
        """ Final function to write a file """
        content = terminal.get_text_range(row_start, col_start, row_end, col_end, lambda *a: True)
        content = content[0]
        fd = self.loggers[terminal]["fd"]
        # Don't write the last char which is always '\n'
        fd.write(content[:-1])
        self.loggers[terminal]["col"] = col_end
        self.loggers[terminal]["row"] = row_end

    def save(self, terminal):
        """ 'contents-changed' callback """
        last_saved_col = self.loggers[terminal]["col"]
        last_saved_row = self.loggers[terminal]["row"]
        (col, row) = terminal.get_cursor_position()
        # Save only when buffer is nearly full,
        # for the sake of efficiency
        if row - last_saved_row < terminal.get_row_count():
            return
        self.write_content(terminal, last_saved_row, last_saved_col, row, col)

    def start_logger(self, _widget, Terminal):
        """ Handle menu item callback by saving text to a file"""
        try:
            log_folder = '/logs'
            if not os.path.exists(log_folder):
                os.mkdir(log_folder)
            log_file = os.path.join(log_folder, "console_" + datetime.datetime.now().strftime('%Y-%m-%d_%H%M%S') + ".log")
            fd = open(log_file, 'w')
            vte_terminal = Terminal.get_vte()
            (col, row) = vte_terminal.get_cursor_position()

            self.loggers[vte_terminal] = {"log_file": log_file,
                                          "handler_id": 0, "fd": fd,
                                          "col": col, "row": row}
            # Add contents-changed callback
            self.loggers[vte_terminal]["handler_id"] = vte_terminal.connect('contents-changed', self.save)
        except Exception:
            pass

    def stop_logger(self, _widget, terminal):
        vte_terminal = terminal.get_vte()
        last_saved_col = self.loggers[vte_terminal]["col"]
        last_saved_row = self.loggers[vte_terminal]["row"]
        (col, row) = vte_terminal.get_cursor_position()
        if last_saved_col != col or last_saved_row != row:
            # Save unwritten bufer to the file
            self.write_content(vte_terminal, last_saved_row, last_saved_col, row, col)
        fd = self.loggers[vte_terminal]["fd"]
        fd.close()
        vte_terminal.disconnect(self.loggers[vte_terminal]["handler_id"])
        log_file = self.loggers[vte_terminal]["log_file"]
        del self.loggers[vte_terminal]

        try:
            subprocess.Popen('vim -g -c "set showtabline=0" %s' % log_file, shell=True)  # noqa
            return
        except Exception:
            pass
