from kittens.tui.handler import result_handler
from kitty.boss import Boss

@result_handler(no_ui=True)
def handle_result(args, answer, target_window_id, boss: Boss) -> None:
    # Toggle fullscreen for the active window
    boss.toggle_fullscreen()
