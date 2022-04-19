# Copyright 2020 The Kubernetes Authors.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

FROM k8s.gcr.io/build-image/debian-base:bullseye-v1.2.0

ARG ARCH
ARG binary=./bin/${ARCH}/nfsplugin
COPY ${binary} /nfsplugin

RUN apt update && apt-mark unhold libcap2
RUN clean-install ca-certificates mount nfs-common netbase
# install updated packages to fix CVE issues
RUN clean-install zlib1g gzip liblzma5

ENTRYPOINT ["/nfsplugin"]
