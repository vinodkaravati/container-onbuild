# Use the httpd-parent image as base
FROM quay.io/redhattraining/httpd-parent
LABEL io.k8s.description="A basic Apache HTTP Server child image, uses ONBUILD" \
      io.k8s.display-name="Apache HTTP Server" \
      io.openshift.expose-services="80:http" \
      io.openshift.tags="apache, httpd"
ENV DOCROOT=/var/www/html
RUN yum install -y --no-docs --disableplugin=subscription-manager httpd
RUN yum clean all --disableplugin=subscription-manager -y
RUN echo "Hello from the httpd-parent container!" > ${DOCROOT}/index.html
# Allows child images to inject their own content into DocumentRoot

EXPOSE 80
# This stuff is needed to ensure a clean start
RUN rm -rf /run/httpd && mkdir /run/httpd
# Run as the root user

# Launch httpd
CMD /usr/sbin/httpd -DFOREGROUND
