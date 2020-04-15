FROM debian:jessie-slim

ENV PYTHONUNBUFFERED 1

# install required ubuntu packages
RUN apt-get update --fix-missing && \
    apt-get install -y --no-install-recommends ca-certificates libxrender1 libxext6 wget bzip2 libgraphicsmagick++3 libopenbabel4 libpotrace0 nano && \
    apt-get -qq -y autoremove && \
    apt-get autoclean && \
    rm -rf /var/lib/apt/lists/* /var/log/dpkg.log && \
    echo 'alias ls="ls --color=auto"' > ~/.bashrc && \
    echo 'PS1="\[\e[1;31m\]\u\[\e[m\]\[\e[1;31m\]@\[\e[m\]\[\e[1;31m\]\h\[\e[m\]:\w\$ "' >> ~/.bashrc

# install miniconda
RUN wget --quiet https://repo.continuum.io/miniconda/Miniconda3-4.7.12.1-Linux-x86_64.sh -O ~/miniconda.sh && \
    /bin/bash ~/miniconda.sh -b -p /opt/conda && \
    rm -rf $HOME/conda/pkgs/* && \
    rm ~/miniconda.sh

# add conda bin to path
ENV PATH /opt/conda/bin:$PATH

# use the environment.yml to create the conda env
COPY environment.yml /tmp/environment.yml

# create the conda env using saved environment file
RUN conda env create -n chembl-beaker -f /tmp/environment.yml

# activate env (add conda env bin to path)
ENV PATH /opt/conda/envs/chembl-beaker/bin:$PATH

# osra needs both files in the same bin dir
RUN cp /opt/conda/pkgs/osra-2.0.1-0/share/spelling.txt /opt/conda/envs/chembl-beaker/bin/spelling.txt && \
    cp /opt/conda/pkgs/osra-2.0.1-0/share/superatom.txt /opt/conda/envs/chembl-beaker/bin/superatom.txt

# copy beaker and config file
COPY src/chembl_beaker chembl_beaker
COPY beaker.conf beaker.conf

# python chembl_beaker/run_beaker.py -p beaker.conf
ENTRYPOINT [ "python", "chembl_beaker/run_beaker.py", "-p", "beaker.conf" ]
