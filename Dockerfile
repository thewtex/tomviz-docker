FROM thewtex/centos-build:v1.0.0
MAINTAINER tomviz community
# Build and package tomviz

RUN yum update -y && \
  yum install -y \
    libX11-devel \
    libXt-devel \
    libXext-devel \
    libXrender-devel \
    mesa-libGL-devel

WORKDIR /usr/src

RUN mkdir /usr/src/tomviz-prefix

# 2016-01-20
ENV SUPERBUILD_VERSION 55622b293d2ce5b6949b76f16dd5db44d5ea854d
RUN git clone https://github.com/OpenChemistry/tomviz-superbuild.git && \
  cd tomviz-superbuild && \
  git checkout ${SUPERBUILD_VERSION}
RUN mkdir /usr/src/tomviz-superbuild-build
# This is required for the NumPy build.
ENV LD_LIBRARY_PATH /usr/src/tomviz-superbuild-build/install/lib
WORKDIR /usr/src/tomviz-superbuild-build

RUN cmake -DENABLE_fftw3double:BOOL=TRUE \
  -DENABLE_fftw3float:BOOL=TRUE \
  -DENABLE_lapack:BOOL=TRUE \
  -DENABLE_numpy:BOOL=TRUE \
  -DENABLE_pyfftw:BOOL=TRUE \
  -DENABLE_scipy:BOOL=TRUE \
  -DENABLE_tbb:BOOL=TRUE \
  -DENABLE_tomviz:BOOL=TRUE \
  -Dqt4_WORK_AROUND_BROKEN_ASSISTANT_BUILD:BOOL=TRUE \
  -DCMAKE_BUILD_TYPE:STRING=MinSizeRel \
    ../tomviz-superbuild
