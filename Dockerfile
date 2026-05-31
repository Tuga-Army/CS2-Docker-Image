FROM ghcr.io/k4ryuu/cs2-egg:latest

RUN apt-get update && apt-get install -y libpango-1.0-0 libpangoft2-1.0-0 libgtk-3-0 zenity && apt-get clean