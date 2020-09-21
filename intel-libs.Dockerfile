FROM debian:stable-slim

RUN apt-get update && apt-get install -y curl build-essential apt-utils && \
    curl https://apt.repos.intel.com/intel-gpg-keys/GPG-PUB-KEY-INTEL-SW-PRODUCTS-2019.PUB | apt-key add - && \
    curl https://apt.repos.intel.com/setup/intelproducts.list -o /etc/apt/sources.list.d/intelproducts.list && \
    apt-get update && \
    apt-get install -y intel-mkl-2020.2-108 intel-mpi-2019.8-108 && \
    apt-get install -y \
    python python-dev \
    g++-8 gcc-8 gfortran
#    libblas-dev liblapack-dev \
#    fftw3-dev libscalapack-mpi-dev \
#    libxc-dev libnetcdff-dev

RUN MKLVARS_ARCHITECTURE=intel64 . /opt/intel/mkl/bin/mklvars.sh && \
    . /opt/intel/compilers_and_libraries_2020.2.254/linux/mpi/intel64/bin/mpivars.sh && \
    export F95ROOT=/opt/intel/mkl && \
    (cd /opt/intel/compilers_and_libraries_2020.2.254/linux/mkl/interfaces/fftw3xc && make libintel64 compiler=gnu)

CMD ["/bin/bash"]
