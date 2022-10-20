output "fqdn_database" {
  value = "c-${yandex_mdb_postgresql_cluster.postgres.id}.rw.mdb.yandexcloud.net"
}
