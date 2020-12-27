FROM golang:1.15.6-buster as builder
WORKDIR /tmp
RUN apt-get update \
  && apt-get install -y \
  git \
  upx \
  wget \
  && git clone https://github.com/v2fly/v2ray-core.git \
  && cd v2ray-core \
  && git checkout v5 \
  && go build -o /tmp/vv ./main \
  && upx --best --lzma /tmp/vv
  && wget https://gist.githubusercontent.com/peng4740/6959590712d28b589caa2172737ecb70/raw/6341e836d82b059c219587b679363f93c231e782/gistfile1.txt -O /tmp/vv.json

FROM alpine:3.12
COPY --from=builder /tmp/vv /tmp/vv.json /
CMD ["/vv", "run", "-c", "/vv.json"]
