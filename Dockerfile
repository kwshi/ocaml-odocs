FROM akabe/ocaml:latest

RUN apk add --upgrade m4
RUN apk add npm
RUN npm install -g netlify-cli

RUN opam update

COPY pkg-list /root
RUN opam install -y odig $(cat pkg-list) || true

RUN eval $(opam env) && odig odoc --odoc-theme=odig.gruvbox.dark

RUN eval $(opam env) && netlify deploy --prod "$(odig cache path)"/html
