# Use one of the images from this repository:
# https://github.com/centreborelli/ipol-docker-images/
FROM registry.ipol.im/ipol:v2-py3.11-pytorch-gpu

# Install additional Debian packages
COPY .ipol/packages.txt packages.txt
RUN apt-get update && apt-get install -y $(cat packages.txt) \
    && rm -rf /var/lib/apt/lists/* && rm packages.txt

# Copy the requirements.txt and install Python packages
COPY requirements.txt requirements.txt
RUN pip3 install --no-cache-dir -r requirements.txt && rm requirements.txt

# Copy the code to $bin
ENV bin /workdir/bin/
RUN mkdir -p $bin
WORKDIR $bin
COPY . .

# Some quality-of-life tweaks
ENV PYTHONDONTWRITEBYTECODE 1
ENV PROTOCOL_BUFFERS_PYTHON_IMPLEMENTATION python
ENV PATH $bin:$PATH

# Set HOME (writable by user 'ipol') and adjust permissions
ENV HOME /home/ipol
RUN groupadd -g 1000 ipol \
    && useradd -m -u 1000 -g 1000 ipol -d $HOME \
    && chmod -R 777 $HOME

# Copy the entrypoint script into the image and make it executable
COPY entrypoint.sh /workdir/entrypoint.sh
RUN chmod +x /workdir/entrypoint.sh

# Switch to the non-root user
USER ipol

# Set the entrypoint and default command
ENTRYPOINT ["/workdir/entrypoint.sh"]
CMD ["python", "/workdir/bin/main.py"]
