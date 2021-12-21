FROM python:3.7.7 as compile-image

### Set Pyspark Python Paths so that Driver and Executor are consistent
ENV PYTHONPATH=/usr/bin/python3.7

### Setup a virtual env for python isolation and smaller image sizes on multi-stage builds.
### Allows us to easily copy over the files in one bundle from compile container to build.
ENV VIRTUAL_ENV=/opt/venv
RUN python -m venv $VIRTUAL_ENV
ENV PATH="$VIRTUAL_ENV/bin:$PATH"

### Copy requirements file and install packages to the venv (hence no --user flag).
### If VENV is not used, --user flag must be on pip install otherwise git and requirements deps will collide.
### Adjust this file before build to add additional modules, minimal build to save on space
COPY requirements.txt ./requirements.txt
RUN pip install --no-cache-dir -r requirements.txt

########################################################################################
### Change to the slim image to save on space - ONLY RECOMMENDED FOR STANDALONE PY APPS, according to Python Docker Repo.
FROM python:3.7.7 AS build-image

### Set the venv to path
ENV PATH="/opt/venv/bin:$PATH"

WORKDIR /home/

### Copy the files from the previous stage to save on space and remove secrets.
COPY --from=compile-image /opt/venv /opt/venv

### Here for documentation, doesn't actually expose the port.
EXPOSE 8888