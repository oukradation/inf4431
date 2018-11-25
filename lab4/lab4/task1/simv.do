#! /bin/bash
vsim work.tb_compute_pipelined
add wave *
run 400 ns
