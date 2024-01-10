# Specify the Julia version here
FROM julia:1.7

ENV GUROBI_MAJOR=11
ENV GUROBI_MINOR=0
ENV GUROBI_POINT=0

# INstall wget
RUN apt-get update && \
    apt-get install -y \
        wget && \
    rm -rf /var/lib/apt/lists/*

# Install Gurobi

RUN wget https://packages.gurobi.com/${GUROBI_MAJOR}.${GUROBI_MINOR}/gurobi${GUROBI_MAJOR}.${GUROBI_MINOR}.${GUROBI_POINT}_linux64.tar.gz 
#RUN wget https://packages.gurobi.com/9.0/gurobi9.0.1_linux64.tar.gz 
RUN tar -xzf gurobi${GUROBI_MAJOR}.${GUROBI_MINOR}.${GUROBI_POINT}_linux64.tar.gz && \
    rm gurobi${GUROBI_MAJOR}.${GUROBI_MINOR}.${GUROBI_POINT}_linux64.tar.gz && \
    mv gurobi${GUROBI_MAJOR}${GUROBI_MINOR}${GUROBI_POINT} /opt/gurobi


ENV GUROBI_HOME=/opt/gurobi/linux64
ENV PATH=$PATH:${GUROBI_HOME}/bin
ENV LD_LIBRARY_PATH=$LD_LIBRARY_PATH:${GUROBI_HOME}/lib

#COPY gurobi.lic /opt/gurobi/gurobi.lic

# Create a setup file that simply installs non-versioned packages
COPY Packages.jl /0setup.jl
RUN julia /0setup.jl

# Change the default to /code
WORKDIR /project

# Default to running Julia
CMD ["julia"]
