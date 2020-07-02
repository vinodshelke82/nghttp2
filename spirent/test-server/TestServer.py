import io, ssl
import nghttp2

# This is sample test server for testing HTTP2 client.
# TODO expand implementation as client features are added.

class Handler(nghttp2.BaseRequestHandler):

    def on_headers(self):
        self.push(path='/css/bootstrap.css',
                  request_headers = [('content-length', '3')],
                  status=200,
                  body='foo')

        self.push(path='/js/bootstrap.js',
                  method='GET',
                  request_headers = [('content-length', '10')],
                  status=200,
                  body='foobarbuzz')

        self.send_response(status=200,
                           headers = [('content-type', 'text/plain')],
                           body=io.BytesIO(b'nghttp2-python FTW'))

# ctx = ssl.SSLContext(ssl.PROTOCOL_SSLv23)
# ctx.options = ssl.OP_ALL | ssl.OP_NO_SSLv2
# ctx.load_cert_chain('server.crt', 'server.key')
ctx = None

# give None to ssl to make the server non-SSL/TLS
server = nghttp2.HTTP2Server(('0.0.0.0', 8000), Handler, ssl=ctx)
server.serve_forever()
