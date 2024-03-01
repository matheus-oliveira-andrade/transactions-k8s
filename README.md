## Introdution

This project aims to provide an API for retrieving account movements, applying concepts like async comunications, observability and use of container orchestration. It is built upon the foundation of the [existing repository here](https://github.com/matheus-oliveira-andrade/transactions) and is designed to run seamlessly in a Kubernetes environment.

## Getting Started

Project to expose, through an API, the report of movements from the accounts. Transactions are created by the `Seed` console application and published to a topic in `RabbitMQ`, then read by the `Movements.AsyncReceiver` application, which processes and saves the data in the `PostgreSQL` database. This data is then exposed through the `Movements.Api` at the `/report/{{accountId}}` endpoint.

### How to run on Kubernetes using docker-desktop

1 - (optional) execute file [`build-push.sh`](build-push.sh) to build and push all docker images to docker hub
   ```bash
   ./build-push.sh # optional - require login in docker hub 
   ```   
2 - install ingress controller `ingress-nginx`

   ```bash
   # docs: https://kubernetes.github.io/ingress-nginx/deploy/#quick-start
   kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/controller-v1.8.2/deploy/static/provider/cloud/deploy.yaml

   ```

3 - execute file [`/k8s/create-secrets.sh`](/k8s/create-secrets.sh) to create secrets used by containers
   ```bash
   ./k8s/create-secrets.sh
   ```   
4 - Create all k8s resources
   ```bash
   kubectl apply -f k8s
   ```   
5 - Access movements public API 
   - swagger [http://localhost/movements/swagger](http://localhost/movements/swagger)
   - [movement report endpoint](http://localhost/movements/v1/report/123456-78)

### Technologies

- `C#` was used as the language with `.net 6`, following some of the concepts of `clean architecture`. For `unit tests`, `xunit` and `moq` were used.
- `Docker` was used for the application containers with `kubernetes` for container orchestration.
- `PostgreSQL` was chosen as the database.
- `RabbitMQ` was chosen as the message broker.
- `Fluentd` was used for log aggregation, sending the logs to `Elastic Search`.
- `Kibana` was used for log visualization.
- `GitHub Actions` were used for `CI` while the application was being developed, built, and tested on each push.

### Architecture

![image](https://github.com/matheus-oliveira-andrade/transactions/assets/32457879/1ab7e4cd-bb39-4ff9-bf0a-b5a9e4f57d06)

