FROM python:3.9-buster

# Update and install essentials
RUN apt update

# Install dependencies
COPY ./ext/requirements.txt requirements.txt
RUN pip install -r requirements.txt

# Create directory for gulag-web and copy the files
RUN mkdir /gulag-web
WORKDIR /gulag-web
COPY ./ ./

# Temporary workaround
RUN touch /var/run/nginx.pid

# Create user for gulag-web and chown
RUN addgroup --system --gid 1000 gulag && adduser --system --uid 1000 --gid 1000 gulag
RUN chown -R gulag:gulag /gulag-web

EXPOSE 8080
CMD [ "python3.9", "./main.py" ]