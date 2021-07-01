#!/bin/bash
#
# Lists all google compute instances in all gcp projects

allProjects=`gcloud projects list --format="csv[no-heading](PROJECT_ID)"`
for project in ${allProjects[@]}; do
  echo "$project"
  instances=`echo "N" | gcloud compute instances list --project $project 2>&1`
  if [[ "$instances" != "Listed 0 items." && "$instances" != *"PERMISSION_DENIED"* ]]; then
    echo "$project"
    echo "$instances"
  fi
done