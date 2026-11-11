"""Toggle the extra terminals of a tab with a single key (alt+/ by default).

The first window of a tab is its "main" terminal and is never hidden.  Every
other window of that tab is a toggled terminal, so:

  * from main          -> restore the layout and focus the toggled terminal
                          that had focus last (opening one if the tab has none)
  * from a toggled one -> hand the whole tab back to main and hide the toggled
                          ones with kitty's stack layout

The layout to come back to is remembered on the main window as a user var, so
the toggle survives windows being closed, tabs being rearranged and layouts
being changed by hand while everything is hidden.
"""

from kittens.tui.handler import result_handler
from kitty.boss import Boss
from kitty.tabs import Tab
from kitty.window import Window

# User var on the main window: while it is set the tab is collapsed onto main
# and its value is the name of the layout to restore.
COLLAPSED_VAR = 'toggle_term_collapsed'


def terminals(tab: Tab) -> list[Window]:
    """The tab's shells, oldest first, ignoring overlays (scrollback, hints...)."""
    return sorted((w for w in tab.windows if w.overlay_parent is None), key=lambda w: w.created_at)


def focus_last_toggled(tab: Tab, toggled: list[Window]) -> bool:
    """Focus the most recently focused toggled terminal, if it is still around.

    kitty's history is oldest first, the most recent shell is at its end.
    """
    known = {w.id: w for w in toggled}
    for window_id in reversed(tab.windows.active_window_history):
        window = known.get(window_id)
        if window is not None:
            tab.set_active_window(window)
            return True
    return False


def open_toggled(tab: Tab, main_window: Window) -> None:
    """Open a plain shell beside main, in main's working directory."""
    tab.new_window(cwd=main_window.cwd_of_child or tab.cwd, location='vsplit')


def expand(tab: Tab, main_window: Window, restore_layout: str) -> None:
    """Bring the hidden terminals back."""
    main_window.set_user_var(COLLAPSED_VAR, None)
    if tab.current_layout.name != 'stack':  # not hidden after all
        return
    if restore_layout in tab.enabled_layouts:
        tab.goto_layout(restore_layout)
    else:  # the layout we collapsed from is unknown, take the one before it
        tab.last_used_layout()
        if tab.current_layout.name == 'stack':
            tab.goto_layout('splits')


def collapse(tab: Tab, main_window: Window) -> None:
    """Hide every toggled terminal, leaving the whole tab to main."""
    # Never remember 'stack' as the layout to come back to, that would keep the
    # tab collapsed forever, e.g. if main gets closed while collapsed.
    layout = tab.current_layout.name
    main_window.set_user_var(COLLAPSED_VAR, '' if layout == 'stack' else layout)
    tab.set_active_window(main_window)
    if 'stack' in tab.enabled_layouts:
        tab.goto_layout('stack')


def main(args: list[str]) -> None:
    pass


@result_handler(no_ui=True)
def handle_result(args: list[str], answer: str, target_window_id: int, boss: Boss) -> None:
    tab = boss.active_tab
    if tab is None:
        return

    active = tab.active_window
    if active is None:
        return
    # an open overlay (scrollback, hints) counts as the shell it belongs to
    active = active.overlay_parent or active

    shells = terminals(tab)
    if not shells:
        return

    main_window = shells[0]
    toggled = shells[1:]
    # Presence of the var marks the collapsed state; its value is the layout to
    # restore, empty when that is unknown.
    collapsed = COLLAPSED_VAR in main_window.user_vars

    if collapsed:
        # Hidden: show the toggled terminals again, then go to the last one used.
        expand(tab, main_window, main_window.user_vars.get(COLLAPSED_VAR) or '')
        if not focus_last_toggled(tab, toggled):
            open_toggled(tab, main_window)
    elif active is main_window:
        # Main is up and everything is visible: step into a toggled terminal.
        if not focus_last_toggled(tab, toggled):
            open_toggled(tab, main_window)
    elif toggled:
        # A toggled terminal has focus: hide them all and go back to main.
        collapse(tab, main_window)