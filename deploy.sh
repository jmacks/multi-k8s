docker build -t jeffmacks/multi-client:latest -t jeffmacks/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t jeffmacks/multi-server:latest -t jeffmacks/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t jeffmacks/multi-worker:latest -t jeffmacks/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push jeffmacks/multi-client:latest
docker push jeffmacks/multi-server:latest
docker push jeffmacks/multi-worker:latest
docker push jeffmacks/multi-client:$SHA
docker push jeffmacks/multi-server:$SHA
docker push jeffmacks/multi-worker:$SHA

kubectl apply -f k8s

kubectl set image deployments/server-deployment server=jeffmacks/multi-server:$SHA
kubectl set image deployments/client-deployment client=jeffmacks/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=jeffmacks/multi-worker:$SHA

