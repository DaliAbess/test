#! /bin/bash 
docker rm my-app 
docker rmi my-app-image:latest
echo "build image "
docker build -t my-app-image . 
echo "run symfony app container" 
docker run --name my-app -p 8000:8000 my-app-image:latest
echo "symfony server:start" 
docker exec -it my-app /bin/bash
