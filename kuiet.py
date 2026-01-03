# License: GNU GPL version 3, see the file "AUTHORS" for details.

from __future__ import (absolute_import, division, print_function)

from ranger.gui.colorscheme import ColorScheme
from ranger.gui.color import default_colors, reverse, normal, bold, BRIGHT


ORNG = 202
BLUE = 117
YELL = 220  
LGHT = 255  
MIDM = 145  
DARK = 240  
LGRN = 70   
BLCK = 233  
WHT = 7

class Snow(ColorScheme):
    progress_bar_color = ORNG

    def use(self, context):
        fg, bg, attr = default_colors

        if context.reset:
            return default_colors

        elif context.in_browser:
            if context.selected:
                attr = reverse
                fg = ORNG
            else:
                attr = normal
            if context.empty or context.error:
                fg = ORNG
                bg = BLCK
            if context.border:
                fg = WHT
            if context.image:
                fg = 255
            if context.video:
                fg = 241
            if context.audio:
                fg = 239
            if context.document:
                attr |= BRIGHT 
                fg = WHT
            if context.container:
                attr |= bold
                fg = 11
            if context.directory:
                attr |= bold
            elif context.executable and not \
                    any((context.media, context.container,
                         context.fifo, context.socket)):
                fg = 69
            if context.socket:
                fg = WHT 
                attr |= bold
            if context.fifo or context.device:
                fg = WHT
                if context.device:
                    attr |= bold
            if context.link:
                fg = WHT if context.good else LGHT
                bg = BLCK
            if context.bad:
                bg = BLCK
            if context.tag_marker and not context.selected:
                attr |= bold
                if fg in (WHT, 95):
                    fg = ORNG
                else:
                    fg = ORNG
            if not context.selected and (context.cut or context.copied):
                fg = ORNG
                bg = BLCK
            if context.main_column:
                if context.selected:
                    attr |= bold
                if context.marked:
                    attr |= bold
                    fg = ORNG
            if context.badinfo:
                if attr & reverse:
                    bg = WHT
                else:
                    fg = WHT

        elif context.in_titlebar:
            if context.hostname:
                attr |= bold
                fg = BLCK 
                bg = WHT
            elif context.directory:
                fg = BLCK
                bg = WHT
            elif context.tab:
                if context.good:
                    fg = WHT
                    bg = YELL
            elif context.link:
                fg = BLUE

        elif context.in_statusbar:
            if context.permissions:
                if context.good:
                    fg = ORNG
                elif context.bad:
                    fg = ORNG
            if context.marked:
                attr |= bold | reverse
                fg = ORNG
            if context.message:
                if context.bad:
                    attr |= bold
                    fg = WHT
            if context.loaded:
                bg = self.progress_bar_color
            if context.vcsinfo:
                fg = WHT
                attr &= ~bold
            if context.vcscommit:
                fg = WHT
                attr &= ~bold

        if context.text:
            if context.highlight:
                attr |= reverse

        if context.in_taskview:
            if context.title:
                fg = ORNG

            if context.selected:
                attr |= reverse

            if context.loaded:
                if context.selected:
                    fg = self.progress_bar_color
                else:
                    bg = self.progress_bar_color

        if context.vcsfile and not context.selected:
            attr &= ~bold
            if context.vcsconflict:
                fg = WHT
            elif context.vcschanged:
                fg = WHT
            elif context.vcsunknown:
                fg = WHT
            elif context.vcsstaged:
                fg = WHT
            elif context.vcssync:
                fg = WHT
            elif context.vcsignored:
                fg = default

        elif context.vcsremote and not context.selected:
            attr &= ~bold
            if context.vcssync:
                fg = WHT
            elif context.vcsbehind:
                fg = WHT
            elif context.vcsahead:
                fg = WHT
            elif context.vcsdiverged:
                fg = WHT
            elif context.vcsunknown:
                fg = WHT

        return fg, bg, attr
