FROM alpine:3

RUN ["apk", "update"]
RUN ["apk", "upgrade"]
RUN ["apk", "add", "-u", "musl-dev", "m4", "make", "npm", "opam"]
RUN ["npm", "install", "-g", "netlify-cli"]

RUN ["opam", "init", "--no-setup", "--disable-sandboxing"]
RUN ["opam", "update"]

COPY pkg-list /root
RUN opam install -y odig $(cat pkg-list) || true

RUN eval $(opam env) && \
  odig odoc --odoc-theme odig.gruvbox.dark

CMD eval $(opam env) && \
  netlify deploy --prod --dir "$(odig cache path)"/html
