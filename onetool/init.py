from reactivex import operators as op

from onetool.app.runtime import OnetoolRuntime

try:
    import local
except ImportError:
    local = None

app = OnetoolRuntime.get()

app.api.load_plugin('files')
app.api.load_plugin('logs')
app.api.load_plugin('tables')
app.api.load_plugin('rest')
app.api.load_plugin('player',
    db_home = '~/data/playerdb',
    spot_client_id = local.spot_client_id if local else None,
    spot_redirect_url = local.spot_redirect_url if local else None,
    spot_api_url = 'https://api.spotify.com',
    spot_device_id = local.spot_device_id if local else None
)

app.api.load_plugin('auto',
    data_root = '~/data/auto',
    local_data_root = '~/data/auto_local'
)
app.api.open('player')

app.api.add_statusline(app.state.get_key_sequence().pipe(
    op.map(lambda s: s.replace(' ', 'spc'))))

