output "fqdn_database" {
  value = "c-${yandex_mdb_postgresql_cluster.postgres.id}.rw.mdb.yandexcloud.net"
}

output "db_password" {
  value       = random_password.dbpass_pass.result
  sensitive   = true
  description = "DB password"
}

output "additional_users" {
  sensitive   = true
  value       = var.psql_additional_users != null ? { for user, pass in var.psql_additional_users : user => random_password.dbpass_pass_additional_users[user].result } : {}
  description = "Additional users passwords"
}
