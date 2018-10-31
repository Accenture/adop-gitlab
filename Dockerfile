FROM gitlab/gitlab-ce:11.4.5-ce.0

LABEL maintainer="jonathan.e.jarvis@accenture.com"

COPY resources/assets/ /assets/

# Execute configuration scripts
RUN chmod +x -R /assets/wrapper
CMD ["/assets/wrapper"]