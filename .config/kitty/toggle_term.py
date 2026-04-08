from kittens.tui.handler import result_handler
from kitty.boss import Boss


def main(args: list[str]) -> None:
    pass


@result_handler(no_ui=True)
def handle_result(
    args: list[str], answer: str, target_window_id: int, boss: Boss
) -> None:
    tab = boss.active_tab
    if tab is None:
        return

    active = boss.active_window
    if active is None:
        return

    # Store the current window ID as main_window (no user var)
    main_window_id = active.id

    # Find the toggle_term window by title and user var
    toggle_win = next(
        (
            w
            for w in tab.windows
            if w.title == "toggle_term" and w.user_vars.get("is_toggle_term") == "true"
        ),
        None,
    )

    if toggle_win is None:
        # Get current window's cwd
        cwd = active.cwd_of_child if active else "current"

        tab.goto_layout("splits")

        # Create new split at bottom with synchronized cwd
        response = boss.call_remote_control(
            None,
            (
                "launch",
                "--location=vsplit",
                f"--cwd={cwd}",
                "--title=toggle_term",
                "--var=is_toggle_term=true",
            ),
        )
        try:
            new_id = int(response)
        except ValueError:
            return

        new_win = boss.window_id_map.get(new_id)
        if new_win is None:
            return

        # Already focused since launch makes it active
    elif (
        active.title == "toggle_term"
        and active.user_vars.get("is_toggle_term") == "true"
    ):
        # Find the main_window by ID
        main_win = boss.window_id_map.get(main_window_id)
        if main_win is None or main_win == toggle_win:
            # Fallback to any non-toggle_term window
            main_win = next((w for w in tab.windows if w != toggle_win), None)
            if main_win is None:
                return

        # Focus the main_window
        boss.set_active_window(main_win)
        tab.goto_layout("stack")
    else:
        # Focus the toggle_term window
        boss.set_active_window(toggle_win)
        tab.last_used_layout()
