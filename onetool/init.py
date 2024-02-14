from reactivex import operators as op

from onetool.app.runtime import OnetoolRuntime
from onetool.core import events, environment

try:
    import local
except ImportError:
    local = None


app = OnetoolRuntime.get()
app.config.editor_cmd = ('kitty -e ~/.local/nvim.appimage', True) if environment.is_linux() else ('start /wait nvim', True)
app.config.plugins_root_name = '_internal/plugins'
app.config.views_root = '_internal/onetool'

app.load_plugin('files')
app.load_plugin('logs')
app.load_plugin('tables')

app.load_plugin('auto',
    data_root = '~/data/data/auto',
    local_data_root = '~/data/auto_local'
)

app.load_plugin('player',
    db_home = '~/data/playerdb',
    spot_client_id = local.spot_client_id if local else None,
    spot_redirect_url = local.spot_redirect_url if local else None,
    spot_api_url = 'https://api.spotify.com',
    spot_device_id = local.spot_device_id if local else None
)

app.add_statusline(app.get_key_sequence().pipe(
    op.map(lambda s: s.replace(' ', 'spc'))
))

events.subscribe('app.enter', lambda _: app.open('player'))
