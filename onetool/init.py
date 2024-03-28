from reactivex import operators as op

from onetool.app.runtime import OnetoolRuntime
from onetool.core import environment, events, widgets
from onetool.core.keyboard import GLOBAL, KeyMap

try:
    import local
except ImportError:
    local = None

app = OnetoolRuntime.get()
app.config.editor_cmd = (
    '~/.local/kitty.app/bin/kitty -e ~/.local/nvim.appimage',
    True) if environment.is_linux() else ('start /wait nvim', True)
app.config.plugins_root = '_internal/plugins'
app.config.views_root = '_internal/onetool'

app.load_plugin('files')
app.load_plugin('logs')
app.load_plugin('notifications')

app.load_plugin('auto',
                data_root='~/data/data/auto',
                local_data_root='~/data/auto_local')

player = app.load_plugin(
    'player',
    db_home='~/data/playerdb',
    spot_client_id=local.spot_client_id if local else None,
    spot_redirect_url=local.spot_redirect_url if local else None,
    spot_api_url='https://api.spotify.com',
    spot_device_id=local.spot_device_id if local else None)

sl_widget = widgets.TextWidget()
app.get_key_sequence()\
    .pipe(op.map(lambda s: s.replace(' ', 'spc')))\
    .subscribe(on_next = sl_widget.set_text)

app.use_widgets(widgets.VBox([
    player.get_widget(),
    widgets.WBox(sl_widget, 0)
])) # yapf: disable

keymap = KeyMap.get(GLOBAL)
keymap.bind(GLOBAL, ' -o-p', lambda: app.open('player'))
keymap.bind(GLOBAL, ' -o-a', lambda: app.open('auto'))
keymap.bind(GLOBAL, ' -o-l', lambda: app.open('logs'))
keymap.bind(GLOBAL, ' -o-n', lambda: app.open('notifications'))
keymap.bind(GLOBAL, ' -o-f', lambda: app.open('files'))

def enter():
    app.open('auto')
    app.open('player')

events.subscribe('app.enter', lambda _: enter())
