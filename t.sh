sudo docker-compose down
sudo rm -rf ./db-data/
sudo docker-compose up -d --build postgres
