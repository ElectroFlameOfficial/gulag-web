FROM python:3.9-buster

# Update and install essentials
RUN apt update

# Install dependencies
COPY ./ext/requirements.txt requirements.txt
RUN pip install -r requirements.txt

# Temporary workaround
RUN touch /var/run/nginx.pid

# Create user for gulag-web and directory
RUN addgroup --system --gid 1000 gulag && adduser --system --uid 1000 --gid 1000 gulag
RUN mkdir /gulag-web && chown -R gulag:gulag /gulag-web

# Expose port and set entrypoint
EXPOSE 8080
CMD [ "python3.9", "./main.py" ]

# Switch to gulag user and copy the files at the very last moment
WORKDIR /gulag-web
USER gulag
COPY ./ ./