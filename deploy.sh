# Take in parameter stage {dev, prod}
if [ $# -eq 0 ]
  then
    echo "No arguments supplied. Please supply a stage {dev, prod}"
    exit 1
fi

# Check if logged in to gcloud

if ! gcloud auth list --filter=status:ACTIVE --format="value(account)" > /dev/null; then
  echo "You are not logged in to gcloud. Please login and try again."
  exit 1
fi

# Set gcloud project to zephyrapp-dev if in DEV stage or zephyrapp-prod if in PROD stage

if [ $1 = "dev" ]
  then
    gcloud config set project zephyrapp-dev
  elif [ $1 = "prod" ]
  then
    gcloud config set project zephyrapp-prod
  else
    echo "Invalid stage. Please supply a stage {dev, prod}"
    exit 1
fi

# Check if gcloud project is set and print it
if ! gcloud config list --format="value(core.project)" > /dev/null; then
  echo "You are not logged in to gcloud. Please login and try again."
  exit 1
else
  echo "Deploying to project: $(gcloud config list --format="value(core.project)")"
fi

# Build API dart-frog
cd zephyr_server/
dart_frog build

# Deploy API dart-frog
# Format
# gcloud run deploy [SERVICE_NAME] \
#   --source build \
#   --project=[PROJECT_ID] \
#   --region=[REGION] \
#   --allow-unauthenticated

gcloud run deploy zephyrapp-server \
  --source build \
  --project=$(gcloud config list --format="value(core.project)") \
  --region=us-central1 \
  --allow-unauthenticated

