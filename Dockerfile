FROM jupyter/base-notebook@sha256:d60527e9abc8dc91827120d75388e76167693821a081d444e31367c644a25c62
MAINTAINER chapmanbe <brian.chapman@unimelb.edu.au>
# for physionet instructions see
# https://www.physionet.org/physiotools/wfdb-linux-quick-start.shtml
# dependencies for spell nbextensions (including spell check) and other requirements

RUN conda update conda -y && conda install -y \
    pip 

RUN pip install venn \
    psycopg2-binary \
    imblearn==0.0 \
    ipywidgets==7.6.3 \
    matplotlib==3.4.2 \
    numpy==1.20.3 \
    pandas==1.3.1 \
    qgrid==1.3.1 \
    seaborn==0.11.1 \
    session_info==1.0.0 \
    scikit-learn==0.24.2 \
    sweetviz==2.1.3 \
    graphviz==0.16 \
    holoviews==1.14.5 \
    hvplot==0.7.3 \
    matplotlib_venn==0.11.6 \
    pydotplus==2.0.2 \
    itables

RUN jupyter labextension disable @jupyterlab/docmanager-extension:download && jupyter labextension disable @jupyterlab/filebrowser-extension:download

WORKDIR /home/jovyan/work

ADD synthea_encounters synthea_encounters
# RUN nbstripout --install
USER root
RUN chown -R root /home/jovyan && \
    chmod -R 755 /home/jovyan /tmp &&\
    mkdir -p /home/jovyan/.local /home/jovyan/.config /home/jovyan/.cache && \
    chmod -R 777 /home/jovyan/.local /home/jovyan/.config /home/jovyan/.cache
USER jovyan
CMD ["start-notebook.sh"]



