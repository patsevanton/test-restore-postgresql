resource "yandex_mdb_postgresql_cluster" "postgres" {
  name               = var.psql_service_name
  environment        = var.psql_service_env
  network_id         = var.psql_service_network_id
  description        = var.description
  host_master_name   = var.host_master_name
  security_group_ids = var.security_group_ids

  dynamic "restore" {
    for_each = var.backup_id == "" ? [] : [1]
    content {
      backup_id = var.backup_id
    }
  }

  config {
    version = var.psql_service_version
    resources {
      resource_preset_id = var.psql_service_resource_preset
      disk_type_id       = var.psql_service_disk_type
      disk_size          = var.psql_service_disk_size
    }

    access {
      data_lens = var.data_lens_access
      web_sql   = var.web_sql_access
    }

    backup_window_start {
      hours   = var.backup_hour
      minutes = var.backup_minute
    }
  }

  //noinspection HCLUnknownBlockType
  maintenance_window {
    type = var.maintenance_type
    day  = var.day
    hour = var.hour
  }

  dynamic "host" {
    for_each = [for s in var.placement : {
      zone   = s.zone
      subnet = s.subnet
    }]
    content {
      zone      = host.value.zone
      subnet_id = host.value.subnet
    }
  }

}

resource "yandex_mdb_postgresql_user" "pg_user" {
  cluster_id = var.backup_id != null ? yandex_mdb_postgresql_cluster.postgres.id : null
  name       = var.psql_user
  password   = var.psql_password
  conn_limit = var.connection_limit
  settings   = var.user_settings
  depends_on = [yandex_mdb_postgresql_cluster.postgres]
}


resource "yandex_mdb_postgresql_database" "pg" {
  for_each   = var.backup_id != null ? toset(var.psql_db_names) : null
  cluster_id = yandex_mdb_postgresql_cluster.postgres.id
  name       = each.key
  owner      = yandex_mdb_postgresql_user.pg_user.name
  lc_collate = "ru_RU.UTF-8"
  lc_type    = "ru_RU.UTF-8"

  dynamic "extension" {
    for_each = var.psql_db_extensions != null ? contains(keys(var.psql_db_extensions), each.key) ? [for ext_name in var.psql_db_extensions[each.key] : ext_name] : [] : []
    content {
      name = extension.value
    }
  }

}
