FROM alpine/git AS initlayer
WORKDIR /workdir
# TODO: replace that, waiting for https://github.com/PaperMtn/gitlab-watchman/pull/6 to be merged
#RUN git clone https://github.com/PaperMtn/gitlab-watchman.git
RUN git clone https://github.com/adioss/gitlab-watchman.git
WORKDIR /workdir/gitlab-watchman

FROM python:buster
RUN addgroup --gid 1000 gitlab-watchman
RUN useradd -u 1000 -g 1000 gitlab-watchman
RUN mkdir /home/gitlab-watchman
COPY --from=initlayer /workdir/gitlab-watchman /home/gitlab-watchman
RUN chown -R gitlab-watchman: /home/gitlab-watchman
WORKDIR /home/gitlab-watchman

RUN python -m pip install --upgrade pip
RUN pip install setuptools wheel twine requests colorama termcolor PyYAML
RUN python setup.py sdist bdist_wheel
RUN mv dist/gitlab-watchman-*.tar.gz dist/gitlab-watchman.tar.gz
RUN pip install dist/gitlab-watchman.tar.gz

USER gitlab-watchman

ENTRYPOINT ["/usr/local/bin/gitlab-watchman"]