#!/bin/bash
#
# shellcheck disable=
#
# Copyright (c) 2024 OpenMediaVault Plugin Developers
#
# This file is licensed under the terms of the GNU General Public
# License version 2. This program is licensed "as is" without any
# warranty of any kind, whether express or implied.
#
# version: 0.0.1

export LANG=C.UTF-8

infile="/etc/omv-backup-vm.list"
tmpfile=$(mktemp)
if [ -f "${infile}" ]; then
  while IFS=, read -r uuid path vmname date used; do
    backup="${path}/${vmname}/${date}"
    if [ -d "${backup}" ]; then
      echo "${uuid},${path},${vmname},${date},${used}" >> "${tmpfile}"
    fi
  done < "${infile}"
  mv "${tmpfile}" "${infile}"
fi
rm -f "${tmpfile}"
