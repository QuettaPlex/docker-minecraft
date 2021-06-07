FROM ubuntu:latest
RUN apt update && apt upgrade -y && apt install -y tzdata wget
ENV TZ Asia/Tokyo
WORKDIR /opt
RUN apt install -y openjdk-8-jre && \
    wget https://launcher.mojang.com/v1/objects/1b557e7b033b583cd9f66746b7a9ab1ec1673ced/server.jar
WORKDIR /root
RUN echo eula=true > eula.txt && echo "mv /mnt/var/* /root" > run.sh && \
    echo "java -Xmx1024M -Xms1024M -jar /opt/server.jar" >> run.sh && \
    echo "mv /root/* /mnt/var" >> run.sh && chmod 777 run.sh && mkdir /mnt/var
CMD ["sh", "run.sh"]