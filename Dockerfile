FROM ubuntu:focal
RUN apt-get update && \
    apt-get install -qq -y ca-certificates wget python dc bc

RUN wget -t 1 -O /tmp/fslinstaller.py https://fsl.fmrib.ox.ac.uk/fsldownloads/fslinstaller.py && \
    python /tmp/fslinstaller.py -d /opt/fsl && \
    rm -rf /tmp/fslinstaller.py /opt/fsl/src

ENV FSLDIR=/opt/fsl FSLOUTPUTTYPE=NIFTI_GZ \
 PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/opt/fsl/bin LD_LIBRARY_PATH=/opt/fsl/lib

RUN . $FSLDIR/etc/fslconf/fsl.sh && \
    apt-get --purge remove -y wget && \
    apt-get clean
# maybe also rm /var/lib/apt/lists/*
