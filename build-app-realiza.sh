#bajar los contenedores
docker compose down
#eliminar las imagenes de realiza
docker rmi realizaapp-fast-api-service 
docker rmi realizaapp-api-service 
docker rmi realizaapp-realiza-service
docker rmi realizaapp-web-service

#eliminar el volumen de BD 
docker volume rm realizaapp_database-data

# Construir imagenes desde cero
docker compose build --no-cache
# Levantar Dockers containers
docker compose up


