#!/usr/bin/env bash

num_rounds=10

for i in $(seq -w 1 ${num_rounds}); do
    python generate_data.py \
            --num-samples 2000 \
            --training-data data/train_${i}.csv \
            --test-data data/test_${i}.csv
done
