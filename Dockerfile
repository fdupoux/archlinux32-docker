FROM scratch
ADD archlinux32.tar.gz /
ENV LANG=en_US.UTF-8
CMD ["/usr/bin/bash"]
