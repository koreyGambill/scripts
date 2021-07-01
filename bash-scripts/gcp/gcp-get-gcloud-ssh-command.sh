#!/bin/bash
#
# Lists gcloud ssh commands for all google computes in a gcp project

gcp_project=$1

gcloud compute instances list --project $gcp_project \
  | awk "{print \"gcloud beta compute ssh --zone \" \$2 \" \" \$1 \" --tunnel-through-iap --project $gcp_project\"}"