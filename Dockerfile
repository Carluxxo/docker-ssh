# Imagem base
FROM ubuntu:latest

# Instalação das dependências necessárias
RUN apt-get update && apt-get install -y openssh-client expect

# Copiar o arquivo de chave SSH para o contêiner
COPY id_rsa /root/.ssh/id_rsa
COPY id_rsa.pub /root/.ssh/id_rsa.pub

# Configurar as permissões corretas para os arquivos de chave
RUN chmod 600 /root/.ssh/id_rsa && \
    chmod 644 /root/.ssh/id_rsa.pub

# Configurar o SSH para aceitar automaticamente a chave do host
RUN echo "StrictHostKeyChecking no" >> /etc/ssh/ssh_config

# Executar o comando SSH para criar o arquivo teste.txt
CMD ["/bin/bash", "-c", "expect -c 'spawn ssh -o \"StrictHostKeyChecking=no\" -i /root/.ssh/id_rsa user@ip \"echo Olá, Mundo! > /home/pasta/teste.txt\"; expect \"password:\"; send \"senha\n\"; interact'"]

