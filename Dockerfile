FROM fedora
# TODO: use openbox instead of xterm < https://fedoramagazine.org/openbox-fedora/
# TODO: use sice-html5 client < https://fedoraproject.org/wiki/Features/Spice

RUN dnf install -y xorg-x11-drv-qxl xorg-x11-server-Xspice spice-html5 python3-websockify xterm openbox 
RUN useradd app && \
    echo "allowed_users=anybody" > /etc/X11/Xwrapper.config && \
    mkdir -p /home/app/.config/openbox/autostart.d/ && \
    chown app:app /home/app/.config/openbox/autostart.d/

COPY spiceqxl.xorg.conf /etc/X11/
# new syntax
#COPY --chown=app:app autostart.sh /home/app/.config/openbox/
#COPY --chown=app:app xterm.sh /home/app/.config/openbox/autostart.d/
# old syntax
COPY autostart.sh /home/app/.config/openbox/
COPY xterm.sh /home/app/.config/openbox/autostart.d/
RUN chown app:app -R /home/app/.config/openbox/

EXPOSE 5900

USER app
ENTRYPOINT ["Xspice", "--xsession"]
CMD ["openbox-session", ":1"]

