output "zookeeper_connect_string" {
  value = aws_msk_cluster.msk_cluster.zookeeper_connect_string
}

output "bootstrap_brokers" {
  description = "PLAINTEXT connection host:port pairs"
  value       = aws_msk_cluster.msk_cluster.bootstrap_brokers 
}