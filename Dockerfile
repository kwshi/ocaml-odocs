FROM ocaml/opam2

RUN ["sudo", "apt-get", "update"]
RUN ["sudo", "apt-get", "install", "-y", "m4", "npm"]
RUN ["npm", "install", "-g", "netlify-cli"]

RUN ["opam", "init", "-n"]

RUN ["opam", "update"]

COPY pkg-list /root
RUN opam install -y odig $(cat pkg-list) || true

RUN eval $(opam env) && \
  odig odoc --odoc-theme odig.gruvbox.dark

CMD eval $(opam env) && \
  netlify deploy --prod --dir "$(odig cache path)"/html
