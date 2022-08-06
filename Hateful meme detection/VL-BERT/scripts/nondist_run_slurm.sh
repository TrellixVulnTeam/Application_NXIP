#!/usr/bin/env bash

set -x

PARTITION=$1
JOB_NAME=$2
RUN_SCRIPT=$3
CONFIG=$4
WORK_DIR=$5
GPUS=${6:-8}
CPUS_PER_TASK=${CPUS_PER_TASK:-40}
SRUN_ARGS=${SRUN_ARGS:-""}
PY_ARGS=${PY_ARGS:-""}

srun -p ${PARTITION} \
    --job-name=${JOB_NAME} \
    --gres=gpu:${GPUS} \
    --ntasks=1 \
    --ntasks-per-node=1 \
    --cpus-per-task=${CPUS_PER_TASK} \
    --kill-on-bad-exit=1 \
    ${SRUN_ARGS} \
    python -u ${RUN_SCRIPT} \
    --cfg ${CONFIG} \
    --model-dir ${WORK_DIR} \
    ${PY_ARGS}
