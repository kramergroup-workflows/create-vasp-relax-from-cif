FROM minio/mc as s3

ARG S3_HOST
ARG S3_ACCESS_KEY_ID
ARG S3_SECRET_ACCESS_KEY

RUN env
RUN mc config host add --insecure minio https://$S3_HOST $S3_ACCESS_KEY_ID $S3_SECRET_ACCESS_KEY
RUN mc --insecure cp minio/vasp/vasp5_psps.tar.gz /tmp/vasp5_psps.tar.gz
RUN tar xvzf /tmp/vasp5_psps.tar.gz /VASP5_psps

# -------------------------------

FROM registry.kramergroup.science/workflows/matsci-base:latest

ENV CIF_FILE "/data/structure.cif"
ENV VASP_FILES "/data/vasp"

COPY --from=s3 /VASP5_psps /VASP5_psps

RUN pmg config --add PMG_VASP_PSP_DIR /VASP5_psps && \
    pmg config --add PMG_DEFAULT_FUNCTIONAL PBE_52

COPY create_vasp_inputs.py /create_vasp_inputs.py

ENTRYPOINT [ "/create_vasp_inputs.py" ]