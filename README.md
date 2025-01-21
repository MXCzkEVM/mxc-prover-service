# mxc-prover-service

This service accepts connections from multiple SGX proof generating machine and submits proofs to Moonchain blocks. It includes the taiko-client (running as a prover) and the prover-manager. 



## Notes

You can set the `PROVER_STARTING_BLOCK_ID` in the `.env` file to change the prover's starting point. Alternatively, use the `update_starting.block.sh` script to update it to the current block minus 100.
