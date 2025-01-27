#!/bin/bash

# Vérification des arguments requis
if [ "$#" -ne 2 ]; then
  echo "Usage: $0 <number_of_messages> <message_length>"
  exit 1
fi

# Nombre de messages à envoyer
num_messages=$1
# Longueur de chaque message
message_length=$2

# Ensure environment variables are set
if [ -z "$ROOT_URL" ]; then
  echo "Please set ROOT_URL environment variable."
  exit 1
fi

# Génération de contenu aléatoire pour un message
generate_random_message() {
  local length=$1
  openssl rand -base64 $((length * 3 / 4)) | tr -d '\n' | head -c "$length"
}

# Création d'un tableau JSON de messages
create_message_payload() {
  local count=$1
  local length=$2
  local messages=()
  for ((i = 1; i <= count; i++)); do
    messages+=("\"$(generate_random_message "$length")\"")
  done
  echo "{\"message\": [$(IFS=,; echo "${messages[*]}")]}"
}


# Envoi des messages
payload=$(create_message_payload "$num_messages" "$message_length")
status_code=$(curl -X POST --write-out "%{http_code}" --silent --output /dev/null \
  --location "${ROOT_URL}/observability/message/async" \
  --header "Accept: application/json" \
  --header "Content-Type: application/json" \
  --header "x-gateway-apikey: ${API_KEY}" \
  -u ${USER}:${PASSWORD} \
  --data "$payload")

