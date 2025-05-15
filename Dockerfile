FROM condaforge/mambaforge:24.7.1-0

# Create a conda environment and install run dependencies
RUN mamba create -n vampyr && \
    mamba install -n vampyr -c conda-forge --verbose \
    cmake \
    gxx_linux-64 \
    make \
    mvapich=*=ucx* \
    ninja \
    python \
    pybind11

# Install VAMPyR from source
RUN git clone https://github.com/MRChemSoft/vampyr.git /var/tmp/vampyr && \
    cd /var/tmp/vampyr && \
    . /opt/conda/etc/profile.d/conda.sh && \
    conda activate vampyr && \
    mkdir build && \
    cd build && \
    cmake .. -DCMAKE_INSTALL_PREFIX=$CONDA_PREFIX -DCMAKE_POLICY_VERSION_MINIMUM=3.5 -DCMAKE_CXX_COMPILER=mpicxx && \
    make && \
    rm -rf /var/tmp/vampyr

# Copy the start.sh script
COPY ./start.sh /opt/vampyr/start.sh

# Set the entrypoint to the start.sh script
ENTRYPOINT ["/opt/vampyr/start.sh"]
