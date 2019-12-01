docker build -t ubik74/multi-client:latest -t ubik74/multi-client:$GIT_SHA -f ./client/Dockerfile  ./client
docker build -t ubik74/multi-server:latest -t ubik74/multi-server:$GIT_SHA -f ./server/Dockerfile  ./server
docker build -t ubik74/multi-worker:latest -t ubik74/multi-worker:$GIT_SHA -f ./worker/Dockerfile  ./worker

docker push ubik74/multi-client:latest
docker push ubik74/multi-server:latest
docker push ubik74/multi-worker:latest

docker push ubik74/multi-client:$GIT_SHA
docker push ubik74/multi-server:$GIT_SHA
docker push ubik74/multi-worker:$GIT_SHA

kubectl apply -f k8s --force

kubectl set image deployments/server-deployment server=ubik74/multi-server:$GIT_SHA
kubectl set image deployments/client-deployment client=ubik74/multi-client:$GIT_SHA
kubectl set image deployments/worker-deployment worker=ubik74/multi-worker:$GIT_SHA
