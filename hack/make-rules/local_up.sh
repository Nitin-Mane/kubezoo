#!/usr/bin/env bash

# Copyright 2022 The KubeZoo Authors.
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

set -xeu 

ZOO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd -P)"
source "${ZOO_ROOT}/hack/lib/init.sh"
source "${ZOO_ROOT}/hack/lib/local_up.sh"

readonly REQUIRED_CMD=(
    go
    docker
    kubectl
    kind
)

readonly LOCAL_ARCH=$(go env GOHOSTARCH)
readonly LOCAL_OS=$(go env GOHOSTOS)
readonly CLUSTER_NAME="kubezoo-e2e-test"
readonly KIND_KUBECONFIG=${KIND_KUBECONFIG:-${HOME}/.kube/config}

trap cleanup_on_err EXIT

preflight
cleanup
local_up
