from onetool.core.keyboard import GLOBAL, KeyMap
from reactivex import operators as op

from onetool.app.runtime import OnetoolRuntime
from onetool.core import widgets, environment
from onetool.core.widgets import VBox, HBox, W

try:
    import local
except ImportError:
    local = None

app = OnetoolRuntime.get()
app.config.editor_cmd = (
    '~/.local/kitty.app/bin/kitty ~/.local/nvim.appimage',
    True) if environment.is_linux() else ('start /wait nvim', True)
app.config.use_neovim = False
if environment.is_linux():
    app.config.neovim_cmd = '~/.local/nvim.appimage'
    app.config.neovim_connection_type = 'socket'
else:
    app.config.neovim_cmd = 'nvim'
    app.config.neovim_connection_type = 'tcp'
    app.config.neovim_tcp_port = 3849

player = app.load_plugin('player',
    db_home = '~/data/playerdb',
    local_home = '/home/data/music',
    spot_client_id = local.spot_client_id if local else None,
    spot_redirect_url = local.spot_redirect_url if local else None,
    spot_api_url = 'https://api.spotify.com',
    spot_device_id = local.spot_device_id if local else None,
    preload = True,
    preload_timeout = 20
)

app.open('player')

logs = app.load_plugin('logs')

keys_widget = widgets.TextWidget()
app.get_key_sequence()\
    .pipe(op.map(lambda s: s.replace(' ', 'spc')))\
    .subscribe(on_next = keys_widget.set_text)

app.use_widgets(
    VBox(
        HBox(player.get_widget(), logs.get_widget()),
        W(keys_widget, proportion=0))
)

keymap = KeyMap.get(GLOBAL)
keymap.bind(GLOBAL, ' -n-n', lambda _: app.notify_info('info'))

keymap = KeyMap.get(GLOBAL)
keymap.bind(GLOBAL, ' -o-p', lambda _: app.open('player'))
keymap.bind(GLOBAL, ' -o-a', lambda _: app.open('auto'))
keymap.bind(GLOBAL, ' -o-l', lambda _: app.open('logs'))
keymap.bind(GLOBAL, ' -o-f', lambda _: app.open('files'))
keymap.bind(GLOBAL, ' -o-d', lambda _: app.open('docs'))
keymap.bind(GLOBAL, ' -o-r', lambda _: app.open('repos'))
keymap.bind(GLOBAL, ' -s-s', lambda _: app.split())

auto = app.load_plugin('auto', workspaces_root = '~/data/auto/')
auto.run_by_path('github', 'updates/check onetool update')

app.load_plugin('notifications')
app.load_plugin('files')
app.load_plugin('docs', workspaces_root = '~/data/docs/')

repos = app.load_plugin('repos')
repos.sync_all()
