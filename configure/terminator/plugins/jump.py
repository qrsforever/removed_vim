import re
import os
import datetime
import terminatorlib.plugin as plugin
from terminatorlib.translation import _
from terminatorlib.terminator import Terminator
import subprocess

from gi.repository import Gtk, Gdk

# AVAILABLE must contain a list of all the classes that you want exposed
AVAILABLE = ['JumpAndSave']
MAX_JUMPS = 20
DEBUG = 0


class JumpAndSave(plugin.MenuItem):
    capabilities = ['terminal_menu']
    last_cursor_pos = 0
    jumps_pos_list = []
    start_pos = 0
    run_clear = False

    def __init__(self):
        plugin.MenuItem.__init__(self)
        self.vte = None
        self.entry = Terminator().windows[0]
        self.entry.connect('key-release-event', self.onKeyRelease)
        self.entry.connect('key-press-event', self.onKeyPress)

    def callback(self, menuitems, menu, terminal):
        item_up = Gtk.MenuItem(_('JumpUp(Super+,)'))
        item_up.connect("activate", self.jumpUp)
        menuitems.append(item_up)
        item_down = Gtk.MenuItem(_('JumpDown(Super+.)'))
        item_down.connect("activate", self.jumpDown)
        menuitems.append(item_down)
        item_save = Gtk.MenuItem(_('JumpSave(Super+/)'))
        item_save.connect("activate", self.jumpSave)
        menuitems.append(item_save)

    def jumpUp(self, widget):
        # self.last_cursor_pos = max(0, self.last_cursor_pos - 1)
        self.last_cursor_pos -= 1
        if self.last_cursor_pos < 0:
            self.last_cursor_pos = len(self.jumps_pos_list) - 1
        t = Terminator().last_focused_term
        if DEBUG:
            print('up', 'list length:', len(self.jumps_pos_list))
            print('up', 'last cursor:', self.last_cursor_pos)
            print('up', self.jumps_pos_list[self.last_cursor_pos])
        if self.last_cursor_pos < len(self.jumps_pos_list):
            t.scrollbar_jump(self.jumps_pos_list[self.last_cursor_pos] - self.start_pos)

    def jumpDown(self, widget):
        # self.last_cursor_pos = min(len(self.jumps_pos_list) - 1, self.last_cursor_pos + 1)
        self.last_cursor_pos += 1
        if self.last_cursor_pos >= len(self.jumps_pos_list):
            self.last_cursor_pos = 0
        t = Terminator().last_focused_term
        if DEBUG:
            print('down', 'list length:', len(self.jumps_pos_list))
            print('down', 'last cursor:', self.last_cursor_pos)
            print('down', self.jumps_pos_list[self.last_cursor_pos])
        if self.last_cursor_pos < len(self.jumps_pos_list):
            t.scrollbar_jump(self.jumps_pos_list[self.last_cursor_pos] - self.start_pos)

    def jumpSave(self, widget):
        """ Handle menu item callback by saving console text to a predefined location and creating the ~/.terminator folder if necessary """
        try:
            log_folder = os.path.join(os.path.expanduser("~"), ".terminator")
            if not os.path.exists(log_folder):
                os.mkdir(log_folder)
            log_file = "console_" + datetime.datetime.now().strftime('%Y-%m-%d_%H%M%S') + ".log"
            t = Terminator().last_focused_term
            if DEBUG:
                print('save', len(self.jumps_pos_list), self.last_cursor_pos)
            if self.last_cursor_pos >= len(self.jumps_pos_list) or self.last_cursor_pos <= 0:
                start_row = self.jumps_pos_list[0]
            else:
                start_row = self.jumps_pos_list[self.last_cursor_pos]
            last_col, last_row = t.get_vte().get_cursor_position()
            if DEBUG:
                print('save from ', start_row, ' to ', last_row)
            content = t.get_vte().get_text_range(start_row, 0, last_row, last_col, lambda *a: True)
            if content:
                log_path = os.path.join(log_folder, log_file)
                fd = open(log_path, 'w+')
                fd.write(content[0])
                fd.flush()
                fd.close()
                try:
                    subprocess.Popen('notify-send -a notify -t 100 saved %s' % log_path, shell=True)  # noqa
                except Exception:
                    pass
        except Exception as e:
            print(e)

    def onKeyRelease(self, widget, event):
        # Gdk.keyval_name(74): 'J'  106: 'j'
        # Gdk.KEY_J(74) Gdk.KEY_j(106)
        # Gdk.KEY_period: '.' Gdk.KEY_comma: ','
        # MOD1_MASK: alt, MOD4_MASK: super
        if DEBUG:
            print(event.state, event.keyval)
        # mask = Gdk.ModifierType.MOD1_MASK
        # mask = Gdk.ModifierType.CONTROL_MASK
        mask = Gdk.ModifierType.MOD4_MASK
        if (event.state & mask == mask):
            if event.keyval == Gdk.KEY_period:
                self.jumpDown(widget)
            elif event.keyval == Gdk.KEY_comma:
                self.jumpUp(widget)
            elif event.keyval == Gdk.KEY_slash:
                self.jumpSave(widget)
            return

        mask = Gdk.ModifierType.CONTROL_MASK
        if (event.state & mask == mask):
            if event.keyval == Gdk.KEY_L or event.keyval == Gdk.KEY_l:
                self.jumps_pos_list.clear()
                self.run_clear = True
            return

    def onKeyPress(self, widget, event):
        if event.keyval == Gdk.KEY_Return:  # "65293"
            t = Terminator().last_focused_term
            col, row = t.get_vte().get_cursor_position()
            content = t.get_vte().get_text_range(row-3, 0, row, col, lambda *a: True)[0].split("\n")
            if DEBUG:
                print(content, row)
            if re.match(r"\w+@\w+", content[-1].split(":")[0]) and not content[-1].endswith("$ "):
                cmd = content[-1].split('$ ')[1]
                if 'clear' in cmd:
                    self.jumps_pos_list.clear()
                    self.run_clear = True
                    return
                if self.run_clear:
                    self.start_pos = row
                    self.run_clear = False
                if len(self.jumps_pos_list) == MAX_JUMPS:
                    self.jumps_pos_list.pop(0)
                self.jumps_pos_list.append(row)
                self.last_cursor_pos = len(self.jumps_pos_list) - 1
