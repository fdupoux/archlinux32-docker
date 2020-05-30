FROM scratch
ADD archlinux32.tar /
ENV LANG=en_US.UTF-8
CMD ["/usr/bin/bash"]
