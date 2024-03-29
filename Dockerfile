FROM python:3.12-slim

# Install ClamAV
RUN apt-get update &&\
    apt-get install -y clamav clamav-daemon &&\
    freshclam

# Set the working directory in the container
WORKDIR /usr/src/app

# Copy the current directory contents into the container at /usr/src/app
COPY . .

RUN pip install --no-cache-dir -r requirements.txt

# Make port 5000 available to the world outside this container
EXPOSE 5000

# Create a non-root user and change ownership of work directory
RUN adduser --disabled-password --gecos '' purity_user
RUN chown -R purity_user /usr/src/app
USER purity_user

RUN chmod +x /usr/src/app/entry.sh

# Make the script the container's entrypoint
ENTRYPOINT ["/usr/src/app/entry.sh"]
