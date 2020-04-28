FROM alpine:3

RUN ["apk", "update"]
RUN ["apk", "upgrade"]
RUN ["apk", "add", "-u", \
  "opam", "npm", "musl-dev", "m4", "make", \
  "ocaml-compiler-libs", "linux-headers" ]

RUN ["npm", "install", "-g", "netlify-cli"]

RUN ["opam", "init", "--shell", "sh", "--auto-setup", "--disable-sandboxing"]
RUN ["opam", "update"]

COPY pkg-list /root
RUN opam install -y odig $(cat /root/pkg-list)

RUN eval $(opam env) \
  && odig odoc --odoc-theme odig.gruvbox.dark \
  $(cat /root/pkg-list) \
  || true

CMD netlify deploy --prod --dir "$(eval $(opam env) && odig cache path)"/html
