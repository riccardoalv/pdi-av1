import json
import math
import subprocess
import tempfile
from email.parser import BytesParser
from email.policy import HTTP
from http.server import BaseHTTPRequestHandler, ThreadingHTTPServer
from pathlib import Path
from urllib.parse import parse_qsl, urlparse

RAIZ = Path(__file__).resolve().parent
OCTAVE = ["octave", "--no-gui", "--no-window-system", "--quiet", "--norc", "--eval"]
PORTA = 8000
IMAGENS = {"imagem", "imagem2", "pesos"}


def converter(valor):
    valor = valor.strip()
    if valor.startswith("["):
        return json.loads(valor)
    try:
        numero = float(valor)
    except ValueError:
        return valor
    return numero if math.isfinite(numero) else valor


def ler_multipart(tipo, corpo):
    mensagem = BytesParser(policy=HTTP).parsebytes(
        f"Content-Type: {tipo}\r\n\r\n".encode() + corpo
    )
    imagens = {}
    campos = {}
    for parte in mensagem.iter_parts():
        nome = parte.get_param("name", header="content-disposition")
        dados = parte.get_payload(decode=True)
        if nome in IMAGENS:
            if dados:
                imagens[nome] = dados
        else:
            campos[nome] = dados.decode()
    return imagens, campos


class Manipulador(BaseHTTPRequestHandler):
    def do_GET(self):
        if urlparse(self.path).path in ("/", "/index.html"):
            self.responder(200, "text/html; charset=utf-8", (RAIZ / "index.html").read_bytes())
        else:
            self.responder(404, "text/plain", b"nao encontrado\n")

    def do_POST(self):
        url = urlparse(self.path)
        operacao = url.path.strip("/")
        campos = dict(parse_qsl(url.query))

        tamanho = int(self.headers.get("Content-Length", 0))
        corpo = self.rfile.read(tamanho)
        tipo = self.headers.get("Content-Type", "")

        try:
            if tipo.startswith("multipart/form-data"):
                imagens, campos_formulario = ler_multipart(tipo, corpo)
                campos.update(campos_formulario)
            else:
                imagens = {"imagem": corpo} if corpo else {}
            parametros = {nome: converter(valor) for nome, valor in campos.items() if valor.strip()}
        except ValueError as erro:
            self.responder(400, "text/plain", f"parametro invalido: {erro}\n".encode())
            return

        if "imagem" not in imagens:
            self.responder(400, "text/plain", b"envie a imagem\n")
            return

        with tempfile.TemporaryDirectory() as pasta:
            pasta = Path(pasta)
            caminhos = {}
            for nome, dados in imagens.items():
                caminhos[nome] = str(pasta / nome)
                (pasta / nome).write_bytes(dados)

            pedido = pasta / "pedido.json"
            pedido.write_text(json.dumps({
                "operacao": operacao,
                "parametros": parametros,
                "imagens": caminhos,
                "pasta": str(pasta),
            }))

            caminho = str(pedido).replace("'", "''")
            try:
                resultado = subprocess.run(
                    OCTAVE + [f"processar('{caminho}')"],
                    cwd=RAIZ,
                    capture_output=True,
                    text=True,
                    timeout=120,
                )
            except subprocess.TimeoutExpired:
                self.responder(504, "text/plain", b"tempo esgotado\n")
                return

            png = pasta / "saida.png"
            saida_json = pasta / "saida.json"
            if resultado.returncode != 0:
                self.responder(400, "text/plain", resultado.stderr.encode())
            elif png.exists():
                self.responder(200, "image/png", png.read_bytes())
            elif saida_json.exists():
                self.responder(200, "application/json", saida_json.read_bytes())
            else:
                self.responder(500, "text/plain", b"nenhuma saida gerada\n")

    def responder(self, status, tipo, dados):
        self.send_response(status)
        self.send_header("Content-Type", tipo)
        self.send_header("Content-Length", str(len(dados)))
        self.end_headers()
        self.wfile.write(dados)


if __name__ == "__main__":
    print(f"servidor em http://localhost:{PORTA}", flush=True)
    ThreadingHTTPServer(("", PORTA), Manipulador).serve_forever()
