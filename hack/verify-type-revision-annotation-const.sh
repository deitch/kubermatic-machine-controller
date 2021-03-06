#!/usr/bin/env bash

# Copyright 2019 The Machine Controller Authors.
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

set -euo pipefail

cd $(dirname $0)/..

const_val=$(grep 'TypeRevisionCurrentVersion = "' \
  pkg/apis/cluster/v1alpha1/conversions/conversions.go|awk '{print $3 }'|tr -d '"')

constraint_val=$(grep sigs.k8s.io/cluster-api -A1 Gopkg.toml \
  |grep revision|awk '{ print $3 }'|tr -d '"')

if [[ "$const_val" != "$constraint_val" ]]; then
  echo "Error! TypeRevisionCurrentVersion constant in pkg/apis/cluster/v1alpha1/conversions/conversions.go does not match the constraint for sigs.k8s.io/cluster-api in Gopkg.toml!"
  exit 1
fi
