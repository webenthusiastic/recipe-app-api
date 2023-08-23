# Use the base Python image
FROM python:3.9-alpine3.13

# Set maintainer label
LABEL maintainer="londonappdeveloper.com"

# Set the environment variable for unbuffered output
ENV PYTHONUNBUFFERED 1

# Copy requirements.txt to the /tmp/ directory
COPY ./requirements.txt /tmp/requirements.txt
COPY ./requirements.dev.txt /tmp/requirements.dev.txt

# Copy your application files to the working directory
COPY ./app /app

# Set the working directory
WORKDIR /app

# Expose the port your application will run on
EXPOSE 8000

# Install dependencies and create the virtual environment
ARG DEV=false
RUN python -m venv /py && \
    /py/bin/pip install --upgrade pip && \
    /py/bin/pip install -r /tmp/requirements.txt && \
    if [ "$DEV" = "true" ]; then /py/bin/pip install -r /tmp/requirements.dev.txt; fi && \
    /py/bin/pip install flake8 && \
    rm -rf /tmp && \
    adduser --disabled-password --no-create-home django-user

# Set the PATH to include the virtual environment's binaries
ENV PATH="/py/bin:$PATH"

# Specify the user for running the application
USER django-user

# This is where you would specify the command to run your application
# For example, if you're using Django, it could be something like:
# CMD ["python", "manage.py", "runserver", "0.0.0.0:8000"]




# # FROM python:3.9-alpine3.13
# # LABEL maintainer="londonappdeveloper.com"

# # ENV PYTHONUNBUFFERED 1

# # COPY ./requirements.txt /tmp/requirements.txt
# # COPY ./app /app
# # WORKDIR /app
# # EXPOSE 8000

# # RUN python -m venv/py &&\
# #     /py/bin/pip install --upgrade pip &&\
# #     /py/bin/pip install -r /tmp/requirements.txt &&\
# #     rm -rf /tmp &&\
# #     adduser\
# #         --disabled-password \
# #         --no-create-home \
# #         django-user
# # ENV PATH="/py/bin:$PATH"

# # USER django-user

# # Use the base Python image
# FROM python:3.9-alpine3.13

# # Set maintainer label
# LABEL maintainer="londonappdeveloper.com"

# # Set the environment variable for unbuffered output
# ENV PYTHONUNBUFFERED 1

# # Copy requirements.txt to the /tmp/ directory
# COPY ./requirements.txt /tmp/requirements.txt
# COPY ./requirements.dev.txt /tmp/requirements.dev.txt

# # Copy your application files to the working directory
# COPY ./app /app

# # Set the working directory
# WORKDIR /app

# # Expose the port your application will run on
# EXPOSE 8000

# # Install dependencies and create the virtual environment
# ARG DEV=false
# RUN python -m venv /py && \
#     /py/bin/pip install --upgrade pip && \
#     /py/bin/pip install -r /tmp/requirements.txt && \
#     if ["$DEV" = "true"];\
#         then /py/bin/pip install -r /tmp/requirements.dev.txt;\
#     fi &&\
#     rm -rf /tmp && \
#     adduser --disabled-password --no-create-home django-user
 
# # Set the PATH to include the virtual environment's binaries
# ENV PATH="/py/bin:$PATH"

# # Specify the user for running the application
# USER django-user

# # This is where you would specify the command to run your application
# # For example, if you're using Django, it could be something like:
# # CMD ["python", "manage.py", "runserver", "0.0.0.0:8000"]