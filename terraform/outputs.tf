output "urls" {
  description = "Addresses of the web containers"
  value       = [for c in docker_container.web : "http://localhost:${c.ports[0].external}"]
}
