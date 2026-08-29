### Tech stack
Kubernetes platform
- Considered: minikube, kind, k3d
- Choice: k3d
- Reasons:
    - Lightweight (memory footprint). Can support creating a cluster from a config file (easier to set up)
    - minikube is heavier
    - kind is similar

### Assumptions
- Service needs to survive a node loss -> Needs to spread the replicas across nodes -> Use pod anti-affinity to avoid deploying pods on same node
- Even when two envs were mentioned, just need to deploy one env (prod)

### Production-facing suggestions
- Use an ingress controller or ingress gateway with multiple replicas to avoid single point of failure
- Enable autoscaling based on memory and cpu usage
- Monitor and collect metrics and set up alerts based on the metrics

### Things left out
- Dev env deployment. Usually I will deploy on another cluster. The configurations are pretty much the same
