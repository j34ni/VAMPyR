#!/bin/bash

echo "Activating environment..."

. /opt/conda/etc/profile.d/conda.sh && conda activate vampyr

exec "$@"
