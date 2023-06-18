#!/bin/sh

echo "\033[43;31mStop validators...\033[0m"
pids=($(ps -ef | grep geth | grep -v grep | awk '{print $2}'))
for pid in "${pids[@]}"; do
  kill $pid
done

echo "\033[43;31mClear files...\033[0m"
rm -rf node* pentacle-quorum quorum