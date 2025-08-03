FROM kalilinux/kali-rolling
RUN apt-get update && apt-get install -y \
    net-tools curl wget nmap nikto whois sqlmap iputils-ping dnsutils openssh-server && \
    apt-get clean
CMD ["/bin/bash"]
