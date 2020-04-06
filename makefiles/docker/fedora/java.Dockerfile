FROM ortools/make:fedora_swig AS env
ENV JAVA_HOME=/usr/lib/jvm/jre-1.8.0-openjdk
RUN dnf -y update \
&& dnf -y install java-1.8.0-openjdk-devel maven \
&& dnf clean all

FROM env AS devel
WORKDIR /home/lib
COPY . .

FROM devel AS build
RUN make third_party
RUN make java

FROM build AS test
RUN make test_java

FROM build AS package
RUN make package_java
