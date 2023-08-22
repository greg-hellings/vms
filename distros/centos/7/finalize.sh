#!/usr/bin/env bash
set -ex

yum -y update

yum remove make perl gcc kernel-devel kernel-headers bzip2

yum clean all
