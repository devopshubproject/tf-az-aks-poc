# provider "kubernetes" {
#   version = "~> 2.4.1" # Specify the version range you want to use
# }


# # Kubernetes deployment for the Hello World application
# resource "kubernetes_deployment" "hello_world" {
#   metadata {
#     name = "hello-world"
#     labels = {
#       app = "hello-world"
#     }
#   }

#   spec {
#     replicas = 3

#     selector {
#       match_labels = {
#         app = "hello-world"
#       }
#     }

#     template {
#       metadata {
#         labels = {
#           app = "hello-world"
#         }
#       }

#       spec {
#         container {
#           image = "nginx:latest"
#           name  = "nginx"
#           port {
#             container_port = 80
#           }
#         }
#       }
#     }
#   }

#   depends_on = [azurerm_kubernetes_cluster.aks]
# }

# # Kubernetes service to expose the Hello World application
# resource "kubernetes_service" "hello_world_svc" {
#   metadata {
#     name = "hello-world-svc"
#     labels = {
#       app = "hello-world"
#     }
#   }

#   spec {
#     selector = {
#       app = "hello-world"
#     }

#     port {
#       port        = 80
#       target_port = 80
#     }

#     type = "LoadBalancer"
#   }

#   depends_on = [kubernetes_deployment.hello_world]
# }
