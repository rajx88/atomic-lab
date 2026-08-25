#!/usr/bin/env bash
set -oue pipefail

# prmt shell prompt (https://github.com/3axap4eHko/prmt)
# Built from crates.io on every image build -> always picks up the latest
# published release. The rust toolchain lives only inside this build module;
# it is removed before the module commits, so it never reaches the image.
#
# To freeze against upstream breakage, pin instead:
#   cargo install --root /usr prmt@0.7.0

dnf install -y cargo

cargo install --root /usr prmt

dnf remove -y cargo
dnf autoremove -y || true
