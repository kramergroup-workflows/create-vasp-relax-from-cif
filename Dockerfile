FROM registry.kramergroup.science/workflows/matsci-base:latest

ENV CIF_FILE "/data/structure.cif"
ENV VASP_FILES "/data/vasp"

COPY VASP5_psps /VASP5_psps
RUN pmg config --add PMG_VASP_PSP_DIR /VASP5_psps && \
    pmg config --add PMG_DEFAULT_FUNCTIONAL PBE_52

COPY create_vasp_inputs.py /create_vasp_inputs.py

ENTRYPOINT [ "/create_vasp_inputs.py" ]